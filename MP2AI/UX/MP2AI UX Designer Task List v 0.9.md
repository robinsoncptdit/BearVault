# MP2AI UX Designer Task List v 0.9

---

## Week 1 – Brand Integration & Component Spec

### 🎯 Goal: Create visual design tokens and define core components.

1. ✅ Extract color palette and typography scale from the branding kit.
2. ✅ Choose Google Font equivalents:  
   • "Noto Sans" for UI/body  
   • "Merriweather" for headings
3. ✅ Create Tailwind `extend` section for:
   • `colors.diocese`, `colors.neutral`  
   • `fontFamily` → `sans`, `serif`
4. ✅ Save to `tailwind.config.js`
5. ✅ Create `/public/logo.svg` by converting provided crest PNG.
6. 🟡 Create `components.md` in `.documentation/ux/`:
   • `SearchBar`  
   • `TopTenList`  
   • `DocCard`  
   • `ChatButton` / `ChatPanel`  
   • `TaskBlock`  
   • `PDFCallout`  
   • Document props, states, variants, example HTML structure

---

## Week 2 – Storybook Component Library

### 🎯 Goal: Create live visual system using Storybook.

7. 🟡 Initialize Storybook inside the Next.js repo  
   → `npx storybook init`
8. 🟡 Create stories for each component:
   • Base appearance  
   • Hover / Focus  
   • Loading / Error  
   • Disabled (if applicable)
9. 🟡 Export `storybook-static/` folder and commit to repo.
10. 🟡 Create basic layout shell for `/prototype` pages.

---

## Week 2.5 – Static Prototype Assembly

### 🎯 Goal: Create working non-functional prototype using live components.

11. 🟡 Create `/prototype` pages in Next.js:
   • `home.tsx` – Search bar, Top Ten  
   • `results.tsx` – Search result list  
   • `course.tsx` – Mini-course layout  
   • `login.tsx` – Simple password entry
12. 🟡 Add mocked content (static JSON).
13. 🟡 Animate open/close for ChatPanel using Tailwind transitions.
14. 🟡 Include SVG logo in the header of all pages.

---

## Week 3 – Usability Testing

### 🎯 Goal: Validate user flow with real parish users.

15. 🟡 Share `/prototype` with 3 pilot users.
16. 🟡 Ask for 2 recorded tasks (Loom free):
   • Use search to find registration help  
   • Open and explore the mini-course
17. 🟡 Collect responses using Google Form w/ SUS questions.
18. 🟡 Record qualitative notes in `usability-notes.md`.
19. 🟡 Implement light copy/labeling adjustments in `/prototype`.

---

## Week 3.5 – Accessibility & Responsive Fixes

### 🎯 Goal: Meet WCAG AA basic compliance.

20. 🟡 Run Axe CLI (`npx axe` or browser extension).
21. 🟡 Fix:
   • Color contrast  
   • Missing `aria-*` labels  
   • Keyboard nav on buttons/links
22. 🟡 Add Tailwind responsive utility classes:
   • Tablet ≥ 768px  
   • Desktop ≥ 1024px  
   (Mobile postponed)

---

## Week 4 – Dev Handoff & QA Support

### 🎯 Goal: Finalize UI and assist development team.

23. 🟡 Create `dev-handoff-checklist.md`:
   • List each component  
   • Tailwind classes used  
   • Where used (page/route)
24. 🟡 Record 5-min Loom walkthrough for devs.
25. 🟡 Support QA – answer CSS questions, tweak layout if needed.

---

## Final UX Deliverables Checklist

- [ ] `tailwind.config.js` token section complete
- [ ] `components.md`
- [ ] `/public/logo.svg`
- [ ] `storybook-static/`
- [ ] `/prototype` route pages
- [ ] `usability-notes.md`
- [ ] `a11y-audit.txt`
- [ ] `dev-handoff-checklist.md`
- [ ] Loom links saved in `.documentation/ux/`

---

🟢 When complete, tag PM and dev lead. UX is finished for MVP.

#MP2AI #MP2AI/UX