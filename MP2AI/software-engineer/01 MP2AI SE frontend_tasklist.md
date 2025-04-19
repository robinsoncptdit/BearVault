# 01 MP2AI SE frontend_tasklist

<!-- 01_frontend_tasklist.md -->

# Front‑end Task List (Next.js 14)

### Sprint 1
- [ ] Add Tailwind config with brand tokens (from UX file).
- [ ] Install Google Fonts via `<link>` in `app/layout.tsx`.
- [ ] Scaffold pages & routes:
  - `/` Home (search input, TopTenList)
  - `/prototype/*` static demo (for UX)
  - `/course/events-groups-coordinator`
  - `/login`
- [ ] Import Storybook components; verify layout.
- [ ] Add crest logo SVG to `/public/logo.svg`; place in header.

### Sprint 2
- [ ] Implement `useSearch` hook → call `/api/search`.
- [ ] Implement `ChatProvider` & `ChatPanel` streaming SSE/Fetch wrapper.
- [ ] Insert skeleton loaders & focus traps (a11y).
- [ ] Configure shared‑password guard (NextAuth credentials).
- [ ] Add responsive classes (`md:` & `lg:` breakpoints).

### Sprint 3
- [ ] Consume real `/api/top10` list.
- [ ] Integrate PDF cheat‑sheet download button on course page.
- [ ] Add OpenAPI ReDoc page at `/docs`.
- [ ] Final a11y pass (Axe).
- [ ] Code freeze → tag `v0.1.0-poc`.
#MP2AI/software-engineer