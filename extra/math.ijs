NB. analogous to \mathop ; returns an operator that takes a set of limits
NB. 'l^u' on the left and an argument on the right.
mathop =: 1 :0
k@:(('\',u,'_'),[) concat ]
)
3 :('(y)=:y mathop';'EMPTY')@> , ;:;._2 ]0 :0
sum       prod       coprod
bigoplus  bigotimes  bigodot
bigcup    bigcap     biguplus
bigsqcup  bigvee     bigwedge
int       oint       iint
iiint     iiiint     idotsint
)
