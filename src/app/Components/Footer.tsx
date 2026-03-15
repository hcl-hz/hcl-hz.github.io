import Link from "next/link";
import { FaGithub } from "react-icons/fa6";
import { SiNotion } from "react-icons/si";
import type { IconBaseProps } from "react-icons";
import "../Styles/footer.scss";
import { LanguageSelector } from "./LanguageSelector";

export const Footer = () => {
  return (
    <div className="footer">
      <div className="footer_left">
        <h1>HCL&apos;s Space</h1>
        <LanguageSelector />
      </div>
      <div className="footer_mid">
        © 2026 HCL&apos;s Space. All rights reserved.
      </div>
      <div className="footer_right">
        <div className="social_links">
          <Link
            href="https://github.com/Russ481-k"
            target="_blank"
            rel="noopener noreferrer"
            className="social_link"
            aria-label="GitHub Profile"
          >
            {FaGithub({ size: 16 } as IconBaseProps)}
          </Link>
          <Link
            href="https://binsspace.notion.site/Bin-s-Space-1ebe0875dc7442cc91f7e1defc3802ab"
            target="_blank"
            rel="noopener noreferrer"
            className="social_link"
            aria-label="Notion Page"
          >
            {SiNotion({ size: 16 } as IconBaseProps)}
          </Link>
        </div>
      </div>
    </div>
  );
};
