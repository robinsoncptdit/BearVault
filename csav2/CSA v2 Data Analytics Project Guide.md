# CSA v2 Data Analytics Project Guide

## 1. Executive Summary

The **Catholic Sharing Appeal (CSA)** is the annual giving campaign for the Diocese, focused on inspiring parishioners to pledge support beyond their weekly offertory. While Ministry Platform (MP) is the system of record, its limitations in business intelligence led to the launch of **CSA v2** — a modern, AI-enhanced data analytics initiative.

This guide outlines the data architecture, integration strategies, agile delivery methods, and reporting framework for CSA v2. It also includes innovation concepts for long-term transformation, such as AI-based stewardship and predictive parish performance.

### Technology Stack
- **Ministry Platform API** – Source of truth
- **n8n** – Data automation and ETL
- **Supabase** – Cloud data warehouse
- **OpenAI API** – Natural language insights & vector embeddings

---

## 2. Project Overview

### Project Goals
1. Seamless CSA data extraction from Ministry Platform
2. Efficient and resilient ETL pipeline
3. Secure and queryable data storage
4. AI-powered insights via natural language
5. Actionable reports for Development and Leadership

### Key Tables Used from MP
- Contacts, Donors, Donations
- Pledges, Campaigns, Congregations
- Donation Distributions, Programs

### Core Team (RoleBot Style)
- **Chief Data Officer** – Data architecture & governance
- **Business Analyst** – User stories & KPIs
- **CTO** – Systems integration and flow
- **Process Analyst** – ETL workflows
- **CAIO** – Natural language interface & AI logic
- **Agile Coach** – Team velocity & delivery rhythm
- **Business Writer** – Reporting framework

---

## 3. Data & Integration Workflows

### ETL Flow (n8n Workflows)
1. **Initial Load** – Full historical data pull
2. **Incremental Updates** – Daily delta loads via modified timestamp
3. **Data Transformation** – Normalization, key mapping, enrichment
4. **Load to Supabase** – Ordered upserts
5. **Embeddings** – OpenAI-generated vector fields
6. **Validation & Reconciliation** – Record counts and key checks
7. **Monitoring & Alerting** – Slack/email triggers for errors or delays

### Optimization Techniques
- Token caching to reduce API calls
- Smart incremental logic using hash comparisons
- Parallel sub-workflows
- Progressive validation and ML-based anomaly detection

---

## 4. Agile Execution Plan

### Methodology
**Hybrid Scrum-Kanban**
- 2-week sprints
- Daily standups, sprint planning, retrospectives

### Roles
- PO: Director of Development
- Scrum Master: Project Coordinator
- Dev Team: Integration devs, automation engineers, data analysts

### Key Metrics
- Velocity, cycle time, defect rate
- Data quality KPIs (completeness, accuracy)

---

## 5. Reporting & Presentation Framework

### Report Types
- **Executive Dashboard** (monthly/quarterly)
- **Campaign Analysis Report** (end-of-campaign)
- **Parish Profiles** (annually)
- **Donor Segment Analysis** (quarterly)
- **Weekly Campaign Snapshot** (during campaign)

### Principles
- Clarity, actionability, visuals-first
- Branded, accessible, role-targeted
- Automated where possible

---

## 6. AI & Innovation Strategy

### Natural Language Querying
- Supabase + OpenAI pipeline
- Context-aware prompts
- SQL generation and response formatting

### Automated Insights
- Scheduled analyses (e.g. donor retention, giving patterns)
- Anomaly detection and summaries
- Priority alerts for underperformance

### Future Innovation Concepts
- Personalized stewardship journeys
- Parish performance predictors
- AI-generated impact storytelling
- Community giving intelligence
- Volunteer mobilization engines
- Cross-diocesan learning network

---

## 7. Roadmap & Phasing

### Phase 1: Foundation (Weeks 1–3)
- Schema setup, full data extraction, basic validation

### Phase 2: Pipeline Buildout (Weeks 4–6)
- ETL automation, derived tables, error handling

### Phase 3: AI & Reporting (Weeks 7–10)
- Vector embeddings, dashboards, natural language UI

### Phase 4: Optimization (Weeks 11–12)
- Indexing, monitoring, training, documentation handoff

---

## 8. Appendices

### Data Model Highlights
- Core tables: donors, donations, pledges, campaigns
- Derived: donor_summary, campaign_performance

### Sample RoleBot Prompts
- "Create the technical architecture for an MP-to-Supabase pipeline"
- "Document a validation framework for transformed CSA data"

### Glossary
- **Pledge Fulfillment Rate** – Total received / total pledged
- **Participation Rate** – # donors / # eligible parishioners
- **Vector Embedding** – Numerical representation of text for search/AI use

#csav2
