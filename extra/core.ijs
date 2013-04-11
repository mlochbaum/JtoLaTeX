toString =: ;@:treetotex@:tonode

NB. Make atomic
atomize =: (<<,',') on tonode
concat =: atomize@:,

mathinline =: '$$'surround @: toString
mathdisp =: ('\[',:'\]')surround @: toString

NB. non-printing assignment operator
is =: 4 :'empty (>x) =: y'

declare =: (1 :('''EMPTY'';~''(>x)=:'',u')) (4 :)~~(&>) (&:(;:^:(0=L.)))
DeclareConst =: 'toL ''\'',y' declare
DeclareFunc =: '(<''\'',y) on ,&tonode' declare
DeclareMathOp =: '(<''\\'',y) on ,&tonode' declare
