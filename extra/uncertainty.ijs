mean =: (+/%#)"1
stddev =: (+/%<:@#)&.:*:@:(-mean)"1
stderr =: stddev % %:@#"1
dot =: +/@:*
corrsq =: (*:@dot % *&(dot~))&(-mean)"1
corr =: %:@corrsq   NB. correlation coefficient R
slopeRU =: [:%: (2-~#"1@]) %~ <:@%@corrsq
intRU =: slopeRU*mean&.:*:@[
int_slope =: (1,.[)%.~]
int_slopeWithU =: int_slope ([ ,. {:@[|@*]) intRU,slopeRU

NB. All format commands output a double-boxed string. Careful!
fmtExp =: ([,'\times10^{',],'}'"_)&(('-',}.)^:('_'={.))&":&.>&.>
fmtDig =: <@:(":@[ 8!:0 ]) "0
genFmtPrec =: (1 :0) ("0) NB. precision (expcutoff genFmtPrec) number
:
  if. 0=y do. <<,'0.0' return. end.
  exp =. 10 <.@^. |y
  if. u>:|exp-0.5 do. (0>.x->:exp) fmtDig y
  else. ((<:x) fmtDig y%10^exp) fmtExp toL exp end.
)
fmtPrec =: 3 genFmtPrec
fmtU =: _ genFmtPrec~ 1+1.95>(%<.&.(10&^.))
fmtWithU =: 3 :0 "1
  y =. |y [ s =. '-'#~0>{.y
  nd =. >:-/ exp=. 10<.@^. 'N U'=.y
  if. (0={.y) +. 3>:|0.5-~{.exp do. (nd fmtPrec N)(s,[,'\pm',])&.>&.>(fmtU U)
  else. (('(',s,,&')')&.>&.>fmtWithU y%10^{.exp) fmtExp {.exp end.
)
Umean =: ([: fmtWithU mean,stderr)"1

unit =: (,&)(&.toString)("0)
textrm =: '\textrm'&texa&.toString
tunit =: (1 :'''\,\textrm{'',m,''}''')unit

calcwithU =: 1 :'(u@{.([,|@-)u@(+/))"1'
mcalcwithU =: 1 :0 ("2)
  ({."1 y) (u@[ ([, +/&.:*:@:-~) u@:+"1) (*=@i.@#){:"1 y
)
