# 03 MP2AI supabase_schema
<!-- 03_supabase_schema.md -->

# Supabase Schema – MVP

```
sql
-- docs table
id           bigint generated always as identity primary key,
url          text,
title        text,
text         text,
embedding    vector(1536),
persona      text,   -- 'events_groups_coordinator'
created_at   timestamptz default now(),
updated_at   timestamptz default now()

-- top10 table
rank smallint primary key,
doc_id bigint references docs(id)

-- api_tokens table
token_hash   text primary key,
label        text,
created_at   timestamptz default now(),
last_used_at timestamptz
```

Row‑Level Security off for docs (read‑only) during MVP; full RLS later.

Indexes
```
sql
create index on docs using ivfflat (embedding vector_cosine_ops) with (lists = 100);
```

#MP2AI/software-engineer