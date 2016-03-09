3 : 0 ''
if. _2 = 4!:0<'π' do.
  SYM_RPLC =: 0$a:
  add_sym =: 3 :'SYM_RPLC =: SYM_RPLC , ,y'

  subs =: subs f. @: (] rplc ".bind'SYM_RPLC')
else.
  NB. If this J supports unicode identifiers
  add_sym =: 4 :'empty latex x,''=:'',y'&>/"1
end.
EMPTY
)
