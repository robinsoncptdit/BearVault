# 04 MP2AI environment_variables

<!-- 04_env_variables.md -->

# Environment Variables

| Key | Example | Used By |
|-----|---------|---------|
| `NEXT_PUBLIC_SUPABASE_URL` | https://xyz.supabase.co | FE + API |
| `SUPABASE_SERVICE_KEY` | **secret** | API routes, scraper |
| `OPENAI_API_KEY` | **secret** | API `/chat`, scraper embeddings |
| `PORTAL_SHARED_PASSWORD_HASH` | bcrypt string | NextAuth |
| `API_BEARER_TOKEN_HASH` | sha256 string for docs usage | API middleware |
| `ALLOWED_CORS_ORIGINS` | `https://*.freshservice.com,https://n8n.local` | API middleware |

All secrets live in Vercel & GitHub Actions env vars; *never* committed.

#MP2AI/software-engineer