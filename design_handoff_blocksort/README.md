# Handoff: BlockSort — block-sort puzzle (visual retouch)

## Overview
**BlockSort** is a "block / water-sort" logic puzzle. The board is a row of rounded
bottles, each holding up to 4 colored blocks. The player taps a source bottle then a
destination to pour the top run of same-colored blocks across; the goal is to gather
each color into its own bottle. From level 11 onward a **gravity inversion** mechanic
flips every bottle upside-down once every 4 pours (the board is also re-themed to a
"cosmos" palette at that point).

This handoff documents a **light visual retouch** of an already-working game — the goal
was order and balance, NOT a redesign. The friendly original character is intact
(Space Grotesk / Space Mono, warm off-white background, coral accent, rounded symmetric
bottles with capacity dots). All game logic and the original pour animation are
unchanged.

## About the Design Files
`reference/BlockSort.html` is a **single self-contained HTML design reference** (inline
CSS + vanilla JS, no build step, no external assets except two Google Fonts). It shows
the intended look and behavior. It is **not necessarily the production artifact** — the
task is to recreate this UI in the target codebase's environment (React, Vue, SwiftUI,
a game engine, etc.) using its established patterns. If there is no environment yet, the
file can also ship close to as-is (it already runs standalone) or be ported to a
lightweight framework.

The JS is well-structured and portable; the level-generation + solver section
(guaranteed-solvable via reverse-walking from a solved state) should be ported nearly
verbatim.

## Fidelity
**High-fidelity.** Final colors, typography, spacing, radii and interaction timing are
all specified below and present in the reference CSS. Recreate to match.

---

## The screen
One primary screen (the board). Overlays/sheets layer over it: an appearance customizer
(bottom sheet), a levels overlay, a win banner, a resume dialog, a gravity coach-mark.

### Layout
Full-viewport flex column: `header` · optional `#gravity-bar` (shown level ≥ 11) ·
`main` (flex:1, centers `#grid`) · fixed `<canvas>` for the pour stream.
- **Header** — `display:flex; justify-content:space-between; align-items:center;
  padding:16px 28px; gap:16px;` over `--surface` with a 1px bottom border and a faint
  backdrop blur. Three zones: logo (left) · stats (center) · tools (right).
- **#grid** — `display:flex; flex-wrap:wrap; justify-content:center; align-items:center;
  gap:40px; padding:20px;`. Holds the bottles.
- A fixed dot-grid texture sits behind everything
  (`radial-gradient(circle, rgba(0,0,0,.04) 1px, transparent 1px)` at `24px 24px`).

### Components

**Logo** — "Block" + "Sort" (the "Sort" half in `--accent`), Space Mono 900, ~1.15rem,
letter-spacing −0.3px.

**Stat pill** (Ruchy / Poziom) — `--bg` fill, 1px `--border`, radius 14px, `padding:6px
16px`. Internally a centered column: a tiny uppercase label (.55rem, weight 800,
letter-spacing .12em, `--text2`) over a tabular-mono number (Space Mono, ~1.05rem,
weight 700, `--text`). `min-width:64px` so both pills align.

**Tool buttons** (right) — labeled pill buttons: `height:40px; padding:0 14px;
radius:12px; gap:8px; display:flex` with an emoji icon (`.bico`) + an uppercase label
(`.blabel`, Space Grotesk, .6rem, weight 800, letter-spacing .08em, `white-space:nowrap`).
In order: **Dźwięk** (sound 🔊/🔇 toggle), **Cofnij** (undo ↩), **Poziomy** (levels 📋),
**Wygląd** (appearance 🎨), **Od nowa** (restart ↺ — primary/coral variant). Under
920px the labels hide and buttons collapse to 40px squares.
- Button variants: `.btn-ghost` = `--surface` fill + 2px `--border`; `.btn-primary` =
  `--accent` fill, white, soft shadow `0 4px 14px rgba(255,90,95,.22)`.

**Bottle** (`.tower`) — **symmetric rounded rectangle** (this matters: it must read
naturally when rotated 180° for gravity inversion — do NOT taper it).
- Size via CSS vars `--tower-w` (default 70px) / `--tower-h` (196px); customizer offers
  S/M/L. `background:--surface; border:2px solid --border; border-radius:18px;
  padding:10px 8px 10px 4px;` resting shadow `0 2px 8px rgba(40,30,20,.04)`.
- Layout is a row: a thin **capacity-dot column** (`.tower-dots`, 4 dots, filled dots use
  `--accent`) on the left, then `.tower-inner` (a `column`/`column-reverse` flex) holding
  the blocks.
- **Blocks** (`.block`) — full width, `height:var(--block-h)` (35px), `border-radius:8px`,
  flat fill, with `box-shadow: inset 0 2px 0 rgba(255,255,255,.14), inset 0 -3px 0
  rgba(0,0,0,.16)` for a subtle top highlight + bottom shade. 4px gap between blocks.
- States (retouched to soft rings — no neon glow):
  - `.selected` → `border:--accent; box-shadow: 0 0 0 3px rgba(255,90,95,.16), 0 10px
    26px rgba(255,90,95,.20)`.
  - `.done` (4 of one color) → green `#3FB36B` ring (`0 0 0 3px rgba(63,179,107,.15), …`);
    filled dots turn `#3FB36B`.
  - `.full` not done → soft red ring `rgba(239,68,68,.45)` + filled dots `#EF4444`
    (a gentle "this bottle is full" warning).
- Transition: `transform .8s cubic-bezier(.68,-.55,.27,1.55)` (used for the gravity flip)
  + border/shadow .3s. The flip is applied as an inline `transform: rotate(180deg)` on
  each bottle, so don't drive `transform` from CSS state classes.

