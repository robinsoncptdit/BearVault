# 02 MP2AI backend_tasklist
<!-- 02_backend_tasklist.md -->

# Back‑end Task List (API + Ingestion)

## A. Next.js API Routes

| Endpoint | Method | Responsibility | Auth |
|----------|--------|----------------|------|
| `/api/search` | GET | Return top 3 doc snippets | Bearer OR portal session |
| `/api/chat` | POST | RAG prompt → stream GPT answer | Bearer OR session |
| `/api/top10` | GET | Return curated Top‑10 list | Public |
| `/api/openapi.json` | GET | Serve OpenAPI spec | Public |

Tasks
1. [ ] Create `lib/db.ts` Supabase client (service role secret).
2. [ ] Implement `vectorSearch(query, k=3)`.
3. [ ] Build prompt assembler (`prompt.ts`) with citation tags.
4. [ ] Stream GPT‑3.5 responses via `fetch` & Node Streams.
5. [ ] Middleware to validate `Authorization` bearer token and rate‑limit 60 req/min.

## B. Python Scraper & Embedding Pipeline

1. [ ] Read `urls.txt` (provided separately).
2. [ ] Fetch HTML (requests + BeautifulSoup), strip nav.
3. [ ] Convert to Markdown; split into ~500‑token chunks.
4. [ ] Classify persona = `"events_groups_coordinator"`.
5. [ ] Upsert into Supabase `docs`.
6. [ ] Call OpenAI `text-embedding-3-small`; store vector.
7. [ ] Log failures; retry w/ exponential back‑off.
8. [ ] GitHub Actions workflow:
   ```yaml
   schedule: "0 3 * * *"  # nightly ETL
   jobs: python scrape.py
#MP2AI/software-engineer