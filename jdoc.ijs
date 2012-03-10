NB. FUNCS gives the available functions to be used on text.
NB. each should take and return a string.
FUNCS =: ;:'D A J P'

cocurrent 'pfunc'
  D =: ":@".
  A =: empty@".
  J =: latex_base_
  P =: pd_z_
cocurrent 'base'

NB. execute \?(expr) using the correct function for ? .
ex_jdoc =: 3 :0
  'func data' =. (({.~;}.~) i.&'(') y
  ('_pfunc_',~}.func)~  process_jdoc }.}:data
)

NB. take the text of a document and process it.
process_jdoc =: 3 :0
  nest =. +/\ 1 _1 0 {~ '()'i. text =. y
  groups =. /:~ ; (('\',,&'(')&.>FUNCS) I.@E.&.> <text
  ind=.off=.0
  while. #groups do.
    'ind off' =. (ind,off)+{.groups
    text=.text|.~{.groups
    length =. >: nest ((i.{:)@:(|.~ind&+) + ]) '('i.~ text
    groups =. (#~>:&0) (-length+{.)groups
    text =. ,~&>/ 'r t'=.length (ex_jdoc@:{. ; }.) text
    ind =. ind+length  [  off=.off+#r
  end.
  (-off)|.text
)
