# GeneralSlidesTemplate

A Beamer presentation template — the **GeoSlides** theme — to start a deck from.
The template owns visual identity and alignment; a deck picks a frame and fills
it. The full reference is [docs/layout-vocabulary.md](docs/layout-vocabulary.md).

## Requirements

- A TeX distribution with **XeLaTeX**, **latexmk** and **biber**
  (MacTeX or TeX Live, for example).
- The fonts in [`fonts/`](fonts/) — the theme loads them with `fontspec`,
  so the `fonts/` directory has to sit next to your deck, exactly as in this
  repository.

## Repository layout

- `main_template.tex` — the demo deck. Copy it (or the whole repository) to
  start a presentation.
- `template/` — the theme. `beamerthemegeoslides.sty` loads the preamble
  (packages, colours, maths macros), the inner, outer and colour sub-themes,
  and the frames that define the layout vocabulary.
- `docs/layout-vocabulary.md` — the reference for the layout vocabulary: the
  nine frames, the artifact blocks, the navigation links and the title block.
- `fonts/` — the house fonts (Neutra Text and Sentinel).
- `figures/` — your figures; `figures/logos/` holds the front and sidebar
  logos, switched on in `template/beamerouterthemegeoslides.sty`.
- `tables/` — `.tex` table fragments the deck's estimation code writes.
- `references/` — `references.bib`; the deck preamble discovers it
  automatically (also when the deck is compiled from a subdirectory).

## Getting started

1. Copy `main_template.tex` to your deck — or fork the whole repository, since
   paths inside the theme are relative to the main `.tex` file.
2. Fill in the deck header: `\title`, `\subtitle`, `\authorsperrow` +
   one `\addauthor` per author, `\institute`, `\date`, `\subject`.
3. Drop the demo frames and build your deck out of the layout vocabulary.
4. Put figures in `figures/`, table fragments in `tables/`, and citations in
   `references/references.bib`.
5. Compile.

## Compiling

```bash
latexmk -pdf -xelatex main_template.tex
```

latexmk detects biber on its own. To run the chain by hand:
`xelatex → biber → xelatex → xelatex`.

## The layout vocabulary

A deck is built from nine frames — title, standout, content, figure, table,
split, closing, outline and backup-divider — plus the artifact blocks that go
inside them, the flat navigation links, and the multi-author title block. The
template owns alignment and styling, so a deck never writes column
environments, manual spacing or `\resizebox` of its own.

The quick shape of a deck:

```latex
\titleframe
\outlineframe

\section{Introduction}
\outlineframe[toc=currentsection]

\begin{contentframe}[title=Introduction, label=slide:introduction]
    \begin{itemize}
        \item A claim, with a link that belongs to it:
              \slidelink{slide:backup-detail}{the derivation}.
    \end{itemize}
\end{contentframe}

\begin{figureframe}[title=A Figure]
    \slidefigure[width=.7\linewidth,
                 caption={A caption in the house style.}]{figures/result}
\end{figureframe}

\begin{closingframe}[message=Thank you!, contact=your@email.com]
\end{closingframe}

\appendix
\backupdividerframe
\outlineframe[index]
\section{Derivations}
\begin{contentframe}[title=A Backup Slide, label=slide:backup-detail,
                     links={\slideback{slide:introduction}}]
    % ...
\end{contentframe}
```

The full reference — every frame, option, artifact block and link — is in
[docs/layout-vocabulary.md](docs/layout-vocabulary.md).
