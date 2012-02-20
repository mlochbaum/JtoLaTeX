NB. J functions which can be used in latex code

load FILEPATH,'plot.ijs'

NB. Force conversion to latex entity.
toL =: k^:(-.@isnode)

NB. Takes a J function on strings and makes it latex-compatible.
asL =: 1 :'(<{.u`'''') on toL'
NB. J function on an array of boxed strings.
masL =: 1 :'(<{.u@:treetotex`'''') on <@<@:toL'

NB. Make a list infinite by appending '\ldots'.
inf =: (totree'\_ldots') ,~ toL

NB. Surround y with \begin{x} \end{x}
toLines =: <;._2@:(,&LF^:(LF~:{:))  :.  (;@:(,&LF&.>))
indent =: '  '&,&.>&.toLines
inenv =: '\begin{',[,'}',LF,indent@],'\end{',[,'}',LF"_

NB. Functions for handling lists and vectors.
listwith =: (texs [:>([,',',])&.>/)"1
rowvec =: '()'&listwith masL
tableform =: [:> [:([,(' \\',LF),])&.>/ ([,' & ',])&.>/"_1
totable =: tableform masL
mtypes =. ;:'matrix bmatrix Bmatrix pmatrix vmatrix Vmatrix'
".@:(],' =: (''',],''' inenv tableform) masL'"_)@> mtypes

mathinline =: ('$',,&'$') asL
mathdisp =: ('\[',,&'\]') asL

NB. Physics (and other sciences, I suppose)
mean =: (+/%#)"1
stddev =: (+/%<:@#)&.:*:@:(-mean)"1
stderr =: stddev % %:@#"1
dot =: +/@:*
corrsq =: (*:@dot % *&(dot~))&(-mean)"1
corr =: %:@corrsq   NB. correlation coefficient R
slopeRU =: [:%: (2-~#"1@]) %~ <:@%@corrsq
intRU =: slopeRU*mean&.:*:@[
int_slope =: (1,.[)%.~]
int_slopeWithU =: int_slope ([ ,. {.@[*]) intRU,slopeRU

NB. All format commands output a double-boxed string. Careful!
fmtExp =: ([,'\times10^{',],'}'"_)&":&.>&.>
fmtDig =: <@:(":@[ 8!:0 ]) "0
genFmtPrec =: (1 :0) ("0) NB. precision (expcutoff genFmtPrec) number
:
  exp =. 10 <.@^. y
  if. u>:|exp-0.5 do. (0>.x->:exp) fmtDig y
  else. ((<:x) fmtDig y%10^exp) fmtExp toL exp end.
)
fmtPrec =: 3 genFmtPrec
fmtU =: _ genFmtPrec~ 1+1=(<.@%<.&.(10&^.))
fmtWithU =: 3 :0 "1
  nd =. >:-/ exp=. 10<.@^. 'N U'=.y
  if. 3>:|{.exp do. (nd fmtPrec N)([,'\pm',])&.>&.>(fmtU U)
  else. (('(',,&')')&.>&.>fmtWithU y%10^{.exp) fmtExp {.exp end.
)
Umean =: ([: fmtWithU mean,stderr)"1

unit =: (,&)asL("0)

calcwithU =: 1 :'(u@{.([,|@-)u@(+/))"1'
