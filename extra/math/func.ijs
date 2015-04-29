require 'math'

'from' DeclareOp 'colon'
'to' DeclareOp 'rightarrow'
DeclareOp 'mapsto'
'o' DeclareOp 'circ'

star =: ('^'OP)&'*'
prime =: concat&''''
inv =: ('^'OP)&_1
if =: inv@[ of ]
commutes =: 2 : 'u@:v (''=''OP) v&:u'
res =: (texa1~ '|_' ,~ ('\left.',,&'\right')^:iftall)~ &. toString
