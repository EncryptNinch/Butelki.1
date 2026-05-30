# Butelki

Color-sort puzzle game — sort blocks into bottles by color. 30 levels with a gravity inversion mechanic starting at level 11.

**Play:** [klockiv1.vercel.app](https://klockiv1.vercel.app)

## Features

- 30 levels with solvable-state generation
- Gravity inversion mechanic from level 11 (flip every 4 moves)
- Canvas pour animation with splash particles
- Progress saved to localStorage — resumes after reload
- Web Audio API sounds (tap, pour, flip, win) — zero dependencies
- 5 background themes + 4 Cosmos themes (unlocked at level 11)
- 3 color palettes (Normal, Neon, Pastel) + bottle size selector
- Undo button, mute toggle

## Tech

Single `index.html` file — vanilla JS, no build tooling, no dependencies.

## Version

v0.1.1.0 — see [CHANGELOG.md](CHANGELOG.md)
