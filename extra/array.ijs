NB. Make a list infinite by appending '\ldots'.
inf =: (totree'\_ldots') ,~ tonode

NB. Surround y with \begin{x} \end{x}
toLines =: <;._2@:(,&LF^:(LF~:{:))  :.  (;@:(,&LF&.>))
indent =: '  '&,&.>&.toLines
inenv =: '\begin{',[,'}',LF,indent@],'\end{',[,'}',LF"_

NB. Functions for handling lists and vectors.
listwith =: (texs [:>([,',',])&.>/)"1
rowvec =: '()' listwith toStrings
tableform =: [:> [:([,(' \\',LF),])&.>/ ([,' & ',])&.>/"_1
totable =: tableform@:toStrings
mtypes =. ;:'matrix bmatrix Bmatrix pmatrix vmatrix Vmatrix'
".@:(],' =: ''',],''' inenv totable'"_)@> mtypes
NB. Left argument is of the form 'rl|ll|lll|r', as in tabular.
NB. Put \hlines where '|'s are; treat all non-space characters the same.
splitrows =: 1 :0
  (((*+/\) '|'~:u-.SPACE) { (<'\hline')&,)&.toLines
)

j=.(&,)(,hook)
textlist =: ]`(,'and 'j&":&:>/)`(', 'j&":&:>/@}:,', and ',":@>@{:)@.(1 2 I.#)
