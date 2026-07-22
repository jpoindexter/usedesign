---
name: usedesign
description: "Use when the user invokes /usedesign, or hands over any design/UI task (screen, component, layout, color, type, motion, flow, chart, wireframe, audit, polish, copy) and it's unclear which design skills to load — a router over ALL installed design skills (cross-cutting, dec-*, ios-*, flow-*, wireframe-*) that reads the task and picks the best 2-5 to apply."
---

# usedesign — design skill router

One entry point over every installed design skill. Read the task, narrow ~85 design skills down to the best **2–5**, load them, apply them. Don't design from memory — the picked skills carry the concrete specs.

## How to route (do this in order)

1. **Read the task.** Extract two signals:
   - **Surface** — native iOS? web/cross-platform? data/charts? marketing page? wireframe/sketch?
   - **Activity** — build, audit/critique, polish, wireframe, flow-design, write copy, design-system.
2. **Consult [`catalog.md`](catalog.md)** (this skill's folder) — every design skill grouped by family with its description. `catalog.json` is the machine-readable form.
3. **Match with the heuristics below** → a shortlist. Prefer **leaf** skills over dispatchers.
4. **Cap at 5.** If the task is squarely one family, defer to that family's dispatcher instead of hand-picking (see "Defer" below).
5. **Announce + load.** State `Skills matched (N): …`, load each (see "Loading"), then apply. End with `Skills applied: …`.

## Routing heuristics (task signal → where to look)

| Task signal | Prioritize |
|---|---|
| Native iOS / SwiftUI / iPhone screen | `ios26-hig-patterns` + the specific `ios-*` (typography, color-and-materials, components, layout-and-grid) |
| Web / cross-platform screen or component | `layout-and-composition`, `components-and-states`, `color-and-elevation`, `grid-and-spacing` |
| Product definition is unresolved (customer, outcome, evidence, metrics, AI fit) | `pm` first, then the matching design skills |
| Design system / tokens | `design-tokens`, `dec-design-system-depth`, `color-and-elevation`, `components-and-states` |
| Charts / dashboard / data graphic | `data-visualization`, `tufte` (+ `ios-charts-and-data-visualization` on iOS) |
| Motion / animation / transition | `interaction-and-motion`, `app-motion-and-animation`, `dec-motion-animation` (+ `ios-motion-and-animation`) |
| Accessibility | `accessibility-and-inclusive-design`, `dec-accessibility`, `inclusive-design` (+ `ios-accessibility`) |
| Copy / microcopy / content | `ux-writing-and-content` |
| A flow (onboarding, auth, checkout, settings, search, paywall, permissions, errors, tables…) | the matching `flow-*` — or defer to `/userflow` |
| Wireframe / sketch / block out a screen | the matching `wireframe-*` — or defer to `/wireframe` |
| Audit / critique / "is this good" / heuristic eval | `usability-heuristics`, `dec-nielsen-heuristics`, `visual-qa`, `accessibility-audit`, `anti-slop-design-law`, `ethical-design-and-dark-patterns` |
| "Make it feel better" / polish / "feels off" | `make-interfaces-feel-better`, `polish` |
| Cognitive load / UX laws / clarity | `dec-cognitive-load`, `dec-ux-laws`, `laws-of-ux-and-psychology`, `dec-krug-laws` |
| Landing / marketing page | `hallmark`, `anti-slop-design-law` |
| Nutrition / food / macro app | `macro-food-app-ui`, `dense-no-scroll-layout` |

Multiple signals → pick across families, still cap at 5, most-load-bearing first.

Keep the boundary explicit: `pm` owns what to build, for whom, why, how success is measured, and whether AI is appropriate. Design skills own how that decision becomes an interface. Count `pm` inside the five-skill cap when both are required.

## Defer to a family dispatcher

If the whole task sits inside one family, hand off instead of hand-picking — the family dispatcher already routes within its set:

- Native iOS → `/ios` · Web/cross-platform → `/design` · Design-eng principles → `/dec` · UX flow → `/userflow` · Wireframing → `/wireframe`

Use `/usedesign` when the task **spans families** (e.g. "audit this iOS chart screen for accessibility" → `ios-charts-and-data-visualization` + `ios-accessibility` + `data-visualization`).

## Loading a skill (runtime-specific)

> **Claude Code / Claude:** invoke each picked skill via the `Skill` tool by its `name`.
> **Codex / other runtimes:** open `~/.codex/skills/<name>/SKILL.md` (or `~/.claude/skills/<name>/SKILL.md`) and follow it.

The routing logic above is runtime-agnostic; only the load mechanism differs.

## Keeping the catalog current

`catalog.md` / `catalog.json` are a snapshot of the installed design skills at build time. If a design skill seems missing (you added one since), regenerate:

```bash
node scripts/build-catalog.mjs            # scans ~/.claude/skills
```

Or, for a one-off check, `ls ~/.claude/skills` and read the frontmatter `description` of any candidate not in the catalog.
