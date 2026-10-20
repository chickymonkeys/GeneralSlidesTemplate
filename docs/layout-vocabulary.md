# The GeoSlides layout vocabulary (optional)

`geoslidesframes.sty` keeps the frame vocabulary of GeoSlides 1.x: nine frames
filled through keyval options, two artifact blocks that fit figures and tables,
and a multi-author title block. It exists for decks written against version 1
and for the deck generator that emits it.

**New decks do not need it.** Write plain Beamer frames and the theme styles
them; see the [README](../README.md). To use the vocabulary, load it after the
theme:

```latex
\usetheme{geoslides}
\usepackage{geoslidesframes}
```

## The rule it follows

A deck written in the vocabulary picks a frame and fills it, and leaves the
markup to the package: no column environments, no manual spacing, no
`\resizebox`. That is what lets a generator fill a deck without layout
decisions of its own. A deck can still mix in plain `\begin{frame}` wherever
the vocabulary has no frame for a slide.

## The nine frames

Seven frames are authorable in a deck; two are emitted from structure and never
written by hand.

| frame                   | kind        | body                                          |
| ----------------------- | ----------- | --------------------------------------------- |
| `\titleframe`           | plain macro | none — built from the deck header             |
| `\begin{standoutframe}` | environment | one sentence, full bleed, inverted palette    |
| `\begin{contentframe}`  | environment | prose, bullets and equations, top-aligned     |
| `\begin{figureframe}`   | environment | exactly one `\slidefigure`                    |
| `\begin{tableframe}`    | environment | exactly one `\slidetable`                     |
| `\begin{splitframe}`    | environment | left column, `\splitnext`, right column       |
| `\begin{closingframe}`  | environment | the thank-you slide                           |
| `\outlineframe`         | plain macro | the table of contents, emitted from structure |
| `\backupdividerframe`   | plain macro | the appendix divider, emitted from structure  |

Frames with a body are environments that take a keyval option list; frames
without one are plain macros. `\outlineframe` and `\backupdividerframe` take
the same option list, `\titleframe` takes none. Options are optional, may be
given in any order, and adding one later never renumbers an existing call site.

In plain Beamer the same slides are `\maketitle`, `\begin{frame}[standout]`,
`\begin{frame}[t]{Title}{Subtitle}`, a `figure` or `table` inside a frame, the
`columns` environment, and a frame with `\tableofcontents`.

### Options every frame understands

| option      | meaning                                                              |
| ----------- | -------------------------------------------------------------------- |
| `title=`    | the frame title                                                      |
| `subtitle=` | the qualifying line under it                                         |
| `label=`    | an anchor name, the target a `\slidelink` or `\slideback` points at  |
| `links=`    | links about the whole frame, printed at the end of the subtitle line |

### Options for one frame each

| frame          | option                      | meaning                                                           |
| -------------- | --------------------------- | ----------------------------------------------------------------- |
| `splitframe`   | `leftwidth=`, `rightwidth=` | column widths                                                     |
| `closingframe` | `message=`, `contact=`      | the sign-off and an email address                                 |
| `outlineframe` | `toc=`                      | anything `\tableofcontents` itself accepts, e.g. `currentsection` |
| `outlineframe` | `index`                     | this outline is the appendix index; the footer link points at it  |

## Artifact blocks

A figure or a table reaches a deck as one of these two blocks. They own the
fitting, so no deck writes `\resizebox` or `keepaspectratio` itself.

- `\slidefigure[keys]{path}` — a figure the project's code wrote, or one
  exported from someone else's PDF.
- `\slidetable[keys]{path}` — by default a `.tex` fragment the estimation code
  wrote, pulled in with `kind=input`; `kind=file` draws an image instead, which
  is how a table recovered from a PDF arrives.

| option              | meaning                                                       |
| ------------------- | ------------------------------------------------------------- |
| `width=`, `height=` | how wide to draw it, and the ceiling it may not exceed        |
| `caption=`          | the paragraph under it                                        |
| `note=`             | a short source or reading line                                |
| `label=`            | an anchor name, for `\ref`                                    |
| `link=`             | a link belonging to this artifact                             |
| `kind=`             | `input` (a `.tex` fragment) or `file` (an image), tables only |

## Navigation links

`\slidelink{anchor}{text}` and `\slideback{anchor}` come with the theme, so
they work with or without this package. The theme also puts an _Appendix_ link
in the footer of any deck with an `\appendix`, pointing at its first frame.

- `\appendixindexlink` — declared in the deck preamble, points that footer link
  at the appendix index (`\outlineframe[index]`) instead.

A link asserts "this backup answers a question about this claim", which is
editorial judgement, so a deck states its links; the generator never invents
one.

## The appendix

```latex
\appendix
\backupdividerframe
\outlineframe[index]
\section{Derivations}
% ... backup slides ...
```

`\appendix` restarts the frame numbering and keeps the backup slides out of the
"n / N" in the footer. `\backupdividerframe` is the divider that opens the
appendix. The outline inside it is the index of every backup slide by topic;
marking it `[index]` is what `\appendixindexlink` points at, so any backup
slide is two clicks away and `\slideback` returns.

## The multi-author title block

```latex
\authorsperrow{2}
\addauthor[Surname]{Full Name}{Affiliation}
\addauthor[Surname]{Full Name}{Affiliation}
```

One `\addauthor` per author, in the deck preamble. Each call re-issues
`\author` with every author so far, the affiliation under each name, and the
short names for the footer ("First and Second"). The optional argument is the
name for the footer; it defaults to the full name. `\authorsperrow{n}` is the
theme option `authorsperrow=n`.

The same title page in plain Beamer is `\author{A \and B}` with
`\institute{X \and Y}`.

## Known limitations

- The frame environments wrap Beamer's own `frame`, so a slide that needs
  `[fragile]` (verbatim, listings, minted) has to be written as a plain
  `\begin{frame}[fragile]`.
- `\allowframebreaks` is not offered: it splits a frame silently, breaking one
  idea per slide. A plain `\begin{frame}[allowframebreaks]` still works where it
  is wanted, as for the reference list.
