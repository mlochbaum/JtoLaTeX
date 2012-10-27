NB. Force conversion to latex entity.
toL =: k^:(-.@isnode)

NB. Takes a J function on strings and makes it latex-compatible.
asL =: 1 :'(<{.u`'''') on toL'
NB. J function on an array of boxed strings.
masL =: 1 :'(<{.u@:treetotex`'''') on <@<@:toL'

mathinline =: ('$',,&'$') asL
mathdisp =: ('\[',,&'\]') asL
