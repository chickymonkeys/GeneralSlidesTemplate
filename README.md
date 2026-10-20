# GeneralSlidesTemplate

**GeoSlides** is a Beamer theme for academic talks: a slim bar beside each frame
title, a three-part footer, Neutra Text with Palatino maths, and a university
colour palette. You write ordinary Beamer — `\begin{frame}{Title}{Subtitle}`,
`columns`, `figure`, `block`, `\pause`, `\appendix` — and the theme styles it.
There is no vocabulary to learn beyond Beamer's own.

## Quick start

1. Copy this repository into your talk's folder (or use it as a GitHub template).
2. Edit [`main.tex`](main.tex): the title page fields, then the frames.
3. Compile:

   ```sh
   latexmk main.tex
   ```

That is all. `latexmkrc` picks XeLaTeX and runs Biber when the deck cites.

## Requirements

- TeX Live or MacTeX (2020 or later) with XeLaTeX, `latexmk` and Biber.
- The house font, Neutra Text, which the theme takes from [`fonts/`](fonts/)
  next to the deck. Without it — on a coauthor's machine, or under pdfLaTeX —
  the deck still compiles, in Latin Modern Sans, with a warning.

## A deck on one page

```latex
% !TeX program = xelatex
\documentclass[10pt]{beamer}             % aspectratio=169 for 16:9
\usetheme{geoslides}
\usepackage{notation}                    % optional: maths shortcuts
\usepackage[main=british]{babel}
\addbibresource{references/references.bib}

\title[Short Title]{The Full Title}
\subtitle{An optional subtitle}
\author{First Author \and Second Author}
\institute{First University \and Second University}
\date[Conference]{Conference, City \\[1em] 1 January 2026}

\begin{document}
\maketitle

\section{Introduction}
\begin{frame}[label=intro]{Motivation}{Why it matters}
  \begin{itemize}
    \item A claim \citep{bib:becker1993}, with its \slidelink{proof}{proof}.
    \item<2-> A second claim, on click.
  \end{itemize}
\end{frame}

\begin{frame}[standout]
  The one sentence the room should leave with.
\end{frame}

\begin{frame}[allowframebreaks]{References}
  \newrefcontext[sorting=nyt]
  \printbibliography[heading=none]
\end{frame}

\appendix
\begin{frame}{Backup Slides}
  \tableofcontents
\end{frame}

\section{Proofs}
\begin{frame}[label=proof]{The Proof}{\slideback{intro}}
  \dots
\end{frame}
\end{document}
```

[`main.tex`](main.tex) shows the rest: a figure, a table from estimation code
with notes, two columns, theorems and blocks, the closing slide.

## What the theme adds to Beamer

| You write                                      | You get                                                                                                                                |
| ---------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| `\maketitle`                                   | the title page, on a frame without footer                                                                                              |
| `\author{A \and B}` and `\institute{X \and Y}` | each author with their affiliation under the name, in rows; with `\inst{1}` marks, the institutes listed underneath as in plain Beamer |
| `\begin{frame}[standout]`                      | one sentence, centred, on the inverted palette                                                                                         |
| `\slidelink{label}{text}`, `\slideback{label}` | flat links to a backup slide and back (`label=` on the target frame)                                                                   |
| `\appendix`                                    | backup slides numbered apart, and an _Appendix_ link in every footer                                                                   |
| `\logo{...}`, `\titlegraphic{...}`             | a logo at the right end of the title bar; a picture on the title page                                                                  |
| `\alert{...}` or `\shine{...}`                 | text in the accent colour                                                                                                              |

The footer shows the short authors (`\author[...]`, or "A and B", or
"A et al." from three authors up), the short title (`\title[...]`), and the
short date (`\date[...]`) with the frame number.

The theme also loads what most academic decks need: `amsmath`, `amssymb`,
`booktabs`, `multirow`, `threeparttable`, `caption`, `subcaption`, `csquotes`,
`tikz`, and `biblatex` with author–year citations (`\citet`, `\citep`) and an
AER-style reference list. Anything else, load in the deck as usual.

