DeclareOp 'subset supset in setminus'
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
)

set =: ('\{';'\}')&texs &. toString

NB. st is "such that": (x st y) gives the set comprehension {x|y}.
STTEMP =. '\{\,x\mid y\,\}' ; '\left\{\,x\,\middle|\,y\,\right\}'
st =: ((STTEMP{::~+.&iftall) rplc 'x';[;'y';])&.toString

'from' DeclareOp 'colon'
'to' DeclareOp 'rightarrow'
DeclareOp 'mapsto'
