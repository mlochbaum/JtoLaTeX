This is JtoLaTeX, a compiler which writes LaTeX files using J evaluation
for the hard bits.

This project aims to be extensible, and to interface well with J.
A natural corollary of this behavior will be a particularly powerful
formatting language.

The script `jlatex` can be run on a document, and will compile it to a
.tex document and then run pdflatex on that.

To install,
```shell
$ cd ~user/
$ git clone git://github.com/mlochbaum/JtoLaTeX.git
# ln -s JtoLaTeX/jlatex /usr/bin/jlatex
```
where ~user is given by
```J
   jpath '~user'
```
in J.

If you want to install in a different location, you must change the line
```J
FILEPATH =: '~user/JtoLaTeX/'
```
at the top of both jlatex and jlatex.ijs to use the appropriate path.

Documents are written in LaTeX, except that a section enclosed in an
escape like `\L()` (`L` could be any name) will be executed according to
the verb `L_pjdoc_` in jdoc.ijs. In particular, `L` converts a J
expression into an "equivalent" LaTeX expression, sending `'2+^~<:5'` to
`'2+(5-1)^{5-1}'`, for example.

Addons (in the `extra/` folder) allow you to create matrices, tables,
plots, and more cleanly from J.

See doc/introduction/document.pdf for information about the built-in
features of JtoLaTeX. core/document.pdf describes the additional
functionality which is automatically loaded, and the other documentation
provides information about available addons.