## Customising

### Theme options

```latex
\usetheme[palette=nhh, authorsperrow=3]{geoslides}
```

| option          | values                     | default  | what it does                                                                        |
| --------------- | -------------------------- | -------- | ----------------------------------------------------------------------------------- |
| `palette`       | `ku`, `nhh`, `mit`, `fair` | `ku`     | the two accent colours                                                              |
| `authorsperrow` | a number, or `auto`        | `auto`   | authors per row on the title page (`auto`: up to three, rows balanced)              |
| `appendixlink`  | `true`, `false`            | `true`   | the _Appendix_ footer link, in decks that have an `\appendix`                       |
| `biblatex`      | `true`, `false`            | `true`   | `false` loads no bibliography package, to set up natbib/BibTeX or your own biblatex |
| `housefont`     | `true`, `false`            | `true`   | `false` keeps Latin Modern Sans                                                     |
| `fontpath`      | a folder, ending in `/`    | `fonts/` | where to find Neutra Text, e.g. `../fonts/`                                         |

### Colours

Every colour in the theme is drawn from a handful of named colours. Redefine
any of them after `\usetheme`, with any `xcolor` colour:

```latex
\usetheme{geoslides}
\colorlet{primarycolor}{darkpetroleumku}    % titles, bullets, footer
\colorlet{secondarycolor}{petroleumku}      % subtitles, links, \alert
```

| colour            | used for                                                                       |
| ----------------- | ------------------------------------------------------------------------------ |
| `primarycolor`    | frame titles and their bar, bullets, block titles, footer, standout background |
| `secondarycolor`  | subtitles, sub-bullets, links, `\alert`                                        |
| `normaltext`      | body text                                                                      |
| `citecolor`       | citations and URLs                                                             |
| `footertext`      | footer text and its middle box                                                 |
| `shadecolor`      | dimmed entries in the outline                                                  |
| `backgroundcolor` | the slide                                                                      |

The theme defines the University of Copenhagen (`darkredku`, `petroleumku`,
…), NHH (`darkbluenhh`, `goldnhh`, …), MIT and FAIR colours; see the
_Colours_ section of [`beamerthemegeoslides.sty`](beamerthemegeoslides.sty).
For anything finer, Beamer's own `\setbeamercolor`, `\setbeamerfont` and
`\setbeamertemplate` work as usual, e.g.
`\setbeamerfont{frametitle}{size=\LARGE}`.

### Fonts

The text is set in Neutra Text from `fonts/`, the maths in Palatino. If the deck
lives elsewhere, point the theme at the fonts with `fontpath=../fonts/`, or
install the `.otf` files on your system and the theme finds them there. Other
fonts: `\usetheme[housefont=false]{geoslides}` and then fontspec's
`\setsansfont{...}`.

### Bibliography

Citations are author–year (`\citet`, `\citep`, `\citeauthor`, …), with several
citations in one command sorted by year. The reference list is sorted by author
with `\newrefcontext[sorting=nyt]` before `\printbibliography`, as in
`main.tex`. To use natbib and BibTeX, or biblatex with other options, load the
theme with `biblatex=false` and set up your own.

### Use the theme in every talk

Install it once in your personal TeX tree and any deck, anywhere, can write
`\usetheme{geoslides}` without copying files:

```sh
TEXMFHOME=$(kpsewhich -var-value TEXMFHOME)
mkdir -p "$TEXMFHOME/tex/latex/geoslides" "$TEXMFHOME/fonts/opentype/geoslides"
cp beamerthemegeoslides.sty notation.sty geoslidesframes.sty "$TEXMFHOME/tex/latex/geoslides/"
cp fonts/*.otf "$TEXMFHOME/fonts/opentype/geoslides/"
```

## Compiling

```sh
latexmk main.tex      # or: latexmk -pdf main.tex
```

