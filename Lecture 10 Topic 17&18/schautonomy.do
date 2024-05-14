use "schautonomy.dta", clear

*(a)
summarize
/*

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
   passrate0 |        662    38.93807       15.69          1         97
   passrate2 |        662    42.19486    15.87545          1         97
        vote |        662    .6298754    .2277083   .0397805   .9837587
         win |        662    .6933535      .46145          0          1
       dpass |        662    3.256798    7.207781        -20         28
-------------+---------------------------------------------------------
   lose_vote |        662    .0499667    .0931495          0   .4602195
 lose_vote_2 |        662    .0111604    .0269535          0    .211802
    win_vote |        662    .1798421    .1586657          0   .4837587
  win_vote_2 |        662      .05748    .0633976          0   .2340225

*/

*(b)

reg dpass win , vce(robust)

*linear fit
twoway scatter dpass vote if vote > 0.15 & vote < 0.85 || lfit dpass vote if vote > 0.15 & vote < 0.5 || lfit dpass vote if vote > 0.5 & vote < 0.85, legend(order(2 "vote<50" 3 "vote >=50"))

*quadratic fit 
twoway scatter dpass vote if vote > 0.15 & vote < 0.85 || qfit dpass vote if vote > 0.15 & vote < 0.5 || qfit dpass vote if vote > 0.5 & vote < 0.85, legend(order(2 "vote<50" 3 "vote >=50"))

/*
Linear regression                               Number of obs     =        662
                                                F(1, 660)         =      12.11
                                                Prob > F          =     0.0005
                                                R-squared         =     0.0178
                                                Root MSE          =     7.1488

------------------------------------------------------------------------------
             |               Robust
       dpass |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         win |   2.082617   .5984611     3.48   0.001     .9074998    3.257734
       _cons |   1.812808   .4955936     3.66   0.000     .8396778    2.785938
------------------------------------------------------------------------------


*/





*(c)
/*
the following is the codes that generate lose_vote and win_vote
gen lose_vote = 0 if win ==1
replace lose_vote = -(vote-0.5) if win ==0

gen win_vote = 0 if win ==0
replace win_vote = (vote-0.5) if win ==1

gen lose_vote_2 = loss_vote^2
gen win_vote_2 = win_vote^2

*/



twoway scatter dpass vote

*(d)
reg dpass win lose_vote lose_vote_2 win_vote win_vote_2 if vote > 0.15 & vote <0.85 , r
/*
Linear regression                               Number of obs     =        524
                                                F(5, 518)         =       3.35
                                                Prob > F          =     0.0055
                                                R-squared         =     0.0327
                                                Root MSE          =     7.0078

------------------------------------------------------------------------------
             |               Robust
       dpass |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         win |   3.380534   2.214408     1.53   0.127    -.9697913    7.730859
   lose_vote |   18.12342   22.62345     0.80   0.423    -26.32157    62.56841
 lose_vote_2 |  -47.68918   63.20427    -0.75   0.451    -171.8574    76.47904
    win_vote |   15.38263   16.56396     0.93   0.353    -17.15816    47.92343
  win_vote_2 |   -58.8888    43.0554    -1.37   0.172    -143.4735    25.69587
       _cons |   .4795681   1.705872     0.28   0.779    -2.871709    3.830845
------------------------------------------------------------------------------
*/

reg dpass win lose_vote lose_vote_2 win_vote win_vote_2 if vote > 0.4 & vote <0.6 , r

/*
Linear regression                               Number of obs     =        129
                                                F(5, 123)         =       1.27
                                                Prob > F          =     0.2797
                                                R-squared         =     0.0593
                                                Root MSE          =     7.5391

------------------------------------------------------------------------------
             |               Robust
       dpass |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         win |   7.586074   4.497468     1.69   0.094    -1.316387    16.48854
   lose_vote |   21.29584   140.3989     0.15   0.880    -256.6152    299.2069
 lose_vote_2 |  -164.2845   1363.388    -0.12   0.904    -2863.028    2534.459
    win_vote |  -224.3669   137.7373    -1.63   0.106    -497.0094    48.27552
  win_vote_2 |   1998.712   1297.663     1.54   0.126    -569.9323    4567.357
       _cons |   .8337098   3.407985     0.24   0.807    -5.912187    7.579607
------------------------------------------------------------------------------

*/


*(e)
*assumption: no manipulation, no covariates jump, no override

*(f)
*quadratic fit 
twoway scatter dpass vote if vote > 0.15 & vote < 0.85 || qfit dpass vote if vote > 0.15 & vote < 0.5 || qfit dpass vote if vote > 0.5 & vote < 0.85, legend(order(2 "vote<50" 3 "vote >=50"))

*quadratic fit 
twoway scatter dpass vote if vote > 0.4 & vote < 0.6 || qfit dpass vote if vote > 0.4 & vote < 0.5 || qfit dpass vote if vote > 0.5 & vote < 0.6, legend(order(2 "vote<50" 3 "vote >=50"))




*(g)

reg passrate2 win lose_vote lose_vote_2 win_vote win_vote_2 if vote > 0.15 & vote <0.85 , r

/*
Linear regression                               Number of obs     =        524
                                                F(5, 518)         =       1.45
                                                Prob > F          =     0.2035
                                                R-squared         =     0.0124
                                                Root MSE          =     15.272

------------------------------------------------------------------------------
             |               Robust
   passrate2 |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         win |  -1.463044   4.465708    -0.33   0.743    -10.23617    7.310082
   lose_vote |  -54.73514   47.34951    -1.16   0.248    -147.7558    38.28554
 lose_vote_2 |   147.2164   134.9197     1.09   0.276    -117.8407    412.2734
    win_vote |   3.995017   32.42257     0.12   0.902    -59.70087    67.69091
  win_vote_2 |  -58.46321    84.4085    -0.69   0.489    -224.2883    107.3619
       _cons |   46.98502   3.621681    12.97   0.000     39.87003    54.10001
------------------------------------------------------------------------------

not change
*/

*(h)

reg passrate0 win lose_vote lose_vote_2 win_vote win_vote_2 if vote > 0.15 & vote <0.85 , r


/*
Linear regression                               Number of obs     =        524
                                                F(5, 518)         =       1.36
                                                Prob > F          =     0.2377
                                                R-squared         =     0.0133
                                                Root MSE          =     15.084

------------------------------------------------------------------------------
             |               Robust
   passrate0 |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         win |  -4.843578   4.295899    -1.13   0.260     -13.2831    3.595948
   lose_vote |  -72.85856   46.31394    -1.57   0.116    -163.8448    18.12769
 lose_vote_2 |   194.9056    134.691     1.45   0.148    -69.70216    459.5133
    win_vote |  -11.38762   32.38318    -0.35   0.725    -75.00613     52.2309
  win_vote_2 |   .4255892   85.37878     0.00   0.996    -167.3057    168.1568
       _cons |   46.50545   3.424585    13.58   0.000     39.77767    53.23323
------------------------------------------------------------------------------



*/










