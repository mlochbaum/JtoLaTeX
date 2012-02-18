NB. J functions which can be used in latex code

NB. Force conversion to latex entity.
tol =: k^:(-.@isnode)

NB. Takes a J function on strings and makes it latex-compatible.
sop =: 1 :'(<{.u`'''')&on'

NB. Make a list infinite by appending '\ldots'.
inf =: (totree'\_ldots') ,~ tol
