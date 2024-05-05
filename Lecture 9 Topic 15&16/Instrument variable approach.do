

/*
question: in question iv and viii, why in ivregress we do not use robust standard error? What if I add option r?
codebook countryn
this command allows you to check unique value
twoway (scatter y x) (lfit y x) let you draw twoway graph with added fitted linear regression line on the graph
twoway (scatter y x) (lfitci y x) let you draw twoway graph with added confidence interval and fitted linear regression line on the graph
*robust standard error from manually calculated second stange regression is usually wrong because it only considers second stage but not considers first stage. However, using ivregress solves the problem.


*/


use "institution.dta", clear


*(i)
describe

/*
  obs:            64                          
 vars:             8                          14 Aug 2013 11:33
                                              (_dta has notes)
-------------------------------------------------------------------------------------
              storage   display    value
variable name   type    format     label      variable label
-------------------------------------------------------------------------------------
countryn        str25   %25s                  full country name
shortnam        str22   %22s                  3 letter country name
africa          float   %9.0g                 dummy=1 for Africa
latitude        float   %9.0g                 Abs(latitude of capital)/90
euro            float   %9.0g                 % of European descent 1975, AJR
prot            float   %9.0g                 prot against exprop, AJR
lgdp            float   %9.0g                 Log GDP per cpaita
logmort         float   %9.0g                 Log settler mortality
-------------------------------------------------------------------------------------
Sorted by: 



*/


*(ii)

duplicates example countryn
*0 duplicates
count
*64


*alternative codes:
codebook countryn
/*
------------------------------------------------------------------------------
countryn                                                     full country name
------------------------------------------------------------------------------

                  type:  string (str25), but longest is str19

         unique values:  64                       missing "":  0/64

              examples:  "Chile"
                         "Guatemala"
                         "Malta"
                         "Singapore"

               warning:  variable has embedded blanks

*/
tab countryn
list countryn




*(iii)
twoway (scatter lgdp prot) 
twoway (scatter lgdp prot) (lfit lgdp prot)
twoway (scatter lgdp prot) (lfitci lgdp prot)

twoway (scatter prot logmort)
twoway (scatter prot logmort) (lfit prot logmort)
twoway (scatter prot logmort) (lfitci prot logmort)

*(lfit y x) let you add linear regression line on the graph
*(lfitci y x) let you add linear regression line on the graph

*(iv)
*reduced form regression (Y on Z)
reg lgdp logmort, r
/*
Linear regression                               Number of obs     =         64
                                                F(1, 62)          =      60.84
                                                Prob > F          =     0.0000
                                                R-squared         =     0.4625
                                                Root MSE          =      .7711

------------------------------------------------------------------------------
             |               Robust
        lgdp |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
     logmort |  -.5697983   .0730481    -7.80   0.000    -.7158193   -.4237772
       _cons |   10.70759   .3836281    27.91   0.000     9.940732    11.47446
------------------------------------------------------------------------------

*/

*first stage (X on Z)
reg prot logmort, r

/*
Linear regression                               Number of obs     =         64
                                                F(1, 62)          =      16.66
                                                Prob > F          =     0.0001
                                                R-squared         =     0.2775
                                                Root MSE          =     1.2584

------------------------------------------------------------------------------
             |               Robust
        prot |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
     logmort |  -.6213181   .1522185    -4.08   0.000    -.9255985   -.3170376
       _cons |   9.400169   .7098829    13.24   0.000     7.981133     10.8192
------------------------------------------------------------------------------


*/
*provide IV estimate: use coefficient from reduced form regression divided by coefficient from first stage regression
display -0.5697983/-0.6213181
*0.91707908

gen IVprot = 9.400169 - 0.6213181 * logmort

