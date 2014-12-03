DeclareOp 'subset supset in'
DeclareFunc 'mathbb'
DeclareSet =: 'mathbb y' declare
(DeclareSet~ 2&#)@> ;: 'R Z N C'
II =: '[]' listwith 0 1

infix =: 1 :'concat u&concat'

DeclareInfix =: '(toL y) infix' declare
(({. DeclareInfix&:< stripl@:}.)~ i.&' ');._2 ]0 : 0
and    ,
quot   /
by     \,
comma  ,\quad 
sst    \,\middle|\,
)

set =: ('\{';'\}')&texs &. toString
st =: [:  (('\{\,';'\}') texs ,&'\,')&.toString  '\mid 'infix
'from' DeclareOp 'colon'
'to' DeclareOp 'rightarrow'
DeclareOp 'mapsto'
sset =: ('\left\{\,',:'\,\right\}')surround &. toString
