invmap =: [: ; ((;:@}. <@,. <@:("."0)@{.)~ i.&' ');._2
NB. When parentheses are needed to apply f on g(...):
NB.   0 Never
NB.   1 (f >&prec g)   (for +-. Do not use otherwise).
NB.   2 (f >:&prec g)*.(f ~: g)   (i.e. f is associative)
NB.   3 f >:&prec g
NB. Default is 0 or 00.
NB. Note that - will be special-cased.
paren_type_m =: (invmap 0 :0) boxtomapd (,0)
1 -
2 ^.
3 !
)
NB. left argument, right argument
paren_type_d =: (invmap 0 :0) boxtomapd 0 0
21 +
21 -
22 *+.*.
11 =~:<><:>:
30 ^|
)

NB. Order of operations table.
NB. Form is (monad _ dyad) in each row.
NB. Operations which are not listed have infinite binding power.
NB. Usually they are paren-style, and not infix-style functions.
ORDER =: ([: <@; 1 2(,.<)~&.>])"1 ([: <@;:;._1 '_'&,);._2 ]0 :0
  _ *.+.
  _ =~:<><:>:
- _ +-
  _ *
% _ %
! _ 
^ _ ^
)
prec  =: (ORDER ((1 i.~ e.~&>) <) (;~ >))"0
args =. ]"0  NB. Enforce rank 0 on forward use of args
fprec =: #@args prec func

NB. Operations to apply
NB. The statement after each operation will be executed
NB. to get the result of computation.
NB. x is the unboxed operation; y is the boxed argument list.
parsef =. [: ; (<@(;:@{. ,. <@}.)~ i.&' ');._2
F1 =: parsef 0 :(0)
+  '\overline' texa y
-  x,y
*  '\frac' texa (; '||'&texs) y
%  '\frac{1}' texa y
^  'e^' texa y
%: '\sqrt' texa y
^. '\log' , ' '&,^:(ALPH e.~{.) y
!  y,x
|  '||' texs y
(  '()' texs y
)

NB. y -: y1;y2
F2 =: parsef 0 :(0)
+-=<>  y1,x,y2
~: y1,'\neq ',y2
<: y1,'\le ',y2
>: y1,'\ge ',y2
*  y1, ('\cdot'#~ NUM e.~{.y2), ' ',y2
%  '\frac' texa y
^  (y1,'^') texa1 y2
%: ('\sqrt' texo y1) texa y2
^. ('\log_' texa1 y1) , ' '&,^:(ALPH e.~{.) y2
!  '\binom' texa |.y
*. y1,'\lor ',y2
+. y1,'\land ',y2
)

OPS =: F1 ~.@,&:({."1) F2

parsea1 =. ({. ,&(;:&.:>) 3 :0) @: (a: -.~ <;._1)
p =. '(',,&')'
'f a i' =. 3{. p&.> y
p ,&(' :. ',i)^:(*@#i) a,' : ',f
)
ALIAS1 =: parsea1;._2 ]0 :(0)
 >:  1&+"0   -&1"0
 <:  -&1"0   +&1"0
 +:  2&*"0   %&2"0
 -:  %&2"0   2&*"0
 *:  ^&2"0   %:
 -.  1&-"0   1&-"0
 >   jopen   jbox
 <   jbox    jopen
)
jopen=:>
jbox =:<
ALIAS =: <@;:;._1;._2 ]0 :0
 [. ('('OP)
)
alias =: rplc&(,ALIAS1,ALIAS)
