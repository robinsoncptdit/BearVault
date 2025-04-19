# MP2AI PRD v 1.0
## MVP — “MP Coach” Portal  
**Version 1.0** • **Date 19 Apr 2025**  
**Product Manager:** Chuck Robinson  

---

### 1  Executive Summary  
Parish staff who coordinate events and groups in Ministry Platform (MP) waste time hunting through feature‑oriented help pages. **MP Coach** is a 30‑day proof‑of‑concept that gives them one lightweight web portal—with a search bar, a Top‑10 article list, an on‑demand AI chat assistant, and a single “Getting Started” mini‑course—so they can answer their own questions in seconds. The MVP will be demo‑ready for ACST leadership and diocesan stakeholders; no deep analytics or multi‑persona support is included.

---

### 2  Goals & Success Criteria  
| Goal | Measure at Demo (Day 30) |
|------|--------------------------|
| Show that role‑filtered docs are discoverable | Search returns relevant snippet for 3 sample questions (live demo). |
| Prove LLM chat can cite MP docs | Chat answers 3 free‑form questions with citations shown. |
| Deliver starter course content | “Events & Groups Coordinator Basics” page renders and PDF downloads. |
| Foundation for future expansion | Codebase in Next.js + Supabase with embeddings and modular APIs. |

---

### 3  In‑Scope Functionality  

#### 3.1  Portal  
| ID | Requirement |
|----|-------------|
| **FR‑P‑1** | User lands on `/` and sees search input + Top‑10 article list. |
| **FR‑P‑2** | Clicking an article opens the original MP KB page in a new tab. |
| **FR‑P‑3** | Banner link “New Events & Groups Coordinator? Start here” opens the course page. |

#### 3.2  Search API  
| ID | Requirement |
|----|-------------|
| **FR‑S‑1** | `GET /api/search?q=` returns top 3 snippets by cosine similarity (pgvector). |
| **FR‑S‑2** | Response includes `title`, `snippet`, `url`, `score`. |

#### 3.3  Chat Assistant  
| ID | Requirement |
|----|-------------|
| **FR‑C‑1** | Floating button opens chat panel; user types natural‑language question. |
| **FR‑C‑2** | Backend builds prompt ← top 3 search snippets + user question. |
| **FR‑C‑3** | Answer streams from GPT‑3.5; each cited doc displays as a link. |
| **FR‑C‑4** | User may ask a follow‑up within same panel (simple thread ID). |

#### 3.4  Mini‑Course  
| ID | Requirement |
|----|-------------|
| **FR‑M‑1** | Route `/course/events-groups-coordinator` renders MDX lesson with five tasks: create event, configure registration, build roster, send email, run attendance report. |
| **FR‑M‑2** | Each task block shows description, link to MP KB, and “Ask in Chat” pre‑fill button. |
| **FR‑M‑3** | Build generates downloadable 1‑page PDF cheat‑sheet. |

#### 3.5  Auth & Security  
| ID | Requirement |
|----|-------------|
| **FR‑A‑1** | Portal gated by single shared password (NextAuth credentials provider). |
| **FR‑A‑2** | All traffic HTTPS; .env keys kept server‑side. |
| **FR‑A‑3** | Row‑Level Security disabled only for `docs` table (read‑only) during MVP. |

#### 3.6  Public Read‑Only API *(new)*  
| ID | Requirement |
|----|-------------|
| **FR‑API‑1** | Expose `GET /api/search` and `POST /api/chat` for partner systems. |
| **FR‑API‑2** | Provide JSON OpenAPI spec at `/api/openapi.json`; interactive docs at `/docs`. |
| **FR‑API‑3** | Require `Authorization: Bearer <token>` header; tokens stored hashed in Supabase table `api_tokens`. |
| **FR‑API‑4** | Enable CORS for whitelisted domains (`*.freshservice.com`, `n8n.local`, `*.ptdiocese.org`). |
| **FR‑API‑5** | Soft rate‑limit 60 requests / minute / token; return HTTP 429 on breach. |

---

### 4  Out‑of‑Scope for MVP  
* Write‑back endpoints (feedback or document ingestion)  
* Freshservice UI integration  
* Multiple personas or progress tracking  
* Telemetry dashboards and success KPIs  
* Mobile app or offline support  

---

### 5  Technical Approach  

| Layer | Choice | Rationale |
|-------|--------|-----------|
| Frontend | Next.js 14 + Tailwind | Rapid dev; deploy on Vercel. |
| Backend APIs | Next.js API routes | Unified stack; easy Vercel deploy. |
| Vector DB | Supabase Postgres `pgvector` (us‑east‑1) | Managed; low‑latency. |
| Embeddings | OpenAI `text-embedding-3-small` | Cheap; good for small corpus. |
| LLM | GPT‑3.5‐turbo; optional GPT‑4o at demo | Balance cost vs. quality. |
| Scraper | Python + BeautifulSoup | Simple; no login required. |
| PDF generator | `html-pdf` at build time | Zero extra infra. |
| API Auth | Bearer tokens; Supabase table | Lightweight, script‑friendly. |
| CORS | `next.config.js` headers | Restricts origins per FR‑API‑4. |

---

### 6  Content Scope  

| Type | Quantity |
|------|----------|
| MP KB articles ingested | ~35 |
| Text chunks (~500 tokens) | ≈ 400 |
| Course tasks | 5 |
| Cheat‑sheet pages | 1 |

---

### 7  Milestones & Owners  

| Day | Deliverable | Owner |
|-----|-------------|-------|
| 5 | Supabase + docs table + 25 articles embedded | LE • C‑Dev |
| 12 | `/api/search`, `/api/chat`, bearer auth, CORS, OpenAPI spec | C‑Dev |
| 17 | Portal home page with search + Top‑10 | C‑Dev |
| 19 | Chat widget live | C‑Dev |
| 20 | Course page & PDF build | C‑Dev • LE |
| 24 | Auth, banner, pilot invite sent | LE |
| 30 | Live demo (`coach.ptdiocese.org`) | LE |

---

### 8  Risks & Mitigations  

| Risk | Impact | Mitigation |
|------|--------|------------|
| MP KB layout changes break scraper | No new docs | Keep XPath simple; manual patch OK. |
| API token leak | Unauthorized usage | Revoke token; rotate quarterly. |
| LLM latency too high | Poor demo | Cache embeddings; limit `max_tokens`. |
| Budget overrun | Slip schedule | Cap C‑Dev at 60 h; weekly burn review. |

---

### 9  Stakeholders  

| Role | Name |
|------|------|
| Sponsor / PM | Chuck Robinson |
| Lead Engineer | TBD |
| Contract Dev | TBD |
| Pilot Users | 10 Events & Groups Coordinators |
| External | ACST Product & Success |

---

### 10  Approval  

| Role | Signature | Date |
|------|-----------|------|
| Product Manager |  |  |
| Sponsor |  |  |
| Lead Engineer |  |  |

---

### Appendix A – Glossary  
* **MP** — Ministry Platform  
* **MVP** — Minimum Viable Product  
* **RAG** — Retrieval‑Augmented Generation  
* **Top‑10** — Manually curated list of key Coordinator articles  

*End of Document*
#MP2AI