# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Bilingual (EN/KO) developer portfolio and blog built with Next.js 13 App Router, statically exported to GitHub Pages.

## Commands

```bash
npm run dev           # Start dev server
npm run build         # Production build (runs generate-posts-db.ts as prebuild)
npm run start         # Serve static output from out/
npm run lint          # ESLint (next/core-web-vitals)
npm run deploy        # Build + deploy to GitHub Pages via gh-pages
npm run generate:db   # Regenerate post database from Supabase (prebuild step)
npm run convert:md    # Convert markdowns (tsx src/scripts/convert-markdowns.ts)
npm run migrate:db    # Migrate local markdown posts to Supabase
```

**Build requires `.env.local`** with Supabase credentials:
```
NEXT_PUBLIC_SUPABASE_URL=...
NEXT_PUBLIC_SUPABASE_ANON_KEY=...
```

## Architecture

### Routing

- **Root** (`/`) — redirects to `/{fallbackLng}` (en) via `src/app/page.tsx`
- **`/(lang)/[lang]`** — route group for language pages; `generateStaticParams` emits `en` and `ko`; `notFound()` on unknown lang
- **`/admin`** — admin dashboard with Lexical rich-text post editor (not statically exported, dev-only)
- **API routes**: `GET /api/posts` (all posts), `GET /api/post/[slug]` (single post) — read from `/posts/ko/*.md` and `/posts/en/*.md` via `src/utils/markdownLoader.ts`

### Content System (Two Paths)

There are two distinct content flows that currently coexist:

1. **Supabase → prebuild** (`generate-posts-db.ts`): Fetches all posts from Supabase, converts markdown to HTML, and writes:
   - `public/data/posts.json` — all posts array
   - `public/data/posts/[slug].json` — individual post JSON
   - `public/posts/ko/[slug].html` / `public/posts/en/[slug].html` — rendered HTML files

2. **Markdown files → API routes** (`markdownLoader.ts`): At runtime (dev/static), API routes read `/posts/ko/*.md` and `/posts/en/*.md` directly with `gray-matter`. The client (`src/utils/clientPosts.ts`) fetches from these API routes.

Post front matter schema: `title`, `date`, `category`, `tags`, `thumbnail`, `description`.

Categories (defined in `src/constants/categoryOrder.ts`): `about`, `career`, `projects`, `architecture`, `database`, `backend`, `frontend`. The "all" category is added dynamically in the UI.

### Key Patterns

- **Static export**: `output: "export"` in `next.config.js`, images unoptimized
- **i18n**: i18next initialized globally and **synchronously** in `src/app/i18n/index.ts` (imported by `ClientLayout`) to avoid hydration mismatches. Translation resources are bundled in `src/app/i18n/resources.ts`. The `[lang]` segment drives `i18n.changeLanguage()` in `ClientLayout`. `suppressHydrationWarning` is set on `<html>` and `<body>` pending a full hydration fix.
- **Styling**: SCSS in `src/app/Styles/` — variables in `_variables.scss`, mixins in `_mixins.scss`, responsive breakpoints at 768px/1024px/1280px, dark blue theme (`#0e2954`) with glass morphism
- **Path alias**: `@/*` maps to `./src/*`
- **State**: React hooks only (no external state library)
- **Modals**: Portal-based pattern via `ModalPortal.tsx`; target `<div id="modal-root" />` is rendered in the layout
- **Post HTML rendering**: `PostDetail` renders processed HTML via `dangerouslySetInnerHTML`

### Deployment

GitHub Actions workflow (`.github/workflows/deploy.yml`) builds and deploys to GitHub Pages using `gh-pages`.
