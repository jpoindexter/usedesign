# usedesign

`/usedesign` — one command that routes across **all** your installed design skills and picks the best 2–5 for the task at hand.

You have ~85 design skills spread across five families (cross-cutting, `dec-*`, `ios-*`, `flow-*`, `wireframe-*`). Loading the right ones by hand is the bottleneck. `usedesign` reads your task, narrows the field, and loads only what's load-bearing.

## What it does

```
/usedesign audit this iOS chart screen for accessibility
  → Skills matched (3): ios-charts-and-data-visualization, ios-accessibility, data-visualization
```

It's a **router skill**, not a new design system. It carries a generated catalog of your design skills + a routing table (task signal → which skills), and defers to your existing family dispatchers (`/ios`, `/design`, `/dec`, `/userflow`, `/wireframe`) when a task sits entirely in one family. Use `/usedesign` when the task **spans families**.

## Install

```bash
git clone https://github.com/jpoindexter/usedesign.git
cd usedesign
./install.sh
```

`install.sh`:
1. Symlinks `skills/usedesign` into `~/.claude/skills` **and** `~/.codex/skills` (Claude + Codex).
2. Refreshes the catalog from your actual `~/.claude/skills` so it matches your machine.

Restart your agent session, then: `/usedesign <your design task>`.

## How routing works

1. Read the task → extract **surface** (iOS / web / data / marketing / wireframe) and **activity** (build / audit / polish / flow / copy / design-system).
2. Consult [`skills/usedesign/catalog.md`](skills/usedesign/catalog.md) — every design skill grouped by family with its description.
3. Match against the routing heuristics in [the SKILL](skills/usedesign/SKILL.md), shortlist, **cap at 5**, load, apply.

Full logic lives in [`skills/usedesign/SKILL.md`](skills/usedesign/SKILL.md).

## The catalog

`catalog.md` / `catalog.json` are generated from your installed skills by `scripts/build-catalog.mjs`. A skill counts as **design** if its folder starts with a design-family prefix (`ios` / `dec` / `flow-` / `wireframe`) or is in the curated cross-cutting set. Reasoning/critique families (`blind-*`, `si-*`, `nd-*`, `vd-*`) are intentionally excluded.

Added new design skills since install? Regenerate:

```bash
node scripts/build-catalog.mjs            # scans ~/.claude/skills → catalog.json + catalog.md
```

The router also falls back to a live `ls ~/.claude/skills` scan for anything not yet in the catalog, so a stale catalog degrades gracefully.

## Layout

```
usedesign/
├── README.md · LICENSE · install.sh · .gitignore
├── scripts/build-catalog.mjs        # regenerates the catalog
└── skills/usedesign/
    ├── SKILL.md                     # the router → /usedesign
    ├── catalog.md                   # generated design-skill index (human)
    └── catalog.json                 # generated design-skill index (machine)
```

## License

MIT — see [LICENSE](LICENSE).
