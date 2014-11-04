NB. Allow load/require to get files in extra/
EXPATH =. FILEPATH,'extra/'
extras =. (<'core') -.~ _4&}.&.> {."1 ]1!:0 jpath EXPATH,'*.ijs'
Public_j_ =: Public_j_ ,~ (,. (EXPATH , ,&'.ijs')&.>) extras

toString =: ;@:treetotex@:tonode :. toL
toStrings=: treetotex@:tonode"0

concat =: (<<,',') on ,&tonode

mathinline =: ('$$'surround) &.: toString
mathdisp =: ('\[',:'\]')surround &.: toString

NB. non-printing assignment operator
is =: 4 :'empty (>x) =: y'

declare =: (1 :('''EMPTY'';~''(>x)=:'',u')) (4 :)~~(&>) (&:(;:^:(0=L.)))
DeclareConst =: 'toL ''\'',y' declare
DeclareFunc =: '(<''\'',y) on ,&tonode' declare
DeclareOp =: '(<''\\'',y) on ,&tonode' declare