reg lgdp IVprot,r
/*
Linear regression                               Number of obs     =         64
                                                F(1, 62)          =      60.84
                                                Prob > F          =     0.0000
                                                R-squared         =     0.4625
                                                Root MSE          =      .7711

------------------------------------------------------------------------------
             |               Robust
        lgdp |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      IVprot |   .9170797   .1175695     7.80   0.000     .6820616    1.152098
       _cons |   2.086889   .7378702     2.83   0.006     .6119078    3.561871
------------------------------------------------------------------------------

The standard error of coefficient from manually calculated second stage regression is wrong, because it does not consider first stage. Therefore we have to use ivregress to solve the problem.

*/

*alternative 
corr lgdp logmort prot, covariance
/*
(obs=64)

             |     lgdp  logmort     prot
-------------+---------------------------
        lgdp |   1.0886
     logmort | -.883547  1.55063
        prot |  1.12615 -.963436  2.15692

*/

display -0.883547/-0.963436
*0.91707908


*(v)
ivregress 2sls lgdp (prot=logmort), first

/*
First-stage regressions
-----------------------

                                                Number of obs     =         64
                                                F(   1,     62)   =      23.82
                                                Prob > F          =     0.0000
                                                R-squared         =     0.2775
                                                Adj R-squared     =     0.2659
                                                Root MSE          =     1.2584

------------------------------------------------------------------------------
        prot |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
     logmort |  -.6213181   .1273148    -4.88   0.000    -.8758166   -.3668195
       _cons |   9.400169   .6116454    15.37   0.000     8.177507    10.62283
------------------------------------------------------------------------------


Instrumental variables (2SLS) regression          Number of obs   =         64
                                                  Wald chi2(1)    =      38.49
                                                  Prob > chi2     =     0.0000
                                                  R-squared       =     0.2310
                                                  Root MSE        =     .90777

------------------------------------------------------------------------------
        lgdp |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
        prot |   .9170798   .1478206     6.20   0.000     .6273567    1.206803
       _cons |   2.086889   .9698049     2.15   0.031      .186106    3.987671
------------------------------------------------------------------------------
Instrumented:  prot
Instruments:   logmort




*/




*(vi)

reg prot logmort,r 

/*
Linear regression                               Number of obs     =         64
                                                F(1, 62)          =      16.66
                                                Prob > F          =     0.0001
                                                R-squared         =     0.2775
                                                Root MSE          =     1.2584

------------------------------------------------------------------------------
             |               Robust
        prot |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
     logmort |  -.6213181   .1522185    -4.08   0.000    -.9255985   -.3170376
       _cons |   9.400169   .7098829    13.24   0.000     7.981133     10.8192
------------------------------------------------------------------------------


*/

predict prothat
*alternative
gen prothat = 9.400169 - 0.6213181 * logmort


reg lgdp prothat,r 

/*
Linear regression                               Number of obs     =         64
                                                F(1, 62)          =      60.84
                                                Prob > F          =     0.0000
                                                R-squared         =     0.4625
                                                Root MSE          =      .7711

------------------------------------------------------------------------------
             |               Robust
        lgdp |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
     prothat |   .9170797   .1175695     7.80   0.000     .6820616    1.152098
       _cons |   2.086889   .7378702     2.83   0.006     .6119078    3.561871
------------------------------------------------------------------------------

*robust standard error from manually calculated second stange regression is usually wrong because it only considers second stage but not considers first stage. However, using ivregress solves the problem.


*/






*(vii)

corr euro lgdp
/*
(obs=64)

             |     euro     lgdp
-------------+------------------
        euro |   1.0000
        lgdp |   0.6556   1.0000

*/


corr logmort euro

/*
(obs=64)

             |  logmort     euro
-------------+------------------
     logmort |   1.0000
        euro |  -0.5240   1.0000

we find that euro is positively correlated with lgdp and negatively correlated with logmort.
*/


/*
Answer: those countries with high percentage of european descent has higher GDP. If covariance between prot and %EU is posisitve, then the explanatory power of prot on gdp is oveestimated. If covariance betwen port and %EU is negative, then the explanatory power of prot on gdp is underestimated.  


Therefore, we have to include euro as a control variable.


*/



*(viii) & (ix)

*Therefore, we have to include euro as a control variable.

ivregress 2sls lgdp euro (prot = logmort), first



/*
First-stage regressions
-----------------------

                                                Number of obs     =         64
                                                F(   2,     61)   =      16.24
                                                Prob > F          =     0.0000
                                                R-squared         =     0.3474
                                                Adj R-squared     =     0.3260
                                                Root MSE          =     1.2057

------------------------------------------------------------------------------
        prot |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
        euro |   .0153858   .0060199     2.56   0.013     .0033482    .0274233
     logmort |  -.4295086   .1432254    -3.00   0.004    -.7159054   -.1431118
       _cons |   8.231693    .743291    11.07   0.000     6.745391    9.717995
------------------------------------------------------------------------------


Instrumental variables (2SLS) regression          Number of obs   =         64
                                                  Wald chi2(2)    =      50.00
                                                  Prob > chi2     =     0.0000
                                                  R-squared       =     0.2500
                                                  Root MSE        =     .89647

------------------------------------------------------------------------------
        lgdp |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
        prot |   .9049351   .2479372     3.65   0.000     .4189871    1.390883
        euro |   .0006053   .0072443     0.08   0.933    -.0135933    .0148038
       _cons |   2.155084   1.509911     1.43   0.153    -.8042883    5.114456
------------------------------------------------------------------------------
Instrumented:  prot
Instruments:   euro logmort



In the first stage regression, including control variable "euro" will highight the relatioonship between euro and logmort. In the second stage, run the regression with additional control of euro. Results show that euro does not contribute to gdp performance. Thus, we can rule out the caveat. 


*/







use "bwght.dta", clear

*(i)
 des

/*
  obs:         1,388                          
 vars:            14                          14 Aug 2013 11:34
-------------------------------------------------------------------------------------
              storage   display    value
variable name   type    format     label      variable label
-------------------------------------------------------------------------------------
faminc          float   %9.0g                 1988 family income, $1000s
cigtax          float   %9.0g                 cig. tax in home state, 1988
cigprice        float   %9.0g                 cig. price in home state, 1988
bwght           int     %8.0g                 birth weight, ounces
fatheduc        byte    %8.0g                 father's yrs of educ
motheduc        byte    %8.0g                 mother's yrs of educ
parity          byte    %8.0g                 birth order of child
male            byte    %8.0g                 =1 if male child
white           byte    %8.0g                 =1 if white
cigs            byte    %8.0g                 cigs smked per day while preg
lbwght          float   %9.0g                 log of bwght
bwghtlbs        float   %9.0g                 birth weight, pounds
packs           float   %9.0g                 packs smked per day while preg
lfaminc         float   %9.0g                 log(faminc)
-------------------------------------------------------------------------------------
Sorted by: 


*/


*(ii)
reg bwght packs faminc, r

/*
Linear regression                               Number of obs     =      1,388
                                                F(2, 1385)        =      22.11
                                                Prob > F          =     0.0000
                                                R-squared         =     0.0298
                                                Root MSE          =     20.063

------------------------------------------------------------------------------
             |               Robust
       bwght |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
       packs |  -9.268151   1.775189    -5.22   0.000     -12.7505   -5.785802
      faminc |   .0927647   .0285864     3.25   0.001     .0366875     .148842
       _cons |   116.9741   1.037207   112.78   0.000     114.9395    119.0088
------------------------------------------------------------------------------

one more pack of smoke is associated with 9.27 ounce reduction in new born baby.

*/



*(iii)
* cigprice is probably not a good IV, because higher price probably means higher cigratte tax, which means state governement may focus more on health issue. We cannot test that IV is uncorrelated with error term. However, in this case, we can test. In the original regression, we can include more variables and test if cigprice is correlated with those variables. For example:


