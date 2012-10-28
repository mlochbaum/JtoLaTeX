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

declare =: (1 :('''EMPTY'';~''(>x)=:'',u')) (4 :)~~(&>) (&:(;:^:(0=L.)))
DeclareConst =: 'k ''\'',y' declare
DeclareFunc =: '(<''\'',y) on ,&tonode' declare
DeclareMathOp =: '(<''\\'',y) on ,&tonode' declare
