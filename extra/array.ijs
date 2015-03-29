NB. Make a list infinite by appending '\ldots'.
inf =: (totree'\_ldots') ,~ tonode

NB. Surround y with \begin{x} \end{x}
toLines =: <;._2@:(,&LF^:(LF~:{:))  :.  (;@:(,&LF&.>))
indent =: '  '&,&.>&.toLines
inenv =: '\begin{',[,'}',LF,indent@],'\end{',[,'}',LF"_

NB. Functions for handling lists and vectors.
listwith =: (([,',',])&.>/"1@:toStrings) : ((<@:texs >)"1 0 $:)
rowvec =: '()'&listwith
tableform =: [:> [:([,(' \\',LF),])&.>/ ([,' & ',])&.>/"_1
totable =: tableform@:toStrings
mtypes =. ;:'matrix bmatrix Bmatrix pmatrix vmatrix Vmatrix'
".@:(],' =: [: toL ''',],''' inenv totable'"_)@> mtypes
NB. Left argument is of the form 'rl|ll|lll|r', as in tabular.
NB. Put \hlines where '|'s are; treat all non-space characters the same.
splitrows =: 1 :0
  (((*+/\) '|'~:u-.SPACE) { (<'\hline')&,)&.toLines
)

NB. Turn a list of boxed strings into an English list (a single string).
j=.(&,)(,hook)(&:>)
textlist =: >`(' and 'j/)`(', 'j/@}: ', and 'j {:)@.(1 2 I.#)@:(":&.>)
NB. Turn a list of objects into a list of inline math-mode expressions.
NB. Use with \L().
mathlist =: [: textlist <@toString@:mathinline"0
