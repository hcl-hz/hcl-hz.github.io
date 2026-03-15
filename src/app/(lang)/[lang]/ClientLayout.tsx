"use client";

import { useEffect } from "react";
import { useTranslation } from "react-i18next";
import { Header } from "@/app/Components/Header";
// Importing the module triggers the global i18next initialization
import "@/app/i18n";

export default function ClientLayout({
  children,
  params: { lang },
}: {
  children: React.ReactNode;
  params: { lang: string };
}) {
  const { i18n } = useTranslation();

  useEffect(() => {
    if (i18n.language !== lang) {
      i18n.changeLanguage(lang);
    }
    document.documentElement.lang = lang;
  }, [lang, i18n]);

  return (
    <>
      <Header />
      {children}
    </>
  );
}
