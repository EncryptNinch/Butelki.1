# Changelog

All notable changes to Butelki are documented here.

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
