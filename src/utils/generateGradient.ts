const generateColorFromHash = (str: string, index: number = 0) => {
  // 문자열을 해시값으로 변환
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    hash = str.charCodeAt(i) + ((hash << 5) - hash);
  }

  // 포트폴리오 색상 (Garnet ~ Dusty Rose, 345-355도)
  const baseHue = 345;
  const hueRange = 10;
  const h = baseHue + (Math.abs(hash + index * 5) % hueRange);

  // 채도 중간, 명도는 썸네일용으로 적당히 밝게
  const s = 35 + (Math.abs(hash) % 15); // 채도 35-50%
  const l = 58 + (Math.abs(hash) % 10); // 명도 58-68%

  return `hsl(${h}, ${s}%, ${l}%)`;
};

interface GradientResult {
  colors: string[];
  angle: number;
  gradient: string;
}

export const generateGradient = (postId: string): GradientResult => {
  const color1 = generateColorFromHash(postId);
  const color2 = generateColorFromHash(postId, 1);
  const angle =
    Math.abs(
      postId.split("").reduce((acc, char) => acc + char.charCodeAt(0), 0)
    ) % 360;

  return {
    colors: [color1, color2],
    angle: angle,
    gradient: `linear-gradient(${angle}deg, ${color1}, ${color2})`,
  };
};
