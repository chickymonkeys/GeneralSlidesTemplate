# GeneralSlidesTemplate
Custom Slides Template to start from for presentations 

- **FIXME** Citations are not coloured when it comes to pages and additional
arguments for the `\citet{}` command. Workaround done, but not nice.
- **FIXME** There is a bit of a mess in the way the template works, tidy up.
- **FIXME** There is an issue with the lists not working as in the layout for
drafts.

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