DeclareConst 'dots'

DOTS =: <"0 '\'&,&.> (, ,&.>&'cbmio' , ,~&.>&'lcvdi') <'dots'
isdot =: e.&DOTS

cdot =: [ , dots , ]

'DTKEY DTVAL' =. ({. ; >@{:) |: ;:;._2 ]0 : 0
+   b
*   m
int i
)
getdottype =: '\dots' toL@, DTVAL { :: (''"_)~ DTKEY&i.

mapdot =: (^:(-.@isdot@])) ("_ 0)
reducedot =: 1 :0
  d =. getdottype < 5!:5 <'u'
  [: u/ (=&dots)`(,:&d)}^:(d-.@-:dots)
)
mapreducedot =: 2 :'(u reducedot) @: (v mapdot)'
