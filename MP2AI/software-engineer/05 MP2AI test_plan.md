# 05 MP2AI test_plan

<!-- 05_test_plan.md -->

# MVP Test Plan

## Unit
- Vector search returns ≤ 3 results ranked by cosine.
- Prompt assembler injects exactly 3 citations.
- Chat endpoint streams tokens (`data:` events) every ≤ 1 s.

## Integration
- Supabase IVFFlat index returns < 500 ms for query “registration fee”.
- `/api/search` secured: 401 on missing/invalid bearer token.
- Shared‑password login sets cookie + protects `/`.

## Manual Smoke Checklist
1. Load home page → crest logo visible.
2. Type query → results list appears ≤ 1 s.
3. Click chat → panel opens; ask question; answer streams + links work.
4. Course page opens; PDF downloads; branded colors show.

#MP2AI/software-engineer