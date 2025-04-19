# MP2AI Ultra‑Lean UX Work‑Plan


| Week | Deliverable | Key Tasks | Free Tool / Format |
|------|-------------|-----------|--------------------|
| **1** | **`tailwind.config.js` tokens**<br>**`components.md` spec** | • Extract brand colors & fonts from kit.<br>• Encode palette & type scale in Tailwind.<br>• Document component props / variants for:<br>  `SearchBar`, `TopTenList`, `DocCard`, `ChatButton/Panel`, `TaskBlock`, `PDFCallout` | Tailwind CSS, Markdown |
| **2** | **Storybook component library** (`storybook-static/`) | • Init Storybook.<br>• Build each component with Tailwind only.<br>• Document states (default, hover, focus, loading). | Storybook (MIT) |
| **2.5** | **Static prototype routes** (`/prototype`) | • Assemble pages (Home, Results, Course, Login) using Storybook components.<br>• Mock JSON; add Tailwind transitions & skeletons.<br>• Place crest logo in header (SVG). | Next.js |
| **3** | **Usability notes** (`usability-notes.md`) | • Share prototype with 3 coordinators; capture Loom recordings.<br>• Collect SUS via Google Form.<br>• Patch copy & minor UI issues. | Loom, Google Forms |
| **3.5** | **A11y audit** (`a11y-audit.txt`) | • Run Axe‑CLI; fix color contrast + ARIA labels.<br>• Verify ≥ 768 px & ≥ 1024 px responsive behavior. | Axe‑CLI |
| **4** | **Dev hand‑off checklist** (`dev-handoff-checklist.md`) | • Map components → pages.<br>• Record 5‑min Loom walkthrough.<br>• Support front‑end QA fixes. | Markdown, Loom |

### File Structure (`.documentation/ux/`)
ux/
├── components.md
├── dev-handoff-checklist.md
├── tailwind.config.js   (token section only)
├── usability-notes.md
└── a11y-audit.txt

---

## Draft Tailwind token snippet  
*(insert below into `tailwind.config.js`)*
*Note: (Google Fonts links (“Merriweather”, “Noto Sans”) will be added in* *app/layout.tsx* *head.)*

```
js
theme: {
  extend: {
    fontFamily: {
      sans: ['"Noto Sans"', 'sans-serif'],
      serif: ['Merriweather', 'serif'],
    },
    colors: {
      diocese: {
        blue:  '#0D3258',
        blueLt:'#687F97',
        blueL2:'#A4B2C0',
        gold:  '#F1A93F',
        goldLt:'#F6C987',
        red:   '#8E0116',
        // Crest accents
        crestGold: '#F1A93F',
        crestRed:  '#C1001D',
        crestBlue: '#005DAA',
      },
      neutral: {
        900: '#02060B',
        800: '#22252A',
        700: '#414448',
        600: '#616367',
        500: '#818385',
        400: '#A2A4A4',
        300: '#C0C1C2',
        200: '#DFE0E1',
      },
    },
  },
}
```

#MP2AI