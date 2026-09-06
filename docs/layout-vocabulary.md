# The GeoSlides layout vocabulary

This is the reference for the layout vocabulary `template/beamerframesgeoslides.sty`
defines. It is the whole public surface a deck (or the generator that fills a deck)
is allowed to build on.

## The governing rule

The template owns visual identity and alignment. A deck picks a frame and fills
it, and never writes its own markup: no column environments, no manual spacing,
no `\resizebox`, no aspect-ratio flags. If a slide cannot be expressed here, the
fix belongs in the template, not in the deck.

## The nine frames

Seven frames are authorable in a deck; two are emitted from structure and never
written by hand.

| frame | kind | body |
|---|---|---|
| `\titleframe` | plain macro | none — built from the deck header |
| `\begin{standoutframe}` | environment | one sentence, full bleed, inverted palette |
| `\begin{contentframe}` | environment | prose, bullets and equations, top-aligned |
| `\begin{figureframe}` | environment | exactly one `\slidefigure` |
| `\begin{tableframe}` | environment | exactly one `\slidetable` |
| `\begin{splitframe}` | environment | left column, `\splitnext`, right column |
| `\begin{closingframe}` | environment | the thank-you slide |
| `\outlineframe` | plain macro | the table of contents, emitted from structure |
| `\backupdividerframe` | plain macro | the appendix divider, emitted from structure |

Frames with a body are environments that take a keyval option list; frames
without one are plain macros. `\outlineframe` and `\backupdividerframe` take
the same option list, `\titleframe` takes none. Options are optional, may be
given in any order, and adding one later never renumbers an existing call site.

### Options every frame understands

| option | meaning |
|---|---|
| `title=` | the frame title |
| `subtitle=` | the qualifying line under it |
| `label=` | an anchor name, the target a `\slidelink` or `\slideback` points at |
| `links=` | links about the whole frame, printed at the end of the subtitle line |

### Options for one frame each

| frame | option | meaning |
|---|---|---|
| `splitframe` | `leftwidth=`, `rightwidth=` | column widths |
| `closingframe` | `message=`, `contact=` | the sign-off and an email address |
| `outlineframe` | `toc=` | anything `\tableofcontents` itself accepts, e.g. `currentsection` |
| `outlineframe` | `index` | this outline is the appendix index; the footer link points at it |

## Artifact blocks

A figure or a table reaches a deck as one of these two blocks. They own the
fitting, so no deck writes `\resizebox` or `keepaspectratio` itself.

- `\slidefigure[keys]{path}` — a figure the project's code wrote, or one
  exported from someone else's PDF.
- `\slidetable[keys]{path}` — by default a `.tex` fragment the estimation code
  wrote, pulled in with `kind=input`; `kind=file` draws an image instead, which
  is how a table recovered from a PDF arrives.

| option | meaning |
|---|---|
| `width=`, `height=` | how wide to draw it, and the ceiling it may not exceed |
| `caption=` | the paragraph under it |
| `note=` | a short source or reading line |
| `label=` | an anchor name, for `\ref` |
| `link=` | a link belonging to this artifact |
| `kind=` | `input` (a `.tex` fragment) or `file` (an image), tables only |

## Flat navigation links

- `\slidelink{anchor}{text}` — a forward link, drawn as a coloured word with no
  button box: the template paints the button and its border in the frame
  background.
- `\slideback{anchor}` — the return link, worded by `\slidebackname` (default
  "Back").
- `\appendixindexlink` — declared in the deck preamble, puts one permanent link
  to the appendix index in the footer of every frame. Off unless declared,
  because a deck with no appendix has nothing to point at.

A link asserts "this backup answers a question about this claim", which is
editorial judgement, so a deck states its links; the generator never invents
one.

## The appendix

Sections are containers, and the appendix is a container too. A deck writes:

```latex
\appendix
\backupdividerframe
\outlineframe[index]
\section{Derivations}
% ... backup slides ...
```

`\appendix` restarts the frame numbering and keeps the backup slides out of the
"n / N" in the footer (via `appendixnumberbeamer`). `\backupdividerframe` is the
divider that opens the appendix. The outline inside it is the index of every
backup slide by topic; marking it `[index]` is what the footer link points at,
so any backup slide is two clicks away and `\slideback` returns.

## The multi-author title block

```latex
\authorsperrow{2}
\addauthor[Surname]{Full Name}{Affiliation}
\addauthor[Surname]{Full Name}{Affiliation}
```

One `\addauthor` per author, in the deck preamble. The template lays them out in
rows of `\authorsperrow`, builds the short form for the footer ("First and
Second" from `Surname`), and re-issues `\author`, so no deck hand-builds a
column block inside `\author{}`. The optional argument is the name for the
footer and the PDF metadata; it defaults to the full name. Call
`\authorsperrow` before the first `\addauthor`.

## Deck header fields

Every field is stated by the deck, never inferred: `\title`, `\subtitle`,
`\authorsperrow` + `\addauthor`, `\institute`, `\date`, `\subject`. The plain
`\author` form with `\inst{}` still works for decks that prefer it.

## What stays out

- `\allowframebreaks` is deliberately not used anywhere in the template: it
  splits a frame silently, breaking one idea per slide and renumbering
  everything downstream.
- There is no third vocabulary manifest. The notation idiom (colour shorthands,
  maths operators, matrix and set wrappers) is shared with the draft template
  and stays fixed-arity; the frames are a document layer on top of it.

## Known limitations

- The frame environments wrap beamer's own `frame`, so a slide that needs
  `[fragile]` (verbatim, listings, minted) has to be written as a plain
  `\begin{frame}[fragile]`.
- `\backupbegin` and `\backupend` survive as no-ops so decks written against the
  older template still compile. New decks need neither: `\appendix` before the
  backup divider frame is enough.