reg cigprice whit fatheduc, r
reg lbwght packs faminc white fatheduc, r


/*
. reg cigprice whit fatheduc, r
Linear regression                               Number of obs     =      1,192
                                                F(2, 1189)        =       9.56
                                                Prob > F          =     0.0001
                                                R-squared         =     0.0147
                                                Root MSE          =      10.28

------------------------------------------------------------------------------
             |               Robust
    cigprice |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
       white |   2.181813    .802599     2.72   0.007     .6071453    3.756482
    fatheduc |   .3232531   .1056202     3.06   0.002     .1160304    .5304759
       _cons |   124.6022    1.50853    82.60   0.000     121.6425    127.5619
------------------------------------------------------------------------------
. reg lbwght packs faminc white fatheduc, r

Linear regression                               Number of obs     =      1,192
                                                F(4, 1187)        =      10.73
                                                Prob > F          =     0.0000
                                                R-squared         =     0.0339
                                                Root MSE          =     .18505

------------------------------------------------------------------------------
             |               Robust
      lbwght |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
       packs |  -.1019763   .0199383    -5.11   0.000    -.1410946   -.0628579
      faminc |    .000276   .0003274     0.84   0.399    -.0003664    .0009184
       white |   .0437237   .0176564     2.48   0.013     .0090825     .078365
    fatheduc |   .0018837   .0019984     0.94   0.346    -.0020371    .0058045
       _cons |   4.705842   .0287863   163.48   0.000     4.649365     4.76232
------------------------------------------------------------------------------

*/





*(iv)
twoway (scatter packs cigprice) (lfit packs cigprice)
/*
This diagram is not helpful, as we can hardly see a clear relationship. This diagram is important becuae it implies that cigprice is a not good instrument.
*/


*(v)
reg bwght cigprice faminc, r



/*
Linear regression                               Number of obs     =      1,388
                                                F(2, 1385)        =      10.12
                                                Prob > F          =     0.0000
                                                R-squared         =     0.0134
                                                Root MSE          =     20.232

------------------------------------------------------------------------------
             |               Robust
       bwght |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
    cigprice |    .077776   .0527139     1.48   0.140    -.0256317    .1811837
      faminc |   .1142648   .0284868     4.01   0.000     .0583829    .1701466
       _cons |   105.2285   6.841894    15.38   0.000     91.80689    118.6501
------------------------------------------------------------------------------
*also ok if include additional controls such as white and fatheduc

reg bwght cigprice faminc white fatheduc, r

Linear regression                               Number of obs     =      1,192
                                                F(4, 1187)        =       4.85
                                                Prob > F          =     0.0007
                                                R-squared         =     0.0151
                                                Root MSE          =     20.017

------------------------------------------------------------------------------
             |               Robust
       bwght |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
    cigprice |   .0508087   .0560511     0.91   0.365    -.0591615     .160779
      faminc |   .0426002   .0360519     1.18   0.238    -.0281323    .1133327
       white |   3.950179   1.698899     2.33   0.020     .6169991    7.283358
    fatheduc |   .4155664   .2151083     1.93   0.054    -.0064684    .8376012
       _cons |   102.6931   7.497778    13.70   0.000      87.9827    117.4035
------------------------------------------------------------------------------


*/




reg packs cigprice faminc, r


