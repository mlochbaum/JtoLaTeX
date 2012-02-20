load 'plot'

PLOT_CONFIG =: 'visible 0;'

insertplot =: 4 :0  NB. name insertplot plotdata
  pd PLOT_CONFIG
  pd y
  pd 'pdf ', PATH,x,'.pdf' ,' 280 200'
  '\includegraphics[height=60mm]{',x,'.pdf}'
)

NB. plotdata is (x values);(list of number,error pairs).
errplot =: (insertplot ({.,(-/,{.,:+/)@|:&.>@{:)) [ pd bind'type errorbar;'
