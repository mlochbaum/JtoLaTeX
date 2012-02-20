FILEPATH =: '~user/jlatex/'

NB. Utilities
load 'strings'
map =: 2 :'m&i. { n"_'
boxtomap =: 1 :'({."1 m)map({:"1 m) &.<'
boxtomapd =: 2 :'({."1 m)map(({:"1 m),boxopen n) &.<'
hook =: 2 :'u v'
isstr =: 2=3!:0
ALPH =: , +/&(i.26)&.(a.&i.) 'Aa'
NUM =: '_0123456789'
SPACE =: ' ',TAB,CRLF
stripr =: +./\. onsp=.(@:(-.@e.&SPACE))(#~hook)
stripl =: +./\ onsp

load FILEPATH, 'opdata.ijs'

NB. =========================================================
NB. Parse to tree
NB. A tree node is of the form (< function , args)
NB. A function is a boxed string (not character).
NB. Each argument is a node, and there can be no arguments.
isnode =: 1<L.
f =: {.@>
args =: }.@>
on =: <@:,
NB. Convert a noun to LaTeX
k =: 3 :0
  if. 0<L. y do. <"0 y
  elseif. NUM e.~{.@":@{.@, y do. <"0 strnum y
  elseif. do. <"0 <@": y
  end.
)
strnum =: strinf`strcomp`strrat`(8!:0)@.(1 i.~e.&(_ __),(~:+),(128=3!:0))"0
strinf =: [:<('-'#~<&0),'\infty'"_
strcomp =: [: ('+' ; (;&< ,&'i'&.>))&>/ strnum@+.
strrat =: ([:< [: (texa~>)/@|. '\frac';strnum@(2&x:))`(strnum@{.@(2&x:))@.(=<.)
tonode =: k^:(-.@isnode)

NB. Special casing for -
inverth =: (((;:'+-')map(;:'-+'))@{.@] , ($:}.))&.>^:((;:'+-')e.~f@])"0
invert =: (2&prec@[ inverth ])^:((<,'-')=[)"0

OP =: (1 :',&.:> u') (1 :0) (&tonode) ("0)
  u on u reparen y
:
  u on u reparen x,u invert y
)
reparen =: 4 :0"0 1
  ptype =. [:`paren_type_m`paren_type_d@.(#y) >x
  ifparen =. ptype > (x=f y) + ((#y)prec x) (=+3*<) (fprec y)
  ifparen ((<,'(')on])^:(0~:#@args@])^:["0 y
)

tofunc =: 3 :0&.>
  tok =. '(k ',,&')'
  to_on =. '((<',quote,')on,&tonode)'"_
  yy =. <y
  if. yy e. ;:'()=.=:' do. y
  elseif. '(.'-:y do. '(''(''OP)'
  elseif. '\'={.y do.
    select. 1{y
      case. <"_1(ALPH,'\') do. if. '.:'e.~{:y do. }.y else. to_on y end.
      case. '_' do.
        if. 2=#y do. to_on }.y
        elseif. (2{y)e.NUM do. tok }.y
        elseif. do. tok quote ({.,2&}.)y end.
      case. <"_1 '''',NUM do. tok }.y
      case. do. }.y
    end.
  elseif. yy e. '_';&,'__' do. y
  elseif. '_'={:y do. to_on y
  elseif. yy e. OPS do. ('(',quote,'OP)'"_) y
  elseif. do. tok@quote^:(_1=4!:0@<) y
  end.
)

replacesyn =: rplc&(<@;:;._1' >: (1&+) <: (-&1) +: (2&*) -: (%&2) *: (^&2)')
mergesparens =: 3 :0
  nest =. +/\ 1 _1 0 {~ (;:'()')i.y
  groups =. (;:'\(') I.@E. y
  NB. TODO: better replacement algorithm!
  findgroup =. 4 :'(_1(|.!.1)1=[:+/\(={.))&.(x&|.) y'"0 _
  y <@:(;:^:_1);.1~ (0&= +. 1,2~:/\]) +/ (* >:@i.@#) groups findgroup nest
)
mergeslash =: (<@:;/.~ i.@#+=&(<,'\'))^:_
subs =: tofunc@:replacesyn@:mergeslash@:mergesparens&.;:
totree =: [:tonode@:". subs


NB. =========================================================
NB. Tree to LaTeX
latex =: [: ; [:treetotex totree
treetotex =: ({.@,@{.  applyf  $:^:(*@#)@}.)&.>
applyf =: >@[`apply1`apply2 @. (#@])

surround =: 1 :'({.u),,&({:u)'
applywith =: surround(&.>)(@boxopen)(;@)(,hook)
texa =: '{}'applywith
texa1 =: texa`,@.((isstr*.1=#)@])
texo =: '[]'applywith
texs=: 4 :0 NB. surround with, using \left and \right if needed
  if. *./'\{}'e.y do. '\left',({.x),y,'\right',({:x)
  else. ({.x),y,({:x) end.
)

apply1 =: 4 :0&>&{.
  if. L.x do. x`:0 y
  elseif. '\\'-:2{.x do. }.x,' ',y
  elseif. '_'={:x do. x texa1 y
  elseif. '\_'-:0 _1{x do. x texa y
  elseif. do.
    ". F1 boxtomap  x
  end.
)

apply2 =: 4 :0
  'x y1 y2'=.x,y
  if. L.x do. y1 x`:0 y2
  elseif. '_'-:&,x do. (y1,x) texa1 y2
  elseif. '_'={:x do. ('^' ,~ x texa1 y1) texa1 y2
  elseif. '\'={.x do.
    if. '\'=1{x do. y1,' ',(}.x),' ',y2 else. x texa y end.
  elseif. do.
    ". F2 boxtomap  x
  end.
)

load FILEPATH,'funcs.ijs'
