
READ ME FIRST:


..........................................................................................

DEMO: demo_complex_driver

To run the demo that determines the figures in the paper "Chebyshev admissible meshes and Lebesgue constants of complex polynomial projections", and that in particular

1. defines AM (Admissible Mesh),
2. compute some interpolation pointsets,
3. determines the Lebesgue constants of such sets as well as of the Least-Squares operator based on some Admissible Meshes of a certain degree,
4. plots domain, some pointset and the Lebesgue constants up to some degree,

just type in the Matlab shell "demo_complex_driver" with values of the argument ranging from 1 to 18, and degrees of your choice.

Example in the Matlab shell (domain number 6, and degree 4): 


>> demo_complex_driver(6,4)

 	 ............ Lebesgue constant ...............
 
 	 Complex plane set: lune

 	 Pointset: AFEK
 
 	 Degree:    4 

 	 Lebesgue Constant AM: 1.95165e+00
 	 Lebesgue Const. HAM : 1.97066e+00
 
 	 Absolute error      : 1.90077e-02
 	 Relative error      : 9.64533e-03
 	 Relative err. est.  : 8.23922e-02
 	 Relative err. est. H: 7.71559e-04
 
 	 Card. admiss. mesh  :    64
 	 Card. high ad. mesh :   640
 	 m degree            :     4
 	 m degree H          :    40
 	 .............................................. 
 

 	 ............ Lebesgue constant ...............
 
 	 Complex plane set: lune

 	 Pointset: DLP
 
 	 Degree:    4 

 	 Lebesgue Constant AM: 3.04523e+00
 	 Lebesgue Const. HAM : 3.07273e+00
 
 	 Absolute error      : 2.75019e-02
 	 Relative error      : 8.95031e-03
 	 Relative err. est.  : 8.23922e-02
 	 Relative err. est. H: 7.71559e-04
 
 	 Card. admiss. mesh  :    64
 	 Card. high ad. mesh :   640
 	 m degree            :     4
 	 m degree H          :    40
 	 .............................................. 
 

 	 ............ Lebesgue constant ...............
 
 	 Complex plane set: lune

 	 Pointset: PLP
 
 	 Degree:    4 

 	 Lebesgue Constant AM: 4.81703e+00
 	 Lebesgue Const. HAM : 4.84215e+00
 
 	 Absolute error      : 2.51170e-02
 	 Relative error      : 5.18715e-03
 	 Relative err. est.  : 8.23922e-02
 	 Relative err. est. H: 7.71559e-04
 
 	 Card. admiss. mesh  :    64
 	 Card. high ad. mesh :   640
 	 m degree            :     4
 	 m degree H          :    40
 	 .............................................. 
 

 	 ............ Lebesgue constant ...............
 
 	 Complex plane set: lune

 	 Pointset: AM (Least-Squares)
 
 	 Degree:    4 

 	 Lebesgue Constant AM: 2.02604e+00
 	 Lebesgue Const. HAM : 2.02632e+00
 
 	 Absolute error      : 2.74366e-04
 	 Relative error      : 1.35401e-04
 	 Relative err. est.  : 8.23922e-02
 	 Relative err. est. H: 7.71559e-04
 
 	 Card. admiss. mesh  :    64
 	 Card. high ad. mesh :   640
 	 m degree            :     4
 	 m degree H          :    40
 	 .............................................. 
 

 	 .............. Final remarks .................
 
 	 0. We have saved the pictures of the region as
 	    well as of the Lebesgue costants in two files
 	    named resp. 'figure2.eps' and 'figure2.eps'. 

 	 1. In fig 1:
 	    * grey: complex region
 	    * blue dots: AM
 	    * green: Approximate Fekete Points
 
 	 2. In fig 2:
 	    * salmon: Least-Squares
 	              -> pointset is AM of degree:   4
 	                 with factor m:   4
 	    * red: Approx. Fekete Points 
 	    * blue: Discrete Leja Points 
 	    * violet: Pseudo Leja Points
 
 	 3. The colored strip above the line describes 
 	    the region in which the exact value of the 
 	    Lebesgue constant will lie. 	    
 	 ..............................................
 
 >> 

and press ENTER.

..........................................................................................










..........................................................................................

DEMO: demo_complex_AM

To run the demo that 

1. defines AM (Admissible Mesh) of fixed degree on some domain,
2. determines the Lebesgue constant of the associated Least-Squares operator,
4. plots AM of some degree ,

just type in the Matlab shell "demo_complex_AM" with values ranging from 1 to 18, and the degree of the AM.

Example in the Matlab shell (domain number 4, and degree 10): 

 >> demo_complex_AM(4,10)

 	 ............ Lebesgue constant ...............
 
 	 Complex plane set: curvpolygon

 
 	 Degree              :   10
 	 Cardinality AM      :      420
 	 Lebesgue Constant AM: 3.39227e+00
 	 .............................................. 
 	 See figure, representing the Admissible Mesh
 	 .............................................. 
 
>> 

..........................................................................................