`latexmkrc` compiles with the engine named on the `% !TeX program = xelatex`
line at the top of `main.tex`, even when an editor asks latexmk for pdfLaTeX,
so the same file works:

- **on the command line** and in **VS Code** (LaTeX Workshop), **VimTeX** and
  other editors that build with latexmk;
- **on Overleaf**: upload the folder; Overleaf reads `latexmkrc`, so the
  compiler setting does not matter (or set it to XeLaTeX);
- **by hand**: `xelatex main` → `biber main` → `xelatex main` → `xelatex main`.

**Slides inside a research project.** Keep the deck in its own folder, such as
`slides/`, with `beamerthemegeoslides.sty`, `notation.sty` and `fonts/` beside
it, and reach the project's files with relative paths:

```latex
\addbibresource{../references/references.bib}
\graphicspath{{../figures/}}
\input{../tables/estimates}
```

If the project root already has a `latexmkrc` (as
[GeneralDraftTemplate](https://github.com/chickymonkeys/GeneralDraftTemplate)
does), give `slides/` a one-line `latexmkrc` that loads it:
`do '../latexmkrc';`. Its engine detection reads the same `% !TeX program`
line.

## Repository layout

| path                        | what it is                                                                      |
| --------------------------- | ------------------------------------------------------------------------------- |
| `main.tex`                  | the demo deck; start from it                                                    |
| `beamerthemegeoslides.sty`  | the theme: options, fonts, colours, title page, frame title, footer             |
| `notation.sty`              | maths shortcuts and colour shorthands shared with the paper template (optional) |
| `geoslidesframes.sty`       | the version 1 layout vocabulary, for older and generated decks (optional)       |
| `latexmkrc`                 | build settings, locally and on Overleaf                                         |
| `fonts/`                    | Neutra Text (and Sentinel)                                                      |
| `figures/`                  | figures; `figures/logos/` holds the logos                                       |
| `tables/`                   | `.tex` table fragments from estimation code                                     |
| `references/`               | `references.bib`                                                                |
| `docs/layout-vocabulary.md` | reference for `geoslidesframes.sty`                                             |

## Upgrading a deck from version 1

Version 1 kept the theme in `template/` and loaded it with
`\usepackage{template/beamerthemegeoslides}`. To move a deck to version 2:

1. Copy `beamerthemegeoslides.sty`, `notation.sty` and `latexmkrc` next to the
   deck, and delete its `template/` folder.
2. Replace the `\usepackage{template/beamerthemegeoslides}` line with

   ```latex
   \usetheme{geoslides}
   \usepackage{notation}
   \usepackage{geoslidesframes}   % only if the deck uses \titleframe, contentframe, ...
   ```

3. Version 1 also loaded many packages a deck may rely on without knowing it.
   If the deck uses one of them, load it in the deck: `svg` (needs Inkscape and
   `-shell-escape`), `soul`, `pdfpages`, `lipsum`, `makecell`, `algorithm2e`,
   `pdflscape`, `afterpage`, `comment`, `framed`, `float`, `multicol`,
   `setspace`, `relsize`, `verbatim`, `subfiles`; and the TikZ libraries
   `arrows.meta`, `decorations.pathreplacing` and `bayesnet`.

Everything else compiles unchanged. These can now go, if you like: the
bibliography path lookup (`\TryRefsPath`, write `\addbibresource{...}`), the
`\DeclareGraphicsExtensions` line, a hand-built column block inside `\author`
(write `\author{A \and B}` and `\institute{X \and Y}`), `\frontlogo`,
`\backupbegin` and `\backupend`, and `[sorting=nyt]` on `\printbibliography`
(use `\newrefcontext[sorting=nyt]` before it).

What looks different: captions sit 5pt below their figure or table; notes
under a `\slidefigure` or `\slidetable` are grey instead of near-white; standout
frames show their inverted palette (in version 1 they came out blank); and
decks with an `\appendix` get the footer link (turn it off with
`appendixlink=false`).
