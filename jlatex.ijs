NB. Directory containing this script
FILEPATH =: ({.~ 1+i:&'/') >{:4!:3 ''

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
surround =: 1 :'({.u),,&({:u)'

load FILEPATH, 'opdata.ijs'

NB. =========================================================
NB. Parse to tree
NB. A tree node is of the form (< function , args)
NB. A function is a boxed string (not character).
NB. Each argument is a node, and there can be no arguments.
isnode =: 1<L.
func =: {.@>
args =: }.@>
on =: <@:,

NB. Convert a noun to LaTeX
toL =: 3 :0
  if. 0<L. y do. <"0 y
  elseif. 2 32 -.@e.~ 3!:0 y do. <"0 strnum y
  elseif. do. <"0 <@": y
  end.
)
strnum =: strinf`strcomp`strrat`(8!:0)@.(1 i.~e.&(_ __),(~:+),(128=3!:0))"0
strinf =: [:<('-'#~<&0),'\infty'"_
strcomp =: [: ('+' ; (;&< ,&'i'&.>))&>/ strnum@+.
strrat =: ([:< ('-'#~<&0),[: (texa~>)/@|. '\frac';strnum@(2 x:|))`(strnum@{.@(2&x:))@.(=<.)
tonode =: toL^:(-.@isnode)
NB. Process name, with {} for long subscripts
Lname =: [: <@< (({.,'{}'surround@:}.)^:(<<:@#)~ 1+i.&'_')^:(1='_'+/@:=])

NB. Special casing for -
ispm =. ((;:'+-')e.~func) *. 2=#@args
inverth =: (((;:'+-')map(;:'-+'))@{.@] , ($:}.))&.>^:(ispm f.@])"0
invert =: (2&prec@[ inverth ])^:((<,'-')=[)"0

OP =: (1 :',&.:> u') (1 :0) (&tonode) ("0)
  u on u reparen (u&invert) : (, u&invert)
)
reparen =: 4 :0"0 1
  ptype =. [:`paren_type_m`paren_type_d@.(#y) >x
  ifparen =. ptype > (x=func y) + ((#y)prec x) (=+3*<) (fprec y)
  ifparen ((<,'(')on])^:(0~:#@args@])^:["0 y
)

tofunc =: 3 :0&.>
  tok =. '(toL ',,&')'
  to_on =. '((<',quote,')on,&tonode)'"_
  yy =. <y
  if. 0 < L.y do. ,>y
  elseif. yy e. ;:'()=.=:' do. y
  elseif. '\'={.y do.
    select. 1{y
      case. <"_1(ALPH,'\') do. if. '.:'e.~{:y do. }.y else. to_on y end.
      case. '_' do.
        if. 2=#y do. '(','"0)',~to_on }.y
        elseif. (2{y)e.NUM do. tok }.y
        elseif. do. tok quote ({.,2&}.)y end.
      case. <"_1 '''',NUM do. tok }.y
      case. do. }.y
    end.
  elseif. ({.y) e. NUM do. y
  elseif. '_'={:y do. '(','"0)',~to_on y
  elseif. yy e. OPS do. ('(',quote,'OP)'"_) y
  elseif. do. ('(Lname ',,&')')@quote^:(e.&(;:'x y')@< +. _1=4!:0@<) y
  end.
)

mergesparens =: 3 :0
  nest =. +/\ 1 _1 0 {~ (;:'()')i.y
  in_p =. {."1 ([`]@.(~:&{:*.{.@]))/\.&.|. nest ,.~ (;:'\(') E. y
  y <@(;:^:_1);.2~ -. in_p
)
mergeslash =: (<@:;/.~ i.@#+=&(<,'\'))^:_
protectassign =: 2 <@]^:((;:'=.=:')e.~[)~/\ ,&a:
subs =: tofunc@:alias@:protectassign@:mergeslash@:mergesparens&.;:
totree =: ([:tonode@:". subs) :: (255 (13!:8@[) smoutput@:processerror)

processerror =: 3 : 0
err =. (}.~ 5+i.&LF) err1 =. }:13!:12 ''
i =. >: i.&' '@:(#~ 2>:/\0,' '&=) err
mmy =. mergeslash@:mergesparens ;:y
mmy1 =. tofunc@:alias mmyp =. protectassign mmy
if. err -.@-:&(-.&(LF,' ')) ;mmy1 do. err1 return. end.
i =. i I.~ ([: +/\ +/@:~:&' '@>) mmy1
i =. i I.~ 0,+/\ aliaslen mmyp
i =. (i{+/\0,+/@:~:&' '@> mmy) { ~.(i.@# + ' '&=) y
(({.~ 5+i.&LF) err1) , i ({.,(4#' '),}.) y
)


NB. =========================================================
NB. Tree to LaTeX
latex =: [: ; [:treetotex totree
treetotex =: ({.@,@{.  applyf  $:^:(*@#)@}.)&.>
applyf =: >@[`apply1`apply2 @. (#@])

applywith =: surround(&.>)(@boxopen)(;@)(,hook)
texa =: '{}'applywith
texa1 =: texa`,@.((isstr*.1=#)@])
texo =: '[]'applywith
NB. Determine whether the given LaTeX string is taller than a line
iftall =: *./@:('\{}'&e.) +. +./@:('_^'&e.)
texs=: 4 :0 NB. surround with, using \left and \right if needed
  if. iftall y do. '\left',(>{.x),y,'\right',(>{:x)
  else. (>{.x),y,(>{:x) end.
)

apply1 =: 4 :0&>&{.
  if. L.x do. x`:0 y
  elseif. '\\'-:2{.x do. }.x,' ',y
  elseif. '_'={:x do. x texa1 y
  elseif. '\'={.x do. x texa y
  elseif. do. ". F1 boxtomap  x
  end.
)

apply2 =: 4 :0
  'x y1 y2'=.x,y
  if. L.x do. y1 x`:0 y2
  elseif. '_'-:&,x do. (y1,x) texa1 y2
  elseif. '_'={:x do. ('^' ,~ x texa1 y1) texa1 y2
  elseif. '\\'-:2{.x do. y1,' ',(}.x),' ',y2
  elseif. '\'={.x do. x texa y
  elseif. do. ". F2 boxtomap  x
  end.
)

load FILEPATH,'extra/core.ijs'
