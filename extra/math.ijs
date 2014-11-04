of =: toL @: (>@{. , >@>@rowvec@}.) @: toStrings@:,&:tonode

NB. analogous to \mathop ; returns an operator that takes a set of limits
NB. 'l^u' on the left and an argument on the right.
toBound =: ('_^'{.~#) texa1&.>(;@:) toStrings
mathsumop =: 1 :0
((< '\\',u) on ,&tonode) : (([:< '\\',u,toBound@[) on ,&tonode@]) " 1 0
)

DeclareOp (LF;' ') rplc~ 0 :0
oplus     otimes
)

DeclareMathSumOp =: 'y mathsumop' declare
DeclareMathSumOp (LF;' ') rplc~ 0 :0
sum       prod       coprod
bigoplus  bigotimes  bigodot
bigcup    bigcap     biguplus
bigsqcup  bigvee     bigwedge
int       oint       iint
iiint     iiiint     idotsint
)

paren1=: ((<,'(')on tonode) ^: ((1<#@;:@":)`(0<#@args)@.(*@L.))
paren =: paren1`rowvec@.(1~:#) @: (] :,)
DeclareMathOp =: '(<''\\'',y) on tonode@:paren' declare
DeclareMathOp (LF;' ') rplc~ 0 :0
sin  cos  tan  sec  csc  cot
sinh cosh tanh coth
)

mathlimop =: 1 :0
(toL '\',u,' ')"_ : ((toL '\',u) ((<'_')on,&tonode) [) concat ]
)
DeclareMathLimOp =: 'y mathlimop' declare
DeclareMathLimOp (LF;' ') rplc~ 0 :0
lim
max     min
inf     sup
liminf  limsup
)
