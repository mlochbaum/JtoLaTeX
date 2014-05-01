require 'plot gtk'

includegraphics =: 4 :0 NB. name includegraphics rgbimg
  y writeimg_jgtk_ PATH,x,'.png'
  '\includegraphics{',x,'.png}'
)

PLOT_CONFIG =: 'visible 0;'
PLOT_NUMBER =: 0

includeplot =: 3 :0  NB. [filename] includeplot plotdata
  PLOT_NUMBER =: >:PLOT_NUMBER
  ('plot',":<:PLOT_NUMBER) includeplot y
:
  pd PLOT_CONFIG
  if. #y do. pd y end.
  pd 'pdf ', PATH,x,'.pdf' ,' 280 200'
  '\includegraphics[height=85mm]{',x,'.pdf}'
)

NB. plotdata is (x values);(list of number,error pairs).
errplot =: (includeplot ({.,(-/,{.,:+/)@|:&.>@{:)) [ pd bind'type errorbar;'
