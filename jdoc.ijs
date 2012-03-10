NB. FUNCS gives the available functions to be used on text.
NB. each should take and return a string.
cocurrent 'pjdoc'
  J =: ":@".
  A =: ''[".
  L =: latex_base_
  P =: pd_z_
cocurrent 'base'

NB. execute \?(expr) using the correct function for ? .
ex_jdoc =: 3 :0
  'func data' =. (({.~;}.~) i.&'(') y
  ('_pjdoc_',~}.func)~  process_jdoc }.}:data
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