/*
Linear regression                               Number of obs     =      1,388
                                                F(2, 1385)        =      27.03
                                                Prob > F          =     0.0000
                                                R-squared         =     0.0306
                                                Root MSE          =     .29424

------------------------------------------------------------------------------
             |               Robust
       packs |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
    cigprice |   .0007714   .0008116     0.95   0.342    -.0008206    .0023634
      faminc |  -.0027979   .0003806    -7.35   0.000    -.0035445   -.0020514
       _cons |   .0848568   .1058989     0.80   0.423    -.1228827    .2925963
------------------------------------------------------------------------------

* also ok if include additional controls such as white and fatheduc
reg packs cigprice faminc white fatheduc, r

Linear regression                               Number of obs     =      1,192
                                                F(4, 1187)        =      13.52
                                                Prob > F          =     0.0000
                                                R-squared         =     0.0421
                                                Root MSE          =     .26185

------------------------------------------------------------------------------
             |               Robust
       packs |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
    cigprice |    .000656   .0007199     0.91   0.362    -.0007564    .0020683
      faminc |  -.0015515   .0004185    -3.71   0.000    -.0023726   -.0007303
       white |   .0355541   .0217577     1.63   0.103    -.0071336    .0782419
    fatheduc |  -.0136276    .003589    -3.80   0.000    -.0206691   -.0065862
       _cons |   .2022874   .1034058     1.96   0.051    -.0005912    .4051659
------------------------------------------------------------------------------

*/



*(vi)

ivregress 2sls bwght faminc (packs = cigprice), first r

/*
First-stage regressions
-----------------------

                                                Number of obs     =      1,388
                                                F(   2,   1385)   =      27.03
                                                Prob > F          =     0.0000
                                                R-squared         =     0.0306
                                                Adj R-squared     =     0.0292
                                                Root MSE          =     0.2942

------------------------------------------------------------------------------
             |               Robust
       packs |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      faminc |  -.0027979   .0003806    -7.35   0.000    -.0035445   -.0020514
    cigprice |   .0007714   .0008116     0.95   0.342    -.0008206    .0023634
       _cons |   .0848568   .1058989     0.80   0.423    -.1228827    .2925963
------------------------------------------------------------------------------


Instrumental variables (2SLS) regression          Number of obs   =      1,388
                                                  Wald chi2(2)    =       6.54
                                                  Prob > chi2     =     0.0381
                                                  R-squared       =          .
                                                  Root MSE        =     38.071

------------------------------------------------------------------------------
             |               Robust
       bwght |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
       packs |   100.8206   134.4147     0.75   0.453    -162.6274    364.2685
      faminc |   .3963555   .3716291     1.07   0.286    -.3320241    1.124735
       _cons |   96.67318   24.79392     3.90   0.000     48.07798    145.2684
------------------------------------------------------------------------------
Instrumented:  packs
Instruments:   faminc cigprice


*/

*******************************************************************************



use "card.dta", clear

*(i)
des

/*
  obs:         3,010                          
 vars:            34                          14 Aug 2013 11:34
-------------------------------------------------------------------------------------
              storage   display    value
variable name   type    format     label      variable label
-------------------------------------------------------------------------------------
id              int     %9.0g                 person identifier
nearc2          byte    %9.0g                 =1 if near 2 yr college, 1966
nearc4          byte    %9.0g                 =1 if near 4 yr college, 1966
educ            byte    %9.0g                 years of schooling, 1976
age             byte    %9.0g                 in years
fatheduc        byte    %9.0g                 father's schooling
motheduc        byte    %9.0g                 mother's schooling
weight          float   %9.0g                 NLS sampling weight, 1976
momdad14        byte    %9.0g                 =1 if live with mom, dad at 14
sinmom14        byte    %9.0g                 =1 if with single mom at 14
step14          byte    %9.0g                 =1 if with step parent at 14
reg661          byte    %9.0g                 =1 for region 1, 1966
reg662          byte    %9.0g                 =1 for region 2, 1966
reg663          byte    %9.0g                 =1 for region 3, 1966
reg664          byte    %9.0g                 =1 for region 4, 1966
reg665          byte    %9.0g                 =1 for region 5, 1966
reg666          byte    %9.0g                 =1 for region 6, 1966
reg667          byte    %9.0g                 =1 for region 7, 1966
reg668          byte    %9.0g                 =1 for region 8, 1966
reg669          byte    %9.0g                 =1 for region 9, 1966
south66         byte    %9.0g                 =1 if in south in 1966
black           byte    %9.0g                 =1 if black
smsa            byte    %9.0g                 =1 in in SMSA, 1976
south           byte    %9.0g                 =1 if in south, 1976
smsa66          byte    %9.0g                 =1 if in SMSA, 1966
wage            int     %9.0g                 hourly wage in cents, 1976
enroll          byte    %9.0g                 =1 if enrolled in school, 1976
KWW             byte    %9.0g                 knowledge world of work score
IQ              int     %9.0g                 IQ score
married         byte    %9.0g                 =1 if married, 1976
libcrd14        byte    %9.0g                 =1 if lib. card in home at 14
exper           byte    %9.0g                 age - educ - 6
lwage           float   %9.0g                 log(wage)
expersq         int     %9.0g                 exper^2
-------------------------------------------------------------------------------------
Sorted by: 

*/


