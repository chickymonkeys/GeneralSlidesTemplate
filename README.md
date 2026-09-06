# GeneralSlidesTemplate
Custom Slides Template to start from for presentations 

- **FIXME** Citations are not coloured when it comes to pages and additional
  arguments for the `\citet{}` command. Workaround done, but not nice.
- **FIXME** There is a bit of a mess in the way the template works, tidy up.
- **FIXME** There is an issue with the lists not working as in the layout for
  drafts.

---

# Layout vocabulary

The template defines nine frames a deck is built from — title, standout,
content, figure, table, split, closing, outline and backup-divider — plus the
artifact blocks that go inside them, the flat navigation links, and a
structured multi-author title block. A deck picks a frame and fills it; the
template owns alignment and styling, so a deck never writes column
environments, manual spacing or `\resizebox` of its own.

The full reference is [docs/layout-vocabulary.md](docs/layout-vocabulary.md).
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

Compile with `latexmk -pdf -xelatex -biber main_template.tex`.

---

# LaTeX Workshop Settings for VSCODE

```json
{
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": [
        "-shell-escape",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "-pdf",
        "-outdir=%OUTDIR%",
        "%DOC%"
      ],
      "env": {}
    },
    {
      "name": "lualatexmk",
      "command": "latexmk",
      "args": [
        "-shell-escape",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "-lualatex",
        "-outdir=%OUTDIR%",
        "%DOC%"
      ],
      "env": {}
    },
    {
      "name": "xelatexmk",
      "command": "latexmk",
      "args": [
        "-shell-escape",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "-xelatex",
        "-outdir=%OUTDIR%",
        "%DOC%"
      ],
      "env": {}
    },
    {
      "name": "latexmk_rconly",
      "command": "latexmk",
      "args": [
        "%DOC%"
      ],
      "env": {}
    },
    {
      "name": "pdflatex",
      "command": "pdflatex",
      "args": [
        "-shell-escape",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
      ],
      "env": {}
    },
    {
      "name": "bibtex",
      "command": "bibtex",
      "args": [
        "%DOCFILE%"
      ],
      "env": {}
    },
    {
      "name": "rnw2tex",
      "command": "Rscript",
      "args": [
        "-e",
        "knitr::opts_knit$set(concordance = TRUE); knitr::knit('%DOCFILE_EXT%')"
      ],
      "env": {}
    },
    {
      "name": "jnw2tex",
      "command": "julia",
      "args": [
        "-e",
        "using Weave; weave(\"%DOC_EXT%\", doctype=\"tex\")"
      ],
      "env": {}
    },
    {
      "name": "jnw2texminted",
      "command": "julia",
      "args": [
        "-e",
        "using Weave; weave(\"%DOC_EXT%\", doctype=\"texminted\")"
      ],
      "env": {}
    },
    {
      "name": "pnw2tex",
      "command": "pweave",
      "args": [
        "-f",
        "tex",
        "%DOC_EXT%"
      ],
      "env": {}
    },
    {
      "name": "pnw2texminted",
      "command": "pweave",
      "args": [
        "-f",
        "texminted",
        "%DOC_EXT%"
      ],
      "env": {}
    },
    {
      "name": "tectonic",
      "command": "tectonic",
      "args": [
        "--synctex",
        "--keep-logs",
        "--print",
        "%DOC%.tex"
      ],
      "env": {}
    }
  ],
  "latex-workshop.latex.recipes": [
    {
      "name": "latexmk",
      "tools": [
        "latexmk"
      ]
    },
    {
      "name": "latexmk (latexmkrc)",
      "tools": [
        "latexmk_rconly"
      ]
    },
    {
      "name": "latexmk (lualatex)",
      "tools": [
        "lualatexmk"
      ]
    },
    {
      "name": "latexmk (xelatex)",
      "tools": [
        "xelatexmk"
      ]
    },
    {
      "name": "pdflatex -> bibtex -> pdflatex * 2",
      "tools": [
        "pdflatex",
        "bibtex",
        "pdflatex",
        "pdflatex"
      ]
    },
    {
      "name": "xelatex -> bibtex -> xelatex * 2",
      "tools": [
        "xelatexmk",
        "bibtex",
        "xelatexmk",
        "xelatexmk"
      ]
    },
    {
      "name": "Compile Rnw files",
      "tools": [
        "rnw2tex",
        "latexmk"
      ]
    },
    {
      "name": "Compile Jnw files",
      "tools": [
        "jnw2tex",
        "latexmk"
      ]
    },
    {
      "name": "Compile Pnw files",
      "tools": [
        "pnw2tex",
        "latexmk"
      ]
    },
    {
      "name": "tectonic",
      "tools": [
        "tectonic"
      ]
    }
  ]
}
```