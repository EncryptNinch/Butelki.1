# Changelog

All notable changes to Butelki are documented here.

## [0.1.1.0] - 2026-03-28

### Added
- Cosmos themes (Nebula, Void, Aurora, Mars) now visible in the customizer starting from level 11 — hidden on Earth levels to avoid silent fallback.

### Fixed
- `isAnimating` flag now released in `try/finally` in `tryMove` — game could no longer lock permanently if the pour animation threw.
- `keydown` (Escape) listener in the resume dialog is now removed in all close paths, not only the keyboard path — no listener leak.
- `loadSave` now validates `gravityDir` (must be 0 or 1) and `gravityCounter` (integer 0–4) and clamps each tower to max capacity (`CAP`) — corrupt saves no longer produce logic errors.
- `patchSave` now skips saves with wrong schema version instead of silently patching corrupt data.
- AudioContext oscillator and gain nodes now disconnect on `ended` event — prevents unbounded node accumulation during long sessions.
- All Polish UI text: resume dialog, win banner, next/back buttons, mute icon. Mute button moved from customizer to header (always visible). Undo button shows `cursor:not-allowed` when disabled.

## [0.1.0.0] - 2026-03-28

### Added
- localStorage save/restore — game progress survives page reload. Resume dialog on load ("Wznów grę" / "Nowa gra"). Progress persisted after every move.
- Level 11 gravity coach mark — one-time overlay explaining the flip mechanic before it fires for the first time.
- Web Audio API sounds (zero dependencies) — tap, invalid, pour, flip, and win chord. Lazy AudioContext with iOS/Safari resume fix.
- Mute toggle (🔊/🔇) in the customizer panel. State persisted in save schema.
- 30 levels with solvable-state generation — 60-attempt solver with scoring heuristics (transitions, spread, legal moves, mixed-tower count).
- Canvas pour animation — Bezier-curve liquid stream with splash particles.
- Gravity inversion mechanic from level 11 — flip every 4 moves, gravity bar with pip indicators.
- 5 background themes (Jasny, Ciemny, Błękit, Zieleń, Brzoskwinia) + Cosmos themes (Nebula, Void, Aurora, Mars).
- 3 color palettes (Normal, Neon, Pastel) + bottle size selector (S/M/L).
- Undo button (disabled after restore, re-enabled on first move).

### Fixed
- All localStorage.setItem calls wrapped in try/catch for QuotaExceededError and Safari private browsing.
- Escape key + backdrop click dismiss resume dialog so the game always starts.
- Pour frequency glide uses linearRampToValueAtTime for click-free audio envelope.
- Tower color indices validated on restore (prevents invisible blocks from corrupted saves).
- triggerFlip localStorage read wrapped in try/catch (prevents stuck isAnimating on Safari private).

### Removed
- `color-sort-v6.html` and `KOSMOSv1.html` prototype files.
