# MP2AI Executive Steer
### Executive steer

Given your answers, Route A (wrapper/MVP first) is still the fastest, cheapest, and politically safest path.  The goal is to have something your seasoned users can click on inside 30 days, prove it lowers confusion/ticket volume, and take that success story into your ACST roadmap meeting as the embryo of a jointly funded product.

Below is a concrete 30‑day sprint plan, resourcing advice, and a “telemetry‑to‑NP” lane so the work you do now naturally seeds a future, fully agentic platform.

⸻


## 0  Choose one persona for the MVP

Pick the role that (a) generates the loudest complaints and (b) has well‑bounded workflows so success can be measured quickly.

**Candidate**	**Why it’s attractive**	**Why it might not be**
**Parish Bookkeeper**	• High‑frequency tasks (gifts, batches, reports) → abundant data for evaluation.• Immediate financial impact gets C‑Suite’s attention.	• Touches payments & PII → early security scrutiny.
**Event / Group Coordinator**	• Relatively low PII risk.• Workflows easy to map (create event, register, roster).	• Less visible to C‑Suite, ROI feels “softer.”

### *Action*: lock this by Day 1 of the sprint.

⸻


## 1  30‑day build sprint (one‑week timeboxes)

**Week**	**Outcome**	**Key tasks**	**Tools/people**
**1 — Content harvest & tagging**	• All docs for the chosen persona scraped & chunked.• Metadata JSON: {url, title, persona, mp_module, difficulty}	– Use **ScrapeGraph** or **Apify** + simple Python.– Auto‑tag via GPT‑4o classification prompt.– Store chunks & embeddings in **Supabase/pgvector**.	*You* (3 evenings)+ 1099 Python dev (20 hrs)
**2 — RAG API stub**	• /query endpoint that returns top‑k passages + citations.	– LangChain (RetrievalQA).– OpenAI text-embedding-3-small for cost.– FastAPI deployed on Fly.io or Render.	1099 backend dev (30 hrs)
**3 — Thin UI**	• Next.js page “MP Coach (Beta)”• Role dropdown pre‑filters answers.• “Send feedback” button dumps to Supabase.	– Use **Cursor** AI‑pairing to scaffold.– Tailwind for speed.	1099 front‑end dev (30 hrs)
**4 — Integration & test**	• Microsoft Teams tab or web‑embed.• Pilot group of 5–10 seasoned users.• Instrumentation (PostHog or RudderStack).	– Auth via Azure AD SSO.– Log: query text, latency, thumbs‑up/down.	*You* + pilot users

### Cost rough‑cut
• 1099 hours ≈ 80–90 → $8‑12 k
• SaaS infra & OpenAI tokens → <$300 mo

If funding falls through, this is still within the diocese’s discretionary IT spend.

⸻


## 2  Success metrics to carry into the ACST meeting

**Metric**	**Baseline you can pull now**	**Target for MVP demo**
Avg. “how‑to” tickets / week for chosen persona	e.g., 12	↓ 40 %
First‑response time from IT	e.g., 18 h	↓ 50 %
Self‑service success thumbs‑up	0	> 70 % positive

### Take screenshots of the live pilot, plus a one‑pager that maps metrics to $ staff hours saved.

⸻


## 3  Architecture choices that future‑proof for NP
### 1.Content layer = supabase_pgvector
### *Stays useful whether you keep wrapping MP or replace it.*
### 2.Telemetry layer = event warehouse
Pipe every search, click, and failed answer into Supabase → later drives which MP tables/workflows you automate or rebuild first.
### 3.Isolation of PII
Store only doc chunks & anonymous usage.  Actual donor‑level or sacramental data never touches the LLM in Route A. This eases security approvals yet keeps the door open for a deeper NP later.
### 4.Plugin‑friendly RAG API
Design the FastAPI service so new front ends (Freshservice Freddy plugin, public chat widget, LMS quiz generator) can all call the same /query and /answer endpoints.

⸻


## 4  How today’s work seeds tomorrow’s NP

**Milestone in wrapper track**	**Data / insight it unlocks**	**NP feature it accelerates**
Logs show 80 % of queries are about “batch posting errors.”	You know *exactly* which MP workflow causes friction.	Build an agent that auto‑validates batch data before post, or auto‑posts.
Feedback flag “answer unclear” links to 12 specific KB pages.	Those pages need rewrite or screen‑record Scribe flow.	Same flows become the training set for a future agent that *does* the steps.
Time‑to‑first‑answer drops from 30 s → 5 s after embedding cache tweak.	Proves vector search latency matters.	NP infra spec: embed DB must serve <200 ms globally.




⸻


## 5  Resource strategy — making 1 FTE feel like 4

**Gap**	**Mitigation**	**Comment**
Backend hours	Contract dev (Upwork/TopTal) for **4 weeks**	Give them tight tickets inside GitHub; pair with Cursor code‑gen to cut grunt work.
Front‑end polish	Use **Vercel AI SDK** boilerplates	Cut-and‑paste chat template then skin with diocesan branding.
Tech writing	Lean on **Scribe** or **Loom** to capture micro‑flows; AI autotranscribe into step text.	Even if Scribe lacks open API, a part‑time intern can record 10 flows/day.




⸻


## 6  Conversation prep for ACST

**Slide**	**Talking point**
**1. The problem (1 week of real ticket data)**	“12 bookkeeper tickets/week → $X labor. 80 % are lookup questions.”
**2. Tiny solution demo (live)**	30‑sec query → answer with KB citation.
**3. Early metrics**	↓ 40 % tickets, ↑ 70 % satisfaction in pilot.
**4. Ask**	“Seed fund $150 k to turn this from 1‑persona MVP into 5‑persona product in 6 months. Joint IP ownership / rev‑share proposed.”




⸻


## 7  Open items (need your go‑/no‑go)
### 1.Choose MVP persona — confirm by tomorrow.
### 2.Green‑light 1099 budget — ceiling $12 k.
### 3.Pick vector DB region — likely us‑east‑1 (close to MP servers).
### 4.Agree on metric capture tool — PostHog vs RudderStack.

Reply with those decisions or tweaks, and I’ll draft the Week‑1 task board and first scraping prompt set so you (or the contractor) can start Monday.
#MP2AI/GPTo3