toString =: ;@:treetotex@:tonode
toStrings=: treetotex@:tonode"0

NB. Make atomic
concat =: (<<,',') on ,&tonode

mathinline =: '$$'surround @: toString
mathdisp =: ('\[',:'\]')surround @: toString

NB. non-printing assignment operator
is =: 4 :'empty (>x) =: y'

declare =: (1 :('''EMPTY'';~''(>x)=:'',u')) (4 :)~~(&>) (&:(;:^:(0=L.)))
DeclareConst =: 'toL ''\'',y' declare
DeclareFunc =: '(<''\'',y) on ,&tonode' declare
DeclareMathOp =: '(<''\\'',y) on ,&tonode' declare
