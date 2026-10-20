# latexmk settings for the deck, read by latexmk on the command line, by
# editors that build with it (VS Code's LaTeX Workshop, VimTeX, TeXstudio's
# latexmk command) and by Overleaf, which reads this file from the project root.
#
# The engine is the one the main file names on a "% !TeX program = ..." line in
# its first lines -- XeLaTeX for this template, which the theme's fonts need --
# even when latexmk is asked for pdfLaTeX with -pdf, as Overleaf and most
# editors ask by default. latexmk runs Biber by itself when the deck cites.

$pdf_mode = 5;    # XeLaTeX when the main file names no engine

my %mode   = (pdflatex => 1, lualatex => 4, xelatex => 5);
my %option = (pdflatex => '-pdf', lualatex => '-lualatex', xelatex => '-xelatex');

foreach my $arg (grep { !/^-/ } @ARGV) {
    my $source = -f $arg ? $arg : "$arg.tex";    # editors may drop the .tex
    open my $fh, '<', $source or next;
    while (my $line = <$fh>) {
        last unless $line =~ /^\s*(?:%|$)/;
        if ($line =~ /^\s*%\s*!\s*TeX\s+program\s*=\s*(pdflatex|xelatex|lualatex)\b/i) {
            my $engine = lc $1;
            $pdf_mode = $mode{$engine};              # latexmk main.tex
            s/^-pdf$/$option{$engine}/ for @ARGV;    # latexmk -pdf main.tex
            last;
        }
    }
    close $fh;
}

# Beamer's own auxiliary files, removed by latexmk -c with the rest.
$clean_ext .= ' nav snm vrb';
