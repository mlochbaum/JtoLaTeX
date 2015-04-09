j=.(&,)(,hook)(&.>)
NB. Functions for handling lists and vectors.
list =: (','j/"1@:toStrings) : ((<@:texs >)"1 0 $:)
rowvec =: '()'&list

NB. Left argument is of the form 'rl|ll|lll|r', as in tabular.
NB. Put \hlines where '|'s are; treat all non-space characters the same.
splitrows =: 4 :0
  ((((*+/\) '|'~:x-.SPACE) ([,-.~) >:@i.@#) { (<'\hline')&,)&.toLines y
)
totable =: (' \\',LF)j/@:(' & 'j/"_1)(>@:)@:toStrings : (splitrows $:)
tabular =: (2{.boxopen)@[ (('tabular';'{','}',~>@{.@[) inenv >@{:@[ totable ]) ]
DeclareMatrix =: '[: toL y inenv totable'declare
DeclareMatrix 'bBpvV' (] , ,&.>) <'matrix'

NB. Turn a list of boxed strings into an English list (a single string).
textlist =: >`(' and 'j/)`(', 'j/@}: ', and 'j {:)@.(1 2 I.#)@:(":&.>)
NB. Turn a list of objects into a list of inline math-mode expressions.
NB. Use with \L().
mathlist =: [: textlist <@toString@:mathinline"0