**Gravity bar** (`#gravity-bar`, shown level ≥ 11) — centered row: a rotating arrow
(↓/↑) + 4 pips (`38×6px`, filled with `--accent` as pours accumulate toward the next
inversion).

**Customizer** (`#cust`) — bottom sheet (`transform:translateY(100%)` → `0`, radius
24px top). Sections: **Tło** (background theme swatches — light/dark/blue/green/peach,
plus cosmos themes nebula/void/aurora/mars that appear on level ≥ 11), **Rozmiar
butelki** (S/M/L), **Kolory bloków** (palette swatches: Normal / Neon / Pastel).

**Levels overlay** (`#lsel`) — dark full-screen panel, three sections (Łatwe 1–10,
Średnie 11–20, Trudne 21–30) as grids of square level buttons (current = indigo, done =
green check).

**Win banner** (`#win`) — bottom-centered card that slides up: 🎉 icon, "POZIOM
UKOŃCZONY!", "Rozwiązano w N ruchach", a big accent move count, replay + "Następny →".
Fires confetti.

**Toast** (`#toast`) — dark pill that slides up from the bottom for transient messages
("Naczynie jest pełne!", "Różne kolory!", "GRAVITY INVERSION!"). Keep it fully hidden
(`opacity:0; visibility:hidden`) when idle.

---

## Interactions & Behavior
- **Pour**: tap source bottle (non-empty, not done) → it highlights. Tap destination →
  if the top colors match and there's room, the whole top same-color run transfers.
  Invalid moves → toast + a short "invalid" sound; tapping the selected bottle again
  deselects. Keyboard: Enter/Space activates a focused bottle.
- **Pour animation (keep exactly)**: a DOM "ghost" stack tweens source → up → across →
  down into the destination in three eased steps (~0.66s total), while a `<canvas>`
  draws a bezier liquid stream with a particle splash (`Pour` class + `pourLoop`). Then
  the real blocks commit and the move counter increments.
- **Undo**: snapshots pushed each move; restores bottles/moves/gravity.
- **Gravity inversion** (level ≥ 11): after every 4 pours, all bottles `rotate(180deg)`
  (0.8s), then the underlying stacks are reversed and re-rendered (transitions suppressed
  for one frame to avoid a jump). First time shows a one-time coach-mark.
- **Win**: when every bottle is empty or done → win banner + confetti + ascending chord.
- **Audio**: Web Audio API, zero deps — oscillator blips for tap/invalid/pour/flip and a
  chord for win. Mute toggle persists.
- **Persistence**: full game state saved to localStorage (`butelki_save`, versioned, with
  validation on load) including level, bottles, gravity, completed levels, chosen
  palette/background/size and mute. On load, if a save exists, a **resume dialog** offers
  continue vs. new game.

## State Management
Key state (top of the `<script>`): `towers` (array of color-index stacks), `history`
(undo snapshots), `selected`, `moves`, `currentLevel`, `gravityDir` (0/1),
`gravityCounter`, `isAnimating`, tower size, `COLORS` (active palette), palette/bg ids,
`completedLevels` (Set), `isMuted`. Level generation + solver are pure functions — port
them as the model layer.

## Design Tokens
**Colors** (`:root`, light/default theme)
- `--bg #F5F3EF` · `--surface #FFFFFF` · `--border #E8E4DC`
- `--text #1A1A2E` · `--text2 #8A8A9A`
- `--accent #FF5A5F` (coral) · `--accent2 #FFB347`
- done/success `#3FB36B` · full/warning `#EF4444`
- Alternate background themes & a dark "cosmos" theme (level ≥ 11) override these vars —
  see the `body.bg-*` / `body.cosmos*` rules and the `BG_THEMES` / `EARTH_THEMES` /
  `COSMOS_THEMES` JS tables.

**Block palettes** (`PALETTES` in JS)
- Normal: `#2563EB #16A34A #F59E0B #DC2626 #7C3AED #0891B2 #D946EF #334155`
- Neon: `#FF006E #00E5FF #39FF14 #FFE700 #FF7A00 #B300FF #00FFB3 #2D6BFF`
- Pastel: `#F4A6A6 #AFCBFF #B8E1C6 #F9D7A5 #CDB7F6 #AEE6E6 #F7B2D9 #C6D1DE`

**Typography**
- Display/logo/labels: **Space Mono** (700/900).
- UI / body / buttons: **Space Grotesk** (500/700/900).
- Numbers use tabular figures.

**Radii / spacing / shadow**
- Radii scale: blocks 8 · buttons/pills 12–14 · bottles 18 · sheet 24 · pills/dots 999.
- Bottle: 70×196 (M), block 35px tall, 4px inter-block gap, dot column 6px.
- Grid gap 40px; header padding 16×28.
- Shadows are soft and low-opacity — prefer rings + faint shadows over heavy glows.

**Motion**
- Bottle flip / select `cubic-bezier(.68,-.55,.27,1.55)` over .8s; customizer
  `.32s cubic-bezier(.34,1.2,.64,1)`; win/banners `~.45s cubic-bezier(.34,1.3,.64,1)`.

## Assets
- **Fonts**: Google Fonts — Space Grotesk + Space Mono (loaded via `@import`).
- **Icons**: emoji (🔊 ↩ 📋 🎨 ↺) — swap for the target app's icon set if preferred.
- No raster images; confetti and the pour stream are generated.

## Files (in `reference/`)
- `BlockSort.html` — the complete game: markup, all CSS, and the JS (logic + solver,
  rendering, pour animation, gravity, audio, save/restore, customizer). Single source of
  truth.
