NB. FUNCS gives the available functions to be used on text.
NB. each should take and return a string.
onlines =: (;._2)(@:(,LF#~LF~:{:))
lines =: <onlines :. unlines
unlines =: ;@:(,&LF&.>) :. lines

execute =: [:unlines <@":@".onlines
assign =: ''[(''[".)onlines
getstring =: 3 :''''' [ (({.~i.&LF)y) =: (}.~>:@i.&LF)y'
cocurrent 'pjdoc'
  J =: execute_base_
  A =: assign_base_
  L =: latex_base_
  P =: pd_base_
  S =: getstring_base_
cocurrent 'base'

NB. execute \?(expr) using the correct function for ? .
ex_jdoc =: 3 :0
  'func data' =. (({.~;}.~) i.&'(') y
  , ('_pjdoc_',~}.func)~  process_jdoc }.}:data
)

NB. take the text of a document and process it.
process_jdoc =: 3 :0
  getfuncs =. ('\',,&'(')&.> @: nl_pjdoc_
  nest =. +/\ 1 _1 0 {~ '()'i. text =. y
  start =. <./ ; (getfuncs'') (1 i.~E.)&.> <text
  ptext =. ''
  while. start<#text do.
    ptext =. ptext,add ['add text'=.start ({.;}.) text
    nest =. start}.nest
    length =. >: nest ((i.{:)@:|.~ + ]) '('i.~ text
    ptext =. ptext,add ['add text'=.length (ex_jdoc@:{. ; }.) text
    nest =. length}.nest
    start =. <./ ; (getfuncs'') (1 i.~E.)&.> <text
  end.
  ptext,text
)