*(ii)

reg lwage educ exper expersq smsa south, r


/*
Linear regression                               Number of obs     =      3,010
                                                F(5, 3004)        =     225.11
                                                Prob > F          =     0.0000
                                                R-squared         =     0.2632
                                                Root MSE          =     .38127

------------------------------------------------------------------------------
             |               Robust
       lwage |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
        educ |   .0815797   .0036516    22.34   0.000     .0744198    .0887396
       exper |   .0838357   .0068393    12.26   0.000     .0704255    .0972459
     expersq |  -.0022021   .0003253    -6.77   0.000      -.00284   -.0015642
        smsa |   .1508006   .0155001     9.73   0.000     .1204087    .1811924
       south |  -.1751761   .0148785   -11.77   0.000    -.2043491    -.146003
       _cons |   4.611015   .0704648    65.44   0.000      4.47285    4.749179
------------------------------------------------------------------------------
one more year of school is associated with 0.08% increase in wage. The result is statistically signficant at 1% level
*/



*(iii)
reg educ nearc4 exper expersq smsa south, r

/*
Linear regression                               Number of obs     =      3,010
                                                F(5, 3004)        =     675.83
                                                Prob > F          =     0.0000
                                                R-squared         =     0.4524
                                                Root MSE          =     1.9825

------------------------------------------------------------------------------
             |               Robust
        educ |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      nearc4 |   .3456458   .0824092     4.19   0.000     .1840616      .50723
       exper |  -.4258437   .0320651   -13.28   0.000    -.4887155    -.362972
     expersq |   .0009774   .0017044     0.57   0.566    -.0023646    .0043194
        smsa |   .3639914   .0863314     4.22   0.000     .1947167    .5332661
       south |   -.582683   .0743531    -7.84   0.000    -.7284712   -.4368948
       _cons |   16.68131   .1489113   112.02   0.000     16.38933    16.97329
------------------------------------------------------------------------------

*/

test nearc4

/*
 ( 1)  nearc4 = 0

       F(  1,  3004) =   17.59
            Prob > F =    0.0000

*/

reg IQ nearc4, r

/*
Linear regression                               Number of obs     =      2,061
                                                F(1, 2059)        =      12.00
                                                Prob > F          =     0.0005
                                                R-squared         =     0.0059
                                                Root MSE          =     15.382

------------------------------------------------------------------------------
             |               Robust
          IQ |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      nearc4 |     2.5962   .7494531     3.46   0.001     1.126435    4.065965
       _cons |   100.6106   .6331052   158.92   0.000     99.36906    101.8522
------------------------------------------------------------------------------
Yes, nearc4 could be correlated with IQ
*/

ivregress 2sls lwage exper expersq smsa south (educ = nearc4), r

