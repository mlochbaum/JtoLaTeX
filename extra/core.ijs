NB. Allow load/require to get files in extra/
P =. jpath EXPATH =. FILEPATH,'extra/'
subdirs =. [: ,&'/'&.>@{."1 [: (#~'d'={.@>@{:"1) 1!:0
d =. (, [: $:^:(*@#) ([: subdirs P,,&'*')&.>(;@:)) ,a:
extras =. (<'core') -.~ ; (< (,_4&}.)&.> [:{."1[:1!:0 P,,&'*.ijs')&.> d
Public_j_ =: Public_j_ ,~ (,. (EXPATH , ,&'.ijs')&.>) extras

toString =: ;@:treetotex@:tonode :. toL
toStrings=: treetotex@:tonode"0

concat =: (<<,',') on ,&tonode
infix =: 1 :'concat u&concat'

mathinline =: ('$$'surround) &.: toString
mathdisp =: ('\[',:'\]')surround &.: toString

NB. x is (env) or (env;arg).
NB. Surround y with \begin{env}arg \end{env}
toLines =: <;._2@:(,&LF^:(LF~:{:))  :.  (;@:(,&LF&.>))
inenv =: 4 : 0
  x =. ('{}'surround&.>@{.,}.) boxopen x
  y =. '  '&,(<@:);.2(;@:) (,LF-.{:) toString y
  '\begin',(;x),LF, y, '\end',(>{.x),LF
)

NB. non-printing assignment operator
is =: 4 :'empty (>x) =: y'

declare =: (1 :('''EMPTY'';~''(>x)=:'',u')) (4 :)~~(&>) (&:(;:^:(0=L.)))
DeclareConst =: 'toL ''\'',y' declare
DeclareFunc =: '(<''\'',y) on ,&tonode' declare
DeclareOp =: '(<''\\'',y) on ,&tonode' declare
DeclareInfix =: '(toL y) infix' declare
