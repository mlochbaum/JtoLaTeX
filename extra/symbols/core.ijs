SYM_RPLC =: 0$a:
add_sym =: 3 :'SYM_RPLC =: SYM_RPLC , ,y'

subs =: subs f. @: (] rplc ".bind'SYM_RPLC')
