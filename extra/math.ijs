of =: (>@{. , '()'texs[:>([,',',])&.>/@}.)masL @: ,

NB. analogous to \mathop ; returns an operator that takes a set of limits
NB. 'l^u' on the left and an argument on the right.
mathop =: 1 :0
((< '\\',u) on ,&tonode) : (([:< '\\',u,'_',[) on ,&tonode@])
)
DeclareMathSumOp =: 'y mathop' declare
DeclareMathSumOp (LF;' ') rplc~ 0 :0
sum       prod       coprod
bigoplus  bigotimes  bigodot
bigcup    bigcap     biguplus
bigsqcup  bigvee     bigwedge
int       oint       iint
iiint     iiiint     idotsint
)
