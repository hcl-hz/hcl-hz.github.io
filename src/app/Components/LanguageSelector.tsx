"use client";

import { useState, useEffect } from "react";
import { usePathname, useRouter } from "next/navigation";
import { useTranslation } from "react-i18next";

export const LanguageSelector = ({ disabled }: { disabled?: boolean }) => {
  const { i18n } = useTranslation("common");
  const router = useRouter();
  const pathname = usePathname();
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  const toggleLanguage = async () => {
    if (disabled) return;
    try {
      const nextLang = i18n.resolvedLanguage === "ko" ? "en" : "ko";

      // 디버깅을 위한 로그
      console.log("Current pathname:", pathname);

      // 기본 경로 처리
      let newPathname;
      if (pathname === "/") {
        newPathname = `/${nextLang}`;
      } else {
        // 현재 경로에서 언어 부분 변경
        const pathParts = pathname.split("/").filter(Boolean);
        if (pathParts[0] === "ko" || pathParts[0] === "en") {
          pathParts[0] = nextLang;
        } else {
          pathParts.unshift(nextLang);
        }
        newPathname = "/" + pathParts.join("/");
      }

      console.log("New pathname:", newPathname);

      await i18n.changeLanguage(nextLang);
      router.replace(newPathname);
    } catch (error) {
      console.error("Language toggle error:", error);
    }
  };

  const lang = mounted ? i18n.resolvedLanguage : "ko";

  return (
    <div className="language_selector">
      <button className="lang_btn" onClick={toggleLanguage}>
        {lang === "en"
          ? disabled
            ? "English"
            : "eng"
          : disabled
          ? "Korean"
          : "kor"}
      </button>
    </div>
  );
};
