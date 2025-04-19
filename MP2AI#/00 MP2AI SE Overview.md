# 00 MP2AI SE Overview

<!-- 00_overview.md -->

**Purpose**  
Provide a single‑page Next.js portal (search, Top‑10, chat) backed by a small Python ingestion service that scrapes Ministry Platform KB articles, embeds them, and stores them in Supabase (Postgres + pgvector). All infrastructure lives in `us‑east‑1`.

## High‑Level Architecture
Portal (Next.js 14)  —REST—>  API Routes    —SQL/Vector—>  Supabase
|  /            |                |  /api/search             |
|  /docs API    |                |  /api/chat               |
|  Chat widget  |                |  /api/openapi.json       |
^                                        ^
|                                        |
Storybook (UI lib)            Python scraper → embeddings
nightly delta job

| Layer | Stack | Notes |
|-------|-------|-------|
| Front‑end | Next.js 14 (App Router) + Tailwind tokens from UX | Deployed on Vercel |
| API | Next.js API routes | Search, Chat, OpenAPI spec |
| DB | Supabase Postgres w/ `pgvector` | Tables: `docs`, `top10`, `api_tokens` |
| Ingestion | Python 3.11, BeautifulSoup, `supabase-py`, OpenAI client | Runs locally or GitHub Actions CRON |
| Auth | Shared password (portal) & bearer tokens (public API) | Move to SSO post‑MVP |
| Deploy | Vercel (front/API)  •  Supabase hosted  •  GitHub Actions for scraper | |

#MP2AI# #MP2AI/software-engineer