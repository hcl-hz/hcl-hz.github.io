import { useEffect, useState } from "react";
import {
  cleanWord,
  properNounsSet,
  properNounsLowerMap,
  properNounsStrippedMap,
} from "@/constants/techKeywords";

export interface KeywordEntry {
  word: string;
  count: number;
  isTechStack: boolean;
}

export function useKeywordExtraction(searchResults: string[]): KeywordEntry[] {
  const [keywords, setKeywords] = useState<KeywordEntry[]>([]);

  useEffect(() => {
    if (searchResults.length > 0) {
      // 단어 분리 로직 수정
      const words = searchResults
        .join(" ")
        .replace(/https?:\/\/\S+/g, "") // URL 제거
        .replace(/\b\w+:\/\/\S+/g, "")  // 기타 프로토콜 제거
        .split(/[\s/,()[\]{}]+/)
        .map((word) => {
          const cleanedWord = cleanWord(word);

          // 한글 단어 처리
          if (/[\uAC00-\uD7AF]/.test(cleanedWord)) {
            return cleanedWord.length >= 2 ? cleanedWord : "";
          }

          // 영문 단어 처리
          if (cleanedWord.length > 1 && !/^\d+$/.test(cleanedWord)) {
            // O(1) lookup via Set instead of O(n) .includes()
            const upperWord = cleanedWord.toUpperCase();
            if (properNounsSet.has(upperWord)) {
              return upperWord;
            }

            const capitalizedWord =
              cleanedWord.charAt(0).toUpperCase() +
              cleanedWord.slice(1).toLowerCase();
            if (properNounsSet.has(capitalizedWord)) {
              return capitalizedWord;
            }
          }

          return cleanedWord;
        })
        .flatMap((word) => word.split(" ")) // 공백으로 분리된 단어들을 평탄화
        .filter((word) => {
          // 빈 문자열, 숫자, 콜론 포함 단어(URL 잔재) 제거
          return word && word.length > 1 && !/^\d+$/.test(word) && !word.includes(":");
        });

      // 단어 빈도수 계산
      const wordCounts = words.reduce(
        (acc: Record<string, number>, word: string) => {
          // O(1) exact match via Set
          if (properNounsSet.has(word)) {
            acc[word] = (acc[word] || 0) + 1;
            return acc;
          }

          // O(1) case-insensitive and stripped lookups via Maps
          const lowerWord = word.toLowerCase();
          const properNoun =
            properNounsLowerMap.get(lowerWord) ||
            properNounsStrippedMap.get(lowerWord);

          if (properNoun) {
            acc[properNoun] = (acc[properNoun] || 0) + 1;
            return acc;
          }

          // properNouns에 없는 일반 단어는 키워드로 포함하지 않음
          return acc;
        },
        {}
      );

      // 빈도수로 정렬하고 불용어(중요하지 않은 단어) 필터링
      const sortedKeywords = Object.entries(wordCounts)
        .map(([word, count]) => ({
          word,
          count,
          isTechStack: properNounsSet.has(word),
        }))
        .sort((a, b) => {
          if (a.isTechStack && !b.isTechStack) return -1;
          if (!a.isTechStack && b.isTechStack) return 1;
          return b.count - a.count;
        })
        .slice(0, 30);

      setKeywords(sortedKeywords);
    }
  }, [searchResults]);

  return keywords;
}
