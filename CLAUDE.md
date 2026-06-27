# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Course materials for a 3rd-year undergraduate Signals and Systems module, split into continuous-time and discrete-time tracks. The primary lecturer is Dr T. Chingozha (PhD).

## Toolchain

| Material type | Tool | File extension |
|---|---|---|
| Lecture notes | Typst | `.typ` |
| Tutorials, exams, labs | Quarto | `.qmd` → PDF |

### Compiling notes (Typst)

```
typst compile "Continuous signals and systems/Notes/notes.typ"
```

### Compiling assessments (Quarto)

```
quarto render "Continuous signals and systems/Tutorials/tutorial.qmd"
```

Run these from the repo root. Quarto requires `logo.png` and `titlepage.tex` to be co-located with the `.qmd` file (or in `../templates/` relative to it).

## Repository structure

```
├── Continuous signals and systems/
│   ├── Notes/           # notes.typ  — main Typst document
│   ├── Tutorials/       # tutorial.qmd + logo.png + titlepage.tex
│   ├── Exams/           # exam.qmd
│   ├── Labs/            # lab.qmd
│   └── templates/       # shared titlepage.tex + logo.png for Quarto
├── Discrete signals and systems/
│   ├── Notes/           # notes.qmd (Quarto, unlike continuous track)
│   ├── Tutorials/       # tutorial.qmd
│   ├── Exams/           # exam.qmd
│   └── Labs/            # lab.qmd
├── templates/           # root-level shared templates
└── data/                # textbooks (gitignored)
```

## Typst conventions

The notes use the `ilm` book template and these packages — import them at the top of any new `.typ` file:

```typst
#import "@preview/ilm:1.4.1": *
#import "@preview/showybox:2.0.4": showybox      // coloured callout boxes
#import "@preview/cetz:0.3.2"                    // drawing / canvas
#import "@preview/cetz-plot:0.1.1"               // function plots
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node  // block diagrams
```

Use `showybox` for "Note" (red) and "Key insight" (blue) callout boxes — match the existing style in `notes.typ`.

Use `cetz-plot` for signal plots (time-domain waveforms, spectra). Plot code lives inline in the `.typ` source via `#cetz.canvas({...})`.

## Quarto conventions

All `.qmd` assessments share a common YAML front matter structure:

```yaml
---
title: "University of Example : School of Engineering : Signals and Systems"
author: Dr T. Chingozha
format:
  pdf:
    include-in-header: "../templates/titlepage.tex"
---
```

`titlepage.tex` redefines `\maketitle` to produce a custom academic cover page with `logo.png` — both files must be present relative to the `.qmd` file being rendered.

## Course syllabus (continuous track)

1. Introduction to Signals and Systems
2. Continuous-Time Fourier Series
3. Continuous-Time Fourier Transform
4. Butterworth Filter Design
5. Nyquist Sampling Theorem
6. State-Space Analysis

The `notes.typ` file follows this chapter order. Chapters 3–6 are stubs awaiting content.
