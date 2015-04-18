C_pjdoc_ =: code =: '\lstinline`',],'`'"_

listing =: 'lstlisting' inenv (a: -.~ (#~+./\@:~:&' ')&.>)&.lines
example =: listing , ([: >@{: latex onlines)
mexample=: listing , ('\[','\]',~ [: >@{: latex onlines)
E_pjdoc_ =: example_base_
M_pjdoc_ =: mexample_base_
