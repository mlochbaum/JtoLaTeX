require 'plot gtk'

includegraphics =: 4 :0 NB. name includegraphics rgbimg
  y writeimg_jgtk_ PATH,x,'.png'
  '\includegraphics{',x,'.png}'
)

PLOT_CONFIG =: 'visible 0;'

includeplot =: 4 :0  NB. name includeplot plotdata
  pd PLOT_CONFIG
  pd y
  pd 'pdf ', PATH,x,'.pdf' ,' 280 200'
  '\includegraphics[height=85mm]{',x,'.pdf}'
)

NB. plotdata is (x values);(list of number,error pairs).
errplot =: (includeplot ({.,(-/,{.,:+/)@|:&.>@{:)) [ pd bind'type errorbar;'
