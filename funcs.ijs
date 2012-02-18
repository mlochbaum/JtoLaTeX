NB. J functions which can be used in latex code

NB. Force conversion to latex entity.
tol =: k^:(-.@isnode)

NB. Takes a J function on strings and makes it latex-compatible.
asL =: 1 :'(<{.u`'''')&on'
NB. J function on an array of boxed strings.
masL =: 1 :'(<{.u@:treetotex`'''') on <@<'

NB. Make a list infinite by appending '\ldots'.
inf =: (totree'\_ldots') ,~ tol

NB. Surround y with \begin{x} \end{x}
tolines =: <;._2@:(,&LF^:(LF~:{:))  :.  (;@:(,&LF&.>))
indent =: '  '&,&.>&.tolines
inenv =: '\begin{',[,'}',LF,indent@],'\end{',[,'}',LF"_

NB. Functions for handling lists and vectors.
listwith =: (texs [:>([,',',])&.>/)"1
rowvec =: '()'&listwith masL
tableform =: [:> [:([,(' \\',LF),])&.>/ ([,' & ',])&.>/
mtypes =. ;:'matrix bmatrix Bmatrix pmatrix vmatrix Vmatrix'
".@:(],' =: (''',],''' inenv tableform) masL'"_)@> mtypes