/*
Instrumental variables (2SLS) regression          Number of obs   =      3,010
                                                  Wald chi2(5)    =     534.87
                                                  Prob > chi2     =     0.0000
                                                  R-squared       =     0.2051
                                                  Root MSE        =     .39562

------------------------------------------------------------------------------
             |               Robust
       lwage |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
        educ |     .13542   .0479139     2.83   0.005     .0415104    .2293297
       exper |   .1067727   .0216128     4.94   0.000     .0644124     .149133
     expersq |  -.0022553   .0003534    -6.38   0.000    -.0029479   -.0015626
        smsa |   .1249987   .0280964     4.45   0.000     .0699306    .1800667
       south |  -.1409356   .0338334    -4.17   0.000    -.2072479   -.0746234
       _cons |   3.703427   .8078925     4.58   0.000     2.119986    5.286867
------------------------------------------------------------------------------
Instrumented:  educ
Instruments:   exper expersq smsa south nearc4

*/


*(iv)

ivregress 2sls lwage exper expersq smsa south (educ = nearc4)

/*
Instrumental variables (2SLS) regression          Number of obs   =      3,010
                                                  Wald chi2(5)    =     499.36
                                                  Prob > chi2     =     0.0000
                                                  R-squared       =     0.2051
                                                  Root MSE        =     .39562

------------------------------------------------------------------------------
       lwage |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
        educ |     .13542   .0486085     2.79   0.005     .0401491     .230691
       exper |   .1067727   .0218136     4.89   0.000     .0640188    .1495266
     expersq |  -.0022553   .0003394    -6.64   0.000    -.0029205     -.00159
        smsa |   .1249987   .0284538     4.39   0.000     .0692302    .1807671
       south |  -.1409356   .0343705    -4.10   0.000    -.2083005   -.0735707
       _cons |   3.703427   .8201379     4.52   0.000     2.095986    5.310867
------------------------------------------------------------------------------
Instrumented:  educ

using robust standard error or not does not affect coefficient
*/



*(v)

reg IQ nearc4, r

/*
Linear regression                               Number of obs     =      2,061
                                                F(1, 2059)        =      12.00
                                                Prob > F          =     0.0005
                                                R-squared         =     0.0059
                                                Root MSE          =     15.382

------------------------------------------------------------------------------
             |               Robust
          IQ |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      nearc4 |     2.5962   .7494531     3.46   0.001     1.126435    4.065965
       _cons |   100.6106   .6331052   158.92   0.000     99.36906    101.8522
------------------------------------------------------------------------------
Yes, IQ is higher if near a 4-year college, so nearc4 could correlated with factors determining wage. In short, nearc4 is not an ideal IV

*/



*(vi)

reg IQ nearc4 smsa66 reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669, r

/*
------------------------------------------------------------------------------
             |               Robust
          IQ |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      nearc4 |   .3478974    .807889     0.43   0.667    -1.236471    1.932266
      smsa66 |   1.089165   .7947269     1.37   0.171    -.4693908    2.647722
      reg661 |          0  (omitted)
      reg662 |   1.099282   1.551963     0.71   0.479    -1.944306    4.142871
      reg663 |  -1.559295   1.509444    -1.03   0.302    -4.519499    1.400908
      reg664 |  -.5425011   1.723682    -0.31   0.753    -3.922852     2.83785
      reg665 |   -8.47546   1.619462    -5.23   0.000    -11.65142   -5.299497
      reg666 |  -7.421172    1.93497    -3.84   0.000    -11.21588    -3.62646
      reg667 |   -8.39441   1.795532    -4.68   0.000    -11.91567   -4.873152
      reg668 |  -2.924975   2.338128    -1.25   0.211    -7.510329    1.660379
      reg669 |  -2.891917   1.722389    -1.68   0.093    -6.269732    .4858982
       _cons |   104.7735   1.505288    69.60   0.000     101.8214    107.7255
------------------------------------------------------------------------------
IQ is not correlated with nearc4 after geographyical variables have been controlled for. 
*/


*(vii)

*controlling smsa66 and 1966 reginal dummies to ensure IQ is not biased.

*(viii)

ivregress 2sls lwage exper expersq smsa south smsa66  reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669 (educ = nearc4), first r




