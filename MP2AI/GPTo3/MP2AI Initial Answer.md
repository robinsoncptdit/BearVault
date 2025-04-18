# MP2AI Initial Answer
### Below is a first‑pass strategic analysis rather than a definitive “do this / don’t do that.”
### I’ve flagged the key decision points I think matter most, surfaced several blind‑spots that merit a quick reality‑check, and left you with a short list of questions whose answers will let us tighten the recommendation in the next round.

⸻


## 1  What you hope to solve

**Pain‑point today**	**Immediate value you want**	**“North‑Star” vision you hinted at**
**Users can’t find the right how‑to fast enough; time to proficiency is long.**	Persona‑based learning paths and in‑context help so that a parish bookkeeper (for example) can finish *this* task in MP in <5 min with <3 clicks.	Replace MP’s manual workflows altogether with an agentic layer that does the work for them.
**ACST content is organized by feature, not by role or job‑to‑be‑done.**	A wrapper (RAG + search + chat) that re‑indexes their docs by persona.	New product (NP) that talks directly to parishioners & donors, eliminating staff data entry.
**IT receives tickets whose answers are actually in the KB, but buried.**	Freshservice Freddy (or similar) autocompletes 60‑70 % of tickets.	Eventually, the system closes tickets before users even open them, via AI agents.




⸻


## 2  Two broad build routes

	**Route A — Middleware wrapper first**	**Route B — Skip wrapper, build NP from scratch**
**Speed to first win**	3–6 months to an MVP chat/KB that re‑uses ACST content.	12–24 months before a parish sees *any* end‑user value.
**Technical bite‑size**	RAG indexing, persona tagging, API stitching, LMS sequencing. All well‑trodden patterns.	Must re‑create donor, giving, sacraments, groups, permissions, reports, accounting integrations, etc., **plus** all the AI magic. Heavy lift.
**Cost & risk**	Low–medium. You pay mostly for: crawling + vector storage, LLM calls, UI surface, and some DevOps.	High. New data model, security, compliance, migrations, parity testing, certifications. 7‑figure budget territory.
**Strategic upside**	➀ Immediate UX improvement ➁ Gives you telemetry on what people actually search / fail at → informs NP later.	➀ Full control of the stack ➁ You’re not beholden to MP’s API limitations.
**IP / licensing hurdles**	Need ACST’s blessing (or explicit license) to republish their docs inside your tool; usually doable under “customer‑controlled data” terms.	No scrape‑and‑republish issue, but you still need bulk data export rights to move off MP.

### My default bias for most organisations your size is Route A (shipping incremental value while de‑risking Route B), unless:
	* 	you already have a funded team that can sustain a two‑year burn; and
	* 	ACST’s APIs or licensing terms are so restrictive that a wrapper can never work; and
	* 	the diocese is philosophically ready to migrate all critical data to a green‑field system.

⸻


## 3  Hidden dragons to check before you break ground
### 1.Content‑licensing – ACST might be happy for you to consume their KB, but they can still balk at large‑scale republication under your own brand.
### 2.Personally identifiable information (PII) – If you feed sacramental or giving data into an LLM‑powered agent you’ll need solid data‑segmentation and audit trails to stay inside both US diocesan norms and GDPR‑style privacy rules for EU visitors.
### 3.API rate limits – MP’s current public API tops out at ~60 requests/minute tenant‑wide. A real‑time agent that shadows every user click could blow through that quickly.
### 4.Freshservice Freddy limitations – Freddy still answers only from the Fresh KB unless you push custom embeddings via their (still‑beta) API. Worth confirming roadmap timelines.
### 5.Copyright on Academy videos – Automatic transcription for RAG counts as derivative work; less risky if ACST signs off.

⸻


## 4  Questions that would tilt the decision
### 1.Timeline & budget
### *What capex and opex envelope did leadership give you?*  e.g., “<$100 k in Year 1” almost forces Route A
### 2.Political capital
### *Will parish staff tolerate an 18‑month rebuild blackout, or do you need quick wins to keep them engaged?*
### 3.Licence posture
### *Do you already have a written agreement with ACST that allows full data export + derivative use of content?*
### 4.Internal dev capacity
### *How many FTE engineers (or vendor hours) can you realistically allocate?*
### 5.Long‑term vision
### *Is the diocese ultimately willing to sunset MP and own a bespoke system? Or is that a bridge too far?*

Answering those will let us sharpen a go / no‑go and map a phased plan.

⸻


## 5  If we start with Route A, a pragmatic phased roadmap

**Phase**	**Duration**	**Outcome**
**0. Stake & scope**	2 wks	ACST licence signed, success‑metric KPIs agreed (e.g., reduce “how‑do‑I” tickets by 40 %).
**1. Data ingestion & tagging**	4 wks	Scraper + PGVector in Supabase; metadata schema for persona, MP‑module, and difficulty.
**2. RAG prototype**	3 wks	Basic “Ask MP‑Coach” chat bot inside MS Teams; evaluate hallucination rate.
**3. Persona landing pages**	3 wks	Static site (Next.js) that lists *Just‑Enough‑to‑Do‑My‑Job* tasks for each role.
**4. Freshservice integration**	4 wks	Freddy extension or stop‑gap slash‑command that pastes top 3 answers into ticket.
**5. LMS sequencing**	6 wks	On‑ramp mini‑courses auto‑generated from RAG snippets + Scribe flows + quizzes.
**6. Instrumentation**	parallel	Event tracking (Segment + Supabase) so we learn which tasks are still manual → fuels NP.

### Total ≈ 4–5 months to first measurable ROI.

If the numbers look good after Phase 4, you can either scale the wrapper or divert part of the team to begin architecting the NP, using the wrapper’s logs to prioritise which MP features to automate first.

⸻


## 6  Alternative turnkey / low‑code options worth a look

**Need**	**Off‑the‑shelf candidates**	**API status**
In‑app walkthroughs	**WalkMe, Userflow, Stonly, Whatfix**	Full REST, JavaScript SDKs available.
Persona‑filtered KB search	**Stonly**, **Document360** with custom taxonomies	REST & web‑hook push for ingestion.
Lightweight LMS	**WorkRamp**, **TalentLMS**, **Northpass**	All have SCORM + API; can import Scribe/Tango flows.
Chat‑first help	**Intercom Fin**, **Drift Help**, **Mendable**	Bring‑your‑own‑embeddings and role routing.

### These still need content prep but save you building UI plumbing from scratch.

⸻


## Next step

### *Shoot back answers to the five questions in §4 (even quick ball‑park numbers are fine). That will let me draft a costed decision tree and, if Route A wins, a precise backlog for Phase 1.*
#MP2AI/GPTo3