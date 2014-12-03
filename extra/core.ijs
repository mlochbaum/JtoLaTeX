NB. Allow load/require to get files in extra/
P =. jpath EXPATH =. FILEPATH,'extra/'
subdirs =. [: ,&'/'&.>@{."1 [: (#~'d'={.@>@{:"1) 1!:0
d =. (, [: $:^:(*@#) ([: subdirs P,,&'*')&.>(;@:)) ,a:
extras =. (<'core') -.~ ; (< (,_4&}.)&.> [:{."1[:1!:0 P,,&'*.ijs')&.> d
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