/*
First-stage regressions
-----------------------

                                                Number of obs     =      3,010
                                                F(  14,   2995)   =     246.23
                                                Prob > F          =     0.0000
                                                R-squared         =     0.4597
                                                Adj R-squared     =     0.4572
                                                Root MSE          =     1.9722

------------------------------------------------------------------------------
             |               Robust
        educ |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
       exper |  -.4261072   .0320511   -13.29   0.000    -.4889516   -.3632628
     expersq |   .0010787   .0017016     0.63   0.526    -.0022577    .0044151
        smsa |   .3395633   .1122607     3.02   0.003     .1194474    .5596791
       south |  -.0082122   .1449348    -0.06   0.955    -.2923941    .2759697
      smsa66 |   .0809123   .1122054     0.72   0.471    -.1390951    .3009196
      reg661 |  -.1743971   .2016427    -0.86   0.387    -.5697694    .2209751
      reg662 |  -.2970013   .1533889    -1.94   0.053    -.5977595     .003757
      reg663 |  -.2941354   .1453723    -2.02   0.043    -.5791749   -.0090958
      reg664 |  -.0846929   .1816101    -0.47   0.641     -.440786    .2714002
      reg665 |  -.8761905   .1953419    -4.49   0.000    -1.259208   -.4931727
      reg666 |  -.9516116   .2071777    -4.59   0.000    -1.357837   -.5453865
      reg667 |  -.7772692   .2100846    -3.70   0.000    -1.189194   -.3653445
      reg668 |   .3550599   .2316408     1.53   0.125    -.0991313    .8092511
      reg669 |          0  (omitted)
      nearc4 |   .2786754   .0860717     3.24   0.001     .1099099     .447441
       _cons |    16.9208   .1890335    89.51   0.000     16.55015    17.29145
------------------------------------------------------------------------------


Instrumental variables (2SLS) regression          Number of obs   =      3,010
                                                  Wald chi2(14)   =     613.05
                                                  Prob > chi2     =     0.0000
                                                  R-squared       =     0.2578
                                                  Root MSE        =     .38228

------------------------------------------------------------------------------
             |               Robust
       lwage |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
        educ |   .1082955   .0607662     1.78   0.075    -.0108041    .2273951
       exper |   .0962523   .0267336     3.60   0.000     .0438553    .1486492
     expersq |  -.0022769   .0003409    -6.68   0.000     -.002945   -.0016089
        smsa |   .1098646   .0297839     3.69   0.000     .0514892    .1682401
       south |   -.138053   .0282947    -4.88   0.000    -.1935095   -.0825965
      smsa66 |   .0291057   .0216063     1.35   0.178    -.0132419    .0714532
      reg661 |  -.1062334   .0400591    -2.65   0.008    -.1847478    -.027719
      reg662 |  -.0152092   .0343511    -0.44   0.658    -.0825362    .0521178
      reg663 |    .024844   .0341437     0.73   0.467    -.0420764    .0917644
      reg664 |  -.0585655   .0379592    -1.54   0.123    -.1329641    .0158332
      reg665 |  -.0435828   .0669483    -0.65   0.515     -.174799    .0876334
      reg666 |  -.0357972   .0724442    -0.49   0.621    -.1777853    .1061909
      reg667 |  -.0462212   .0648329    -0.71   0.476    -.1732913     .080849
      reg668 |  -.1761494   .0512696    -3.44   0.001    -.2766359   -.0756629
      reg669 |          0  (omitted)
       _cons |   4.178008   1.035465     4.03   0.000     2.148535    6.207482
------------------------------------------------------------------------------
Instrumented:  educ
Instruments:   exper expersq smsa south smsa66 reg661 reg662 reg663 reg664
               reg665 reg666 reg667 reg668 nearc4



			   
			   
			   
conclusion: one more year of schooling causes 0.108% increase in wage. 

*/





















