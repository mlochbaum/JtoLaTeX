NB. Force conversion to latex entity.
toL =: k^:(-.@isnode)

NB. Takes a J function on strings and makes it latex-compatible.
asL =: 1 :'(<{.u`'''') on toL'
NB. J function on an array of boxed strings.
masL =: 1 :'(<{.u@:treetotex`'''') on <@<@:toL'

NB. Make atomic
atomize =: ,asL
concat =: atomize@:,

mathinline =: ('$',,&'$') asL
mathdisp =: ('\[',,&'\]') asL

NB. non-printing assignment operator
is =: 4 :'empty (>x) =: y'
DeclareConst =: 4 :'empty (x)=:k ''\'',&.>y'~~"0 &: (;:^:(0=L.))
