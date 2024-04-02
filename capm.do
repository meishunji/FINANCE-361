




*import capm five factor data from ken kenneth data library
import delimited "F-F_Research_Data_5_Factors_2x3_daily.CSV", clear

*change date format
tostring date, replace
gen year = substr(date,1,4)
gen month = substr(date,5,2)
gen day = substr(date,7,2)
destring year month day, replace
gen date1 = mdy(month,day,year)
format date1 %tdCCYYMMDD
drop date year month day
rename date1 date
order date, before(mktrf)

save "capm.dta", replace





use "crsp.dta", clear
format date %tdCCYYMMDD
{
generate industry =.
    qui replace industry= 1 if sic>= 0100 & sic<= 0199
	qui replace industry= 1 if sic>= 0200 & sic<= 0299
	qui replace industry= 1 if sic>= 0700 & sic<= 0799
	qui replace industry= 1 if sic>= 0910 & sic<= 0919
	qui replace industry= 1 if sic>= 2048 & sic<= 2048
	
	qui replace industry= 2 if sic>= 2000 & sic<= 2009
	qui replace industry= 2 if sic>= 2010 & sic<= 2019
	qui replace industry= 2 if sic>= 2020 & sic<= 2029
	qui replace industry= 2 if sic>= 2030 & sic<= 2039
	qui replace industry= 2 if sic>= 2040 & sic<= 2046
	qui replace industry= 2 if sic>= 2050 & sic<= 2059
	qui replace industry= 2 if sic>= 2060 & sic<= 2063
	qui replace industry= 2 if sic>= 2070 & sic<= 2079
	qui replace industry= 2 if sic>= 2090 & sic<= 2092
	qui replace industry= 2 if sic>= 2095 & sic<= 2095
	qui replace industry= 2 if sic>= 2098 & sic<= 2099
	
	qui replace industry= 3 if sic>= 2064 & sic<= 2068
	qui replace industry= 3 if sic>= 2086 & sic<= 2086
	qui replace industry= 3 if sic>= 2087 & sic<= 2087
	qui replace industry= 3 if sic>= 2096 & sic<= 2096
	qui replace industry= 3 if sic>= 2097 & sic<= 2097
	
	qui replace industry= 4 if sic>= 2080 & sic<= 2080
	qui replace industry= 4 if sic>= 2082 & sic<= 2082
	qui replace industry= 4 if sic>= 2083 & sic<= 2083
	qui replace industry= 4 if sic>= 2084 & sic<= 2084
	qui replace industry= 4 if sic>= 2085 & sic<= 2085
	
	qui replace industry= 5 if sic>= 2100 & sic<= 2199
	
	qui replace industry= 6 if sic>= 0920 & sic<= 0999
	qui replace industry= 6 if sic>= 3650 & sic<= 3651
	qui replace industry= 6 if sic>= 3652 & sic<= 3652
	qui replace industry= 6 if sic>= 3732 & sic<= 3732
	qui replace industry= 6 if sic>= 3930 & sic<= 3931
	qui replace industry= 6 if sic>= 3940 & sic<= 3949
	
	qui replace industry= 7 if sic>= 7800 & sic<= 7829
	qui replace industry= 7 if sic>= 7830 & sic<= 7833
	qui replace industry= 7 if sic>= 7840 & sic<= 7841
	qui replace industry= 7 if sic>= 7900 & sic<= 7900
	qui replace industry= 7 if sic>= 7910 & sic<= 7911
	qui replace industry= 7 if sic>= 7920 & sic<= 7929
	qui replace industry= 7 if sic>= 7930 & sic<= 7933
	qui replace industry= 7 if sic>= 7940 & sic<= 7949
	qui replace industry= 7 if sic>= 7980 & sic<= 7980
	qui replace industry= 7 if sic>= 7990 & sic<= 7999
	
	qui replace industry= 8 if sic>= 2700 & sic<= 2709
	qui replace industry= 8 if sic>= 2710 & sic<= 2719
	qui replace industry= 8 if sic>= 2720 & sic<= 2729
	qui replace industry= 8 if sic>= 2730 & sic<= 2739
	qui replace industry= 8 if sic>= 2740 & sic<= 2749
	qui replace industry= 8 if sic>= 2770 & sic<= 2771
	qui replace industry= 8 if sic>= 2780 & sic<= 2789
	qui replace industry= 8 if sic>= 2790 & sic<= 2799
	
	qui replace industry= 9 if sic>= 2047 & sic<= 2047
	qui replace industry= 9 if sic>= 2391 & sic<= 2392
	qui replace industry= 9 if sic>= 2510 & sic<= 2519
	qui replace industry= 9 if sic>= 2590 & sic<= 2599
	qui replace industry= 9 if sic>= 2840 & sic<= 2843
	qui replace industry= 9 if sic>= 2844 & sic<= 2844
	qui replace industry= 9 if sic>= 3160 & sic<= 3161
	qui replace industry= 9 if sic>= 3170 & sic<= 3171
	qui replace industry= 9 if sic>= 3172 & sic<= 3172
	qui replace industry= 9 if sic>= 3190 & sic<= 3199
	qui replace industry= 9 if sic>= 3229 & sic<= 3229
	qui replace industry= 9 if sic>= 3260 & sic<= 3260
	qui replace industry= 9 if sic>= 3262 & sic<= 3263
	qui replace industry= 9 if sic>= 3269 & sic<= 3269
	qui replace industry= 9 if sic>= 3230 & sic<= 3231
	qui replace industry= 9 if sic>= 3630 & sic<= 3639
	qui replace industry= 9 if sic>= 3750 & sic<= 3751
	qui replace industry= 9 if sic>= 3800 & sic<= 3800
	qui replace industry= 9 if sic>= 3860 & sic<= 3861
	qui replace industry= 9 if sic>= 3870 & sic<= 3873
	qui replace industry= 9 if sic>= 3910 & sic<= 3911
	qui replace industry= 9 if sic>= 3914 & sic<= 3914
	qui replace industry= 9 if sic>= 3915 & sic<= 3915
	qui replace industry= 9 if sic>= 3960 & sic<= 3962
	qui replace industry= 9 if sic>= 3991 & sic<= 3991
	qui replace industry= 9 if sic>= 3995 & sic<= 3995
	
	qui replace industry= 10 if sic>= 2300 & sic<= 2390
	qui replace industry= 10 if sic>= 3020 & sic<= 3021
	qui replace industry= 10 if sic>= 3100 & sic<= 3111
	qui replace industry= 10 if sic>= 3130 & sic<= 3131
	qui replace industry= 10 if sic>= 3140 & sic<= 3149
	qui replace industry= 10 if sic>= 3150 & sic<= 3151
	qui replace industry= 10 if sic>= 3963 & sic<= 3965
	
	qui replace industry= 11 if sic>= 8000 & sic<= 8099
	
	qui replace industry= 12 if sic>= 3693 & sic<= 3693
	qui replace industry= 12 if sic>= 3840 & sic<= 3849
	qui replace industry= 12 if sic>= 3850 & sic<= 3851
	
	qui replace industry= 13 if sic>= 2830 & sic<= 2830
	qui replace industry= 13 if sic>= 2831 & sic<= 2831
	qui replace industry= 13 if sic>= 2833 & sic<= 2833
	qui replace industry= 13 if sic>= 2834 & sic<= 2834
	qui replace industry= 13 if sic>= 2835 & sic<= 2835
	qui replace industry= 13 if sic>= 2836 & sic<= 2836
	
	qui replace industry= 14 if sic>= 2800 & sic<= 2809
	qui replace industry= 14 if sic>= 2810 & sic<= 2819
	qui replace industry= 14 if sic>= 2820 & sic<= 2829
	qui replace industry= 14 if sic>= 2850 & sic<= 2859
	qui replace industry= 14 if sic>= 2860 & sic<= 2869
	qui replace industry= 14 if sic>= 2870 & sic<= 2879
	qui replace industry= 14 if sic>= 2890 & sic<= 2899
	
	qui replace industry= 15 if sic>= 3031 & sic<= 3031
	qui replace industry= 15 if sic>= 3041 & sic<= 3041
	qui replace industry= 15 if sic>= 3050 & sic<= 3053
	qui replace industry= 15 if sic>= 3060 & sic<= 3069
	qui replace industry= 15 if sic>= 3070 & sic<= 3079
	qui replace industry= 15 if sic>= 3080 & sic<= 3089
	qui replace industry= 15 if sic>= 3090 & sic<= 3099
	
	qui replace industry= 16 if sic>= 2200 & sic<= 2269
	qui replace industry= 16 if sic>= 2270 & sic<= 2279
	qui replace industry= 16 if sic>= 2280 & sic<= 2284
	qui replace industry= 16 if sic>= 2290 & sic<= 2295
	qui replace industry= 16 if sic>= 2297 & sic<= 2297
	qui replace industry= 16 if sic>= 2298 & sic<= 2298
	qui replace industry= 16 if sic>= 2299 & sic<= 2299
	qui replace industry= 16 if sic>= 2393 & sic<= 2395
	qui replace industry= 16 if sic>= 2397 & sic<= 2399
	
	qui replace industry= 17 if sic>= 0800 & sic<= 0899
	qui replace industry= 17 if sic>= 2400 & sic<= 2439
	qui replace industry= 17 if sic>= 2450 & sic<= 2459
	qui replace industry= 17 if sic>= 2490 & sic<= 2499
	qui replace industry= 17 if sic>= 2660 & sic<= 2661
	qui replace industry= 17 if sic>= 2950 & sic<= 2952
	qui replace industry= 17 if sic>= 3200 & sic<= 3200
	qui replace industry= 17 if sic>= 3210 & sic<= 3211
	qui replace industry= 17 if sic>= 3240 & sic<= 3241
	qui replace industry= 17 if sic>= 3250 & sic<= 3259
	qui replace industry= 17 if sic>= 3261 & sic<= 3261
	qui replace industry= 17 if sic>= 3264 & sic<= 3264
	qui replace industry= 17 if sic>= 3270 & sic<= 3275
	qui replace industry= 17 if sic>= 3280 & sic<= 3281
	qui replace industry= 17 if sic>= 3290 & sic<= 3293
	qui replace industry= 17 if sic>= 3295 & sic<= 3299
	qui replace industry= 17 if sic>= 3420 & sic<= 3429
	qui replace industry= 17 if sic>= 3430 & sic<= 3433
	qui replace industry= 17 if sic>= 3440 & sic<= 3441
	qui replace industry= 17 if sic>= 3442 & sic<= 3442
	qui replace industry= 17 if sic>= 3446 & sic<= 3446
	qui replace industry= 17 if sic>= 3448 & sic<= 3448
	qui replace industry= 17 if sic>= 3449 & sic<= 3449
	qui replace industry= 17 if sic>= 3450 & sic<= 3451
	qui replace industry= 17 if sic>= 3452 & sic<= 3452
	qui replace industry= 17 if sic>= 3490 & sic<= 3499
	qui replace industry= 17 if sic>= 3996 & sic<= 3996
	
	qui replace industry= 18 if sic>= 1500 & sic<= 1511
	qui replace industry= 18 if sic>= 1520 & sic<= 1529
	qui replace industry= 18 if sic>= 1530 & sic<= 1539
	qui replace industry= 18 if sic>= 1540 & sic<= 1549
	qui replace industry= 18 if sic>= 1600 & sic<= 1699
	qui replace industry= 18 if sic>= 1700 & sic<= 1799
	
	qui replace industry= 19 if sic>= 3300 & sic<= 3300
	qui replace industry= 19 if sic>= 3310 & sic<= 3317
	qui replace industry= 19 if sic>= 3320 & sic<= 3325
	qui replace industry= 19 if sic>= 3330 & sic<= 3339
	qui replace industry= 19 if sic>= 3340 & sic<= 3341
	qui replace industry= 19 if sic>= 3350 & sic<= 3357
	qui replace industry= 19 if sic>= 3360 & sic<= 3369
	qui replace industry= 19 if sic>= 3370 & sic<= 3379
	qui replace industry= 19 if sic>= 3390 & sic<= 3399
	
	qui replace industry= 20 if sic>= 3400 & sic<= 3400
	qui replace industry= 20 if sic>= 3443 & sic<= 3443
	qui replace industry= 20 if sic>= 3444 & sic<= 3444
	qui replace industry= 20 if sic>= 3460 & sic<= 3469
	qui replace industry= 20 if sic>= 3470 & sic<= 3479
	
	qui replace industry= 21 if sic>= 3510 & sic<= 3519
	qui replace industry= 21 if sic>= 3520 & sic<= 3529
	qui replace industry= 21 if sic>= 3530 & sic<= 3530
	qui replace industry= 21 if sic>= 3531 & sic<= 3531
	qui replace industry= 21 if sic>= 3532 & sic<= 3532
	qui replace industry= 21 if sic>= 3533 & sic<= 3533
	qui replace industry= 21 if sic>= 3534 & sic<= 3534
	qui replace industry= 21 if sic>= 3535 & sic<= 3535
	qui replace industry= 21 if sic>= 3536 & sic<= 3536
	qui replace industry= 21 if sic>= 3538 & sic<= 3538
	qui replace industry= 21 if sic>= 3540 & sic<= 3549
	qui replace industry= 21 if sic>= 3550 & sic<= 3559
	qui replace industry= 21 if sic>= 3560 & sic<= 3569
	qui replace industry= 21 if sic>= 3580 & sic<= 3580
	qui replace industry= 21 if sic>= 3581 & sic<= 3581
	qui replace industry= 21 if sic>= 3582 & sic<= 3582
	qui replace industry= 21 if sic>= 3585 & sic<= 3585
	qui replace industry= 21 if sic>= 3586 & sic<= 3586
	qui replace industry= 21 if sic>= 3589 & sic<= 3589
	qui replace industry= 21 if sic>= 3590 & sic<= 3599
	
	qui replace industry= 22 if sic>= 3600 & sic<= 3600
	qui replace industry= 22 if sic>= 3610 & sic<= 3613
	qui replace industry= 22 if sic>= 3620 & sic<= 3621
	qui replace industry= 22 if sic>= 3623 & sic<= 3629
	qui replace industry= 22 if sic>= 3640 & sic<= 3644
	qui replace industry= 22 if sic>= 3645 & sic<= 3645
	qui replace industry= 22 if sic>= 3646 & sic<= 3646
	qui replace industry= 22 if sic>= 3648 & sic<= 3649
	qui replace industry= 22 if sic>= 3660 & sic<= 3660
	qui replace industry= 22 if sic>= 3690 & sic<= 3690
	qui replace industry= 22 if sic>= 3691 & sic<= 3692
	qui replace industry= 22 if sic>= 3699 & sic<= 3699
	
	qui replace industry= 23 if sic>= 2296 & sic<= 2296
	qui replace industry= 23 if sic>= 2396 & sic<= 2396
	qui replace industry= 23 if sic>= 3010 & sic<= 3011
	qui replace industry= 23 if sic>= 3537 & sic<= 3537
	qui replace industry= 23 if sic>= 3647 & sic<= 3647
	qui replace industry= 23 if sic>= 3694 & sic<= 3694
	qui replace industry= 23 if sic>= 3700 & sic<= 3700
	qui replace industry= 23 if sic>= 3710 & sic<= 3710
	qui replace industry= 23 if sic>= 3711 & sic<= 3711
	qui replace industry= 23 if sic>= 3713 & sic<= 3713
	qui replace industry= 23 if sic>= 3714 & sic<= 3714
	qui replace industry= 23 if sic>= 3715 & sic<= 3715
	qui replace industry= 23 if sic>= 3716 & sic<= 3716
	qui replace industry= 23 if sic>= 3792 & sic<= 3792
	qui replace industry= 23 if sic>= 3790 & sic<= 3791
	qui replace industry= 23 if sic>= 3799 & sic<= 3799
	
	qui replace industry= 24 if sic>= 3720 & sic<= 3720
	qui replace industry= 24 if sic>= 3721 & sic<= 3721
	qui replace industry= 24 if sic>= 3723 & sic<= 3724
	qui replace industry= 24 if sic>= 3725 & sic<= 3725
	qui replace industry= 24 if sic>= 3728 & sic<= 3729
	
	qui replace industry= 25 if sic>= 3730 & sic<= 3731
	qui replace industry= 25 if sic>= 3740 & sic<= 3743
	
	qui replace industry= 26 if sic>= 3760 & sic<= 3769
	qui replace industry= 26 if sic>= 3795 & sic<= 3795
	qui replace industry= 26 if sic>= 3480 & sic<= 3489
	
	qui replace industry= 27 if sic>= 1040 & sic<= 1049
	
	qui replace industry= 28 if sic>= 1000 & sic<= 1009
	qui replace industry= 28 if sic>= 1010 & sic<= 1019
	qui replace industry= 28 if sic>= 1020 & sic<= 1029
	qui replace industry= 28 if sic>= 1030 & sic<= 1039
	qui replace industry= 28 if sic>= 1050 & sic<= 1059
	qui replace industry= 28 if sic>= 1060 & sic<= 1069
	qui replace industry= 28 if sic>= 1070 & sic<= 1079
	qui replace industry= 28 if sic>= 1080 & sic<= 1089
	qui replace industry= 28 if sic>= 1090 & sic<= 1099
	qui replace industry= 28 if sic>= 1100 & sic<= 1119
	qui replace industry= 28 if sic>= 1400 & sic<= 1499
	
	qui replace industry= 29 if sic>= 1200 & sic<= 1299
	
	qui replace industry= 30 if sic>= 1300 & sic<= 1300
	qui replace industry= 30 if sic>= 1310 & sic<= 1319
	qui replace industry= 30 if sic>= 1320 & sic<= 1329
	qui replace industry= 30 if sic>= 1330 & sic<= 1339
	qui replace industry= 30 if sic>= 1370 & sic<= 1379
	qui replace industry= 30 if sic>= 1380 & sic<= 1380
	qui replace industry= 30 if sic>= 1381 & sic<= 1381
	qui replace industry= 30 if sic>= 1382 & sic<= 1382
	qui replace industry= 30 if sic>= 1389 & sic<= 1389
	qui replace industry= 30 if sic>= 2900 & sic<= 2912
	qui replace industry= 30 if sic>= 2990 & sic<= 2999
	
	qui replace industry= 31 if sic>= 4900 & sic<= 4900
	qui replace industry= 31 if sic>= 4910 & sic<= 4911
	qui replace industry= 31 if sic>= 4920 & sic<= 4922
	qui replace industry= 31 if sic>= 4923 & sic<= 4923
	qui replace industry= 31 if sic>= 4924 & sic<= 4925
	qui replace industry= 31 if sic>= 4930 & sic<= 4931
	qui replace industry= 31 if sic>= 4932 & sic<= 4932
	qui replace industry= 31 if sic>= 4939 & sic<= 4939
	qui replace industry= 31 if sic>= 4940 & sic<= 4942
	
	qui replace industry= 32 if sic>= 4800 & sic<= 4800
	qui replace industry= 32 if sic>= 4810 & sic<= 4813
	qui replace industry= 32 if sic>= 4820 & sic<= 4822
	qui replace industry= 32 if sic>= 4830 & sic<= 4839
	qui replace industry= 32 if sic>= 4840 & sic<= 4841
	qui replace industry= 32 if sic>= 4880 & sic<= 4889
	qui replace industry= 32 if sic>= 4890 & sic<= 4890
	qui replace industry= 32 if sic>= 4891 & sic<= 4891
	qui replace industry= 32 if sic>= 4892 & sic<= 4892
	qui replace industry= 32 if sic>= 4899 & sic<= 4899
	
	qui replace industry= 33 if sic>= 7020 & sic<= 7021
	qui replace industry= 33 if sic>= 7030 & sic<= 7033
	qui replace industry= 33 if sic>= 7200 & sic<= 7200
	qui replace industry= 33 if sic>= 7210 & sic<= 7212
	qui replace industry= 33 if sic>= 7214 & sic<= 7214
	qui replace industry= 33 if sic>= 7215 & sic<= 7216
	qui replace industry= 33 if sic>= 7217 & sic<= 7217
	qui replace industry= 33 if sic>= 7219 & sic<= 7219
	qui replace industry= 33 if sic>= 7220 & sic<= 7221
	qui replace industry= 33 if sic>= 7230 & sic<= 7231
	qui replace industry= 33 if sic>= 7240 & sic<= 7241
	qui replace industry= 33 if sic>= 7250 & sic<= 7251
	qui replace industry= 33 if sic>= 7260 & sic<= 7269
	qui replace industry= 33 if sic>= 7270 & sic<= 7290
	qui replace industry= 33 if sic>= 7291 & sic<= 7291
	qui replace industry= 33 if sic>= 7292 & sic<= 7299
	qui replace industry= 33 if sic>= 7395 & sic<= 7395
	qui replace industry= 33 if sic>= 7500 & sic<= 7500
	qui replace industry= 33 if sic>= 7520 & sic<= 7529
	qui replace industry= 33 if sic>= 7530 & sic<= 7539
	qui replace industry= 33 if sic>= 7540 & sic<= 7549
	qui replace industry= 33 if sic>= 7600 & sic<= 7600
	qui replace industry= 33 if sic>= 7620 & sic<= 7620
	qui replace industry= 33 if sic>= 7622 & sic<= 7622
	qui replace industry= 33 if sic>= 7623 & sic<= 7623
	qui replace industry= 33 if sic>= 7629 & sic<= 7629
	qui replace industry= 33 if sic>= 7630 & sic<= 7631
	qui replace industry= 33 if sic>= 7640 & sic<= 7641
	qui replace industry= 33 if sic>= 7690 & sic<= 7699
	qui replace industry= 33 if sic>= 8100 & sic<= 8199
	qui replace industry= 33 if sic>= 8200 & sic<= 8299
	qui replace industry= 33 if sic>= 8300 & sic<= 8399
	qui replace industry= 33 if sic>= 8400 & sic<= 8499
	qui replace industry= 33 if sic>= 8600 & sic<= 8699
	qui replace industry= 33 if sic>= 8800 & sic<= 8899
	qui replace industry= 33 if sic>= 7510 & sic<= 7515
	
	qui replace industry= 34 if sic>= 2750 & sic<= 2759
	qui replace industry= 34 if sic>= 3993 & sic<= 3993
	qui replace industry= 34 if sic>= 7218 & sic<= 7218
	qui replace industry= 34 if sic>= 7300 & sic<= 7300
	qui replace industry= 34 if sic>= 7310 & sic<= 7319
	qui replace industry= 34 if sic>= 7320 & sic<= 7329
	qui replace industry= 34 if sic>= 7330 & sic<= 7339
	qui replace industry= 34 if sic>= 7340 & sic<= 7342
	qui replace industry= 34 if sic>= 7349 & sic<= 7349
	qui replace industry= 34 if sic>= 7350 & sic<= 7351
	qui replace industry= 34 if sic>= 7352 & sic<= 7352
	qui replace industry= 34 if sic>= 7353 & sic<= 7353
	qui replace industry= 34 if sic>= 7359 & sic<= 7359
	qui replace industry= 34 if sic>= 7360 & sic<= 7369
	qui replace industry= 34 if sic>= 7370 & sic<= 7372
	qui replace industry= 34 if sic>= 7374 & sic<= 7374
	qui replace industry= 34 if sic>= 7375 & sic<= 7375
	qui replace industry= 34 if sic>= 7376 & sic<= 7376
	qui replace industry= 34 if sic>= 7377 & sic<= 7377
	qui replace industry= 34 if sic>= 7378 & sic<= 7378
	qui replace industry= 34 if sic>= 7379 & sic<= 7379
	qui replace industry= 34 if sic>= 7380 & sic<= 7380
	qui replace industry= 34 if sic>= 7381 & sic<= 7382
	qui replace industry= 34 if sic>= 7383 & sic<= 7383
	qui replace industry= 34 if sic>= 7384 & sic<= 7384
	qui replace industry= 34 if sic>= 7385 & sic<= 7385
	qui replace industry= 34 if sic>= 7389 & sic<= 7390
	qui replace industry= 34 if sic>= 7391 & sic<= 7391
	qui replace industry= 34 if sic>= 7392 & sic<= 7392
	qui replace industry= 34 if sic>= 7393 & sic<= 7393
	qui replace industry= 34 if sic>= 7394 & sic<= 7394
	qui replace industry= 34 if sic>= 7396 & sic<= 7396
	qui replace industry= 34 if sic>= 7397 & sic<= 7397
	qui replace industry= 34 if sic>= 7399 & sic<= 7399
	qui replace industry= 34 if sic>= 7519 & sic<= 7519
	qui replace industry= 34 if sic>= 8700 & sic<= 8700
	qui replace industry= 34 if sic>= 8710 & sic<= 8713
	qui replace industry= 34 if sic>= 8720 & sic<= 8721
	qui replace industry= 34 if sic>= 8730 & sic<= 8734
	qui replace industry= 34 if sic>= 8740 & sic<= 8748
	qui replace industry= 34 if sic>= 8900 & sic<= 8910
	qui replace industry= 34 if sic>= 8911 & sic<= 8911
	qui replace industry= 34 if sic>= 8920 & sic<= 8999
	qui replace industry= 34 if sic>= 4220 & sic<= 4229
	
	qui replace industry= 35 if sic>= 3570 & sic<= 3579
	qui replace industry= 35 if sic>= 3680 & sic<= 3680
	qui replace industry= 35 if sic>= 3681 & sic<= 3681
	qui replace industry= 35 if sic>= 3682 & sic<= 3682
	qui replace industry= 35 if sic>= 3683 & sic<= 3683
	qui replace industry= 35 if sic>= 3684 & sic<= 3684
	qui replace industry= 35 if sic>= 3685 & sic<= 3685
	qui replace industry= 35 if sic>= 3686 & sic<= 3686
	qui replace industry= 35 if sic>= 3687 & sic<= 3687
	qui replace industry= 35 if sic>= 3688 & sic<= 3688
	qui replace industry= 35 if sic>= 3689 & sic<= 3689
	qui replace industry= 35 if sic>= 3695 & sic<= 3695
	qui replace industry= 35 if sic>= 7373 & sic<= 7373
	
	qui replace industry= 36 if sic>= 3622 & sic<= 3622
	qui replace industry= 36 if sic>= 3661 & sic<= 3661
	qui replace industry= 36 if sic>= 3662 & sic<= 3662
	qui replace industry= 36 if sic>= 3663 & sic<= 3663
	qui replace industry= 36 if sic>= 3664 & sic<= 3664
	qui replace industry= 36 if sic>= 3665 & sic<= 3665
	qui replace industry= 36 if sic>= 3666 & sic<= 3666
	qui replace industry= 36 if sic>= 3669 & sic<= 3669
	qui replace industry= 36 if sic>= 3670 & sic<= 3679
	qui replace industry= 36 if sic>= 3810 & sic<= 3810
	qui replace industry= 36 if sic>= 3812 & sic<= 3812
	
	qui replace industry= 37 if sic>= 3811 & sic<= 3811
	qui replace industry= 37 if sic>= 3820 & sic<= 3820
	qui replace industry= 37 if sic>= 3821 & sic<= 3821
	qui replace industry= 37 if sic>= 3822 & sic<= 3822
	qui replace industry= 37 if sic>= 3823 & sic<= 3823
	qui replace industry= 37 if sic>= 3824 & sic<= 3824
	qui replace industry= 37 if sic>= 3825 & sic<= 3825
	qui replace industry= 37 if sic>= 3826 & sic<= 3826
	qui replace industry= 37 if sic>= 3827 & sic<= 3827
	qui replace industry= 37 if sic>= 3829 & sic<= 3829
	qui replace industry= 37 if sic>= 3830 & sic<= 3839
	
	qui replace industry= 38 if sic>= 2520 & sic<= 2549
	qui replace industry= 38 if sic>= 2600 & sic<= 2639
	qui replace industry= 38 if sic>= 2670 & sic<= 2699
	qui replace industry= 38 if sic>= 2760 & sic<= 2761
	qui replace industry= 38 if sic>= 3950 & sic<= 3955
	
	qui replace industry= 39 if sic>= 2440 & sic<= 2449
	qui replace industry= 39 if sic>= 2640 & sic<= 2659
	qui replace industry= 39 if sic>= 3220 & sic<= 3221
	qui replace industry= 39 if sic>= 3410 & sic<= 3412
	
	qui replace industry= 40 if sic>= 4000 & sic<= 4013
	qui replace industry= 40 if sic>= 4040 & sic<= 4049
	qui replace industry= 40 if sic>= 4100 & sic<= 4100
	qui replace industry= 40 if sic>= 4110 & sic<= 4119
	qui replace industry= 40 if sic>= 4120 & sic<= 4121
	qui replace industry= 40 if sic>= 4130 & sic<= 4131
	qui replace industry= 40 if sic>= 4140 & sic<= 4142
	qui replace industry= 40 if sic>= 4150 & sic<= 4151
	qui replace industry= 40 if sic>= 4170 & sic<= 4173
	qui replace industry= 40 if sic>= 4190 & sic<= 4199
	qui replace industry= 40 if sic>= 4200 & sic<= 4200
	qui replace industry= 40 if sic>= 4210 & sic<= 4219
	qui replace industry= 40 if sic>= 4230 & sic<= 4231
	qui replace industry= 40 if sic>= 4240 & sic<= 4249
	qui replace industry= 40 if sic>= 4400 & sic<= 4499
	qui replace industry= 40 if sic>= 4500 & sic<= 4599
	qui replace industry= 40 if sic>= 4600 & sic<= 4699
	qui replace industry= 40 if sic>= 4700 & sic<= 4700
	qui replace industry= 40 if sic>= 4710 & sic<= 4712
	qui replace industry= 40 if sic>= 4720 & sic<= 4729
	qui replace industry= 40 if sic>= 4730 & sic<= 4739
	qui replace industry= 40 if sic>= 4740 & sic<= 4749
	qui replace industry= 40 if sic>= 4780 & sic<= 4780
	qui replace industry= 40 if sic>= 4782 & sic<= 4782
	qui replace industry= 40 if sic>= 4783 & sic<= 4783
	qui replace industry= 40 if sic>= 4784 & sic<= 4784
	qui replace industry= 40 if sic>= 4785 & sic<= 4785
	qui replace industry= 40 if sic>= 4789 & sic<= 4789
	
	qui replace industry= 41 if sic>= 5000 & sic<= 5000
	qui replace industry= 41 if sic>= 5010 & sic<= 5015
	qui replace industry= 41 if sic>= 5020 & sic<= 5023
	qui replace industry= 41 if sic>= 5030 & sic<= 5039
	qui replace industry= 41 if sic>= 5040 & sic<= 5042
	qui replace industry= 41 if sic>= 5043 & sic<= 5043
	qui replace industry= 41 if sic>= 5044 & sic<= 5044
	qui replace industry= 41 if sic>= 5045 & sic<= 5045
	qui replace industry= 41 if sic>= 5046 & sic<= 5046
	qui replace industry= 41 if sic>= 5047 & sic<= 5047
	qui replace industry= 41 if sic>= 5048 & sic<= 5048
	qui replace industry= 41 if sic>= 5049 & sic<= 5049
	qui replace industry= 41 if sic>= 5050 & sic<= 5059
	qui replace industry= 41 if sic>= 5060 & sic<= 5060
	qui replace industry= 41 if sic>= 5063 & sic<= 5063
	qui replace industry= 41 if sic>= 5064 & sic<= 5064
	qui replace industry= 41 if sic>= 5065 & sic<= 5065
	qui replace industry= 41 if sic>= 5070 & sic<= 5078
	qui replace industry= 41 if sic>= 5080 & sic<= 5080
	qui replace industry= 41 if sic>= 5081 & sic<= 5081
	qui replace industry= 41 if sic>= 5082 & sic<= 5082
	qui replace industry= 41 if sic>= 5083 & sic<= 5083
	qui replace industry= 41 if sic>= 5084 & sic<= 5084
	qui replace industry= 41 if sic>= 5085 & sic<= 5085
	qui replace industry= 41 if sic>= 5086 & sic<= 5087
	qui replace industry= 41 if sic>= 5088 & sic<= 5088
	qui replace industry= 41 if sic>= 5090 & sic<= 5090
	qui replace industry= 41 if sic>= 5091 & sic<= 5092
	qui replace industry= 41 if sic>= 5093 & sic<= 5093
	qui replace industry= 41 if sic>= 5094 & sic<= 5094
	qui replace industry= 41 if sic>= 5099 & sic<= 5099
	qui replace industry= 41 if sic>= 5100 & sic<= 5100
	qui replace industry= 41 if sic>= 5110 & sic<= 5113
	qui replace industry= 41 if sic>= 5120 & sic<= 5122
	qui replace industry= 41 if sic>= 5130 & sic<= 5139
	qui replace industry= 41 if sic>= 5140 & sic<= 5149
	qui replace industry= 41 if sic>= 5150 & sic<= 5159
	qui replace industry= 41 if sic>= 5160 & sic<= 5169
	qui replace industry= 41 if sic>= 5170 & sic<= 5172
	qui replace industry= 41 if sic>= 5180 & sic<= 5182
	qui replace industry= 41 if sic>= 5190 & sic<= 5199
	
	qui replace industry= 42 if sic>= 5200 & sic<= 5200
	qui replace industry= 42 if sic>= 5210 & sic<= 5219
	qui replace industry= 42 if sic>= 5220 & sic<= 5229
	qui replace industry= 42 if sic>= 5230 & sic<= 5231
	qui replace industry= 42 if sic>= 5250 & sic<= 5251
	qui replace industry= 42 if sic>= 5260 & sic<= 5261
	qui replace industry= 42 if sic>= 5270 & sic<= 5271
	qui replace industry= 42 if sic>= 5300 & sic<= 5300
	qui replace industry= 42 if sic>= 5310 & sic<= 5311
	qui replace industry= 42 if sic>= 5320 & sic<= 5320
	qui replace industry= 42 if sic>= 5330 & sic<= 5331
	qui replace industry= 42 if sic>= 5334 & sic<= 5334
	qui replace industry= 42 if sic>= 5340 & sic<= 5349
	qui replace industry= 42 if sic>= 5390 & sic<= 5399
	qui replace industry= 42 if sic>= 5400 & sic<= 5400
	qui replace industry= 42 if sic>= 5410 & sic<= 5411
	qui replace industry= 42 if sic>= 5412 & sic<= 5412
	qui replace industry= 42 if sic>= 5420 & sic<= 5429
	qui replace industry= 42 if sic>= 5430 & sic<= 5439
	qui replace industry= 42 if sic>= 5440 & sic<= 5449
	qui replace industry= 42 if sic>= 5450 & sic<= 5459
	qui replace industry= 42 if sic>= 5460 & sic<= 5469
	qui replace industry= 42 if sic>= 5490 & sic<= 5499
	qui replace industry= 42 if sic>= 5500 & sic<= 5500
	qui replace industry= 42 if sic>= 5510 & sic<= 5529
	qui replace industry= 42 if sic>= 5530 & sic<= 5539
	qui replace industry= 42 if sic>= 5540 & sic<= 5549
	qui replace industry= 42 if sic>= 5550 & sic<= 5559
	qui replace industry= 42 if sic>= 5560 & sic<= 5569
	qui replace industry= 42 if sic>= 5570 & sic<= 5579
	qui replace industry= 42 if sic>= 5590 & sic<= 5599
	qui replace industry= 42 if sic>= 5600 & sic<= 5699
	qui replace industry= 42 if sic>= 5700 & sic<= 5700
	qui replace industry= 42 if sic>= 5710 & sic<= 5719
	qui replace industry= 42 if sic>= 5720 & sic<= 5722
	qui replace industry= 42 if sic>= 5730 & sic<= 5733
	qui replace industry= 42 if sic>= 5734 & sic<= 5734
	qui replace industry= 42 if sic>= 5735 & sic<= 5735
	qui replace industry= 42 if sic>= 5736 & sic<= 5736
	qui replace industry= 42 if sic>= 5750 & sic<= 5799
	qui replace industry= 42 if sic>= 5900 & sic<= 5900
	qui replace industry= 42 if sic>= 5910 & sic<= 5912
	qui replace industry= 42 if sic>= 5920 & sic<= 5929
	qui replace industry= 42 if sic>= 5930 & sic<= 5932
	qui replace industry= 42 if sic>= 5940 & sic<= 5940
	qui replace industry= 42 if sic>= 5941 & sic<= 5941
	qui replace industry= 42 if sic>= 5942 & sic<= 5942
	qui replace industry= 42 if sic>= 5943 & sic<= 5943
	qui replace industry= 42 if sic>= 5944 & sic<= 5944
	qui replace industry= 42 if sic>= 5945 & sic<= 5945
	qui replace industry= 42 if sic>= 5946 & sic<= 5946
	qui replace industry= 42 if sic>= 5947 & sic<= 5947
	qui replace industry= 42 if sic>= 5948 & sic<= 5948
	qui replace industry= 42 if sic>= 5949 & sic<= 5949
	qui replace industry= 42 if sic>= 5950 & sic<= 5959
	qui replace industry= 42 if sic>= 5960 & sic<= 5969
	qui replace industry= 42 if sic>= 5970 & sic<= 5979
	qui replace industry= 42 if sic>= 5980 & sic<= 5989
	qui replace industry= 42 if sic>= 5990 & sic<= 5990
	qui replace industry= 42 if sic>= 5992 & sic<= 5992
	qui replace industry= 42 if sic>= 5993 & sic<= 5993
	qui replace industry= 42 if sic>= 5994 & sic<= 5994
	qui replace industry= 42 if sic>= 5995 & sic<= 5995
	qui replace industry= 42 if sic>= 5999 & sic<= 5999
	
	qui replace industry= 43 if sic>= 5800 & sic<= 5819
	qui replace industry= 43 if sic>= 5820 & sic<= 5829
	qui replace industry= 43 if sic>= 5890 & sic<= 5899
	qui replace industry= 43 if sic>= 7000 & sic<= 7000
	qui replace industry= 43 if sic>= 7010 & sic<= 7019
	qui replace industry= 43 if sic>= 7040 & sic<= 7049
	qui replace industry= 43 if sic>= 7213 & sic<= 7213
	
	qui replace industry= 44 if sic>= 6000 & sic<= 6000
	qui replace industry= 44 if sic>= 6010 & sic<= 6019
	qui replace industry= 44 if sic>= 6020 & sic<= 6020
	qui replace industry= 44 if sic>= 6021 & sic<= 6021
	qui replace industry= 44 if sic>= 6022 & sic<= 6022
	qui replace industry= 44 if sic>= 6023 & sic<= 6024
	qui replace industry= 44 if sic>= 6025 & sic<= 6025
	qui replace industry= 44 if sic>= 6026 & sic<= 6026
	qui replace industry= 44 if sic>= 6027 & sic<= 6027
	qui replace industry= 44 if sic>= 6028 & sic<= 6029
	qui replace industry= 44 if sic>= 6030 & sic<= 6036
	qui replace industry= 44 if sic>= 6040 & sic<= 6059
	qui replace industry= 44 if sic>= 6060 & sic<= 6062
	qui replace industry= 44 if sic>= 6080 & sic<= 6082
	qui replace industry= 44 if sic>= 6090 & sic<= 6099
	qui replace industry= 44 if sic>= 6100 & sic<= 6100
	qui replace industry= 44 if sic>= 6110 & sic<= 6111
	qui replace industry= 44 if sic>= 6112 & sic<= 6113
	qui replace industry= 44 if sic>= 6120 & sic<= 6129
	qui replace industry= 44 if sic>= 6130 & sic<= 6139
	qui replace industry= 44 if sic>= 6140 & sic<= 6149
	qui replace industry= 44 if sic>= 6150 & sic<= 6159
	qui replace industry= 44 if sic>= 6160 & sic<= 6169
	qui replace industry= 44 if sic>= 6170 & sic<= 6179
	qui replace industry= 44 if sic>= 6190 & sic<= 6199
	
	qui replace industry= 45 if sic>= 6300 & sic<= 6300
	qui replace industry= 45 if sic>= 6310 & sic<= 6319
	qui replace industry= 45 if sic>= 6320 & sic<= 6329
	qui replace industry= 45 if sic>= 6330 & sic<= 6331
	qui replace industry= 45 if sic>= 6350 & sic<= 6351
	qui replace industry= 45 if sic>= 6360 & sic<= 6361
	qui replace industry= 45 if sic>= 6370 & sic<= 6379
	qui replace industry= 45 if sic>= 6390 & sic<= 6399
	qui replace industry= 45 if sic>= 6400 & sic<= 6411
	
	qui replace industry= 46 if sic>= 6500 & sic<= 6500
	qui replace industry= 46 if sic>= 6510 & sic<= 6510
	qui replace industry= 46 if sic>= 6512 & sic<= 6512
	qui replace industry= 46 if sic>= 6513 & sic<= 6513
	qui replace industry= 46 if sic>= 6514 & sic<= 6514
	qui replace industry= 46 if sic>= 6515 & sic<= 6515
	qui replace industry= 46 if sic>= 6517 & sic<= 6519
	qui replace industry= 46 if sic>= 6520 & sic<= 6529
	qui replace industry= 46 if sic>= 6530 & sic<= 6531
	qui replace industry= 46 if sic>= 6532 & sic<= 6532
	qui replace industry= 46 if sic>= 6540 & sic<= 6541
	qui replace industry= 46 if sic>= 6550 & sic<= 6553
	qui replace industry= 46 if sic>= 6590 & sic<= 6599
	qui replace industry= 46 if sic>= 6610 & sic<= 6611
	
	qui replace industry= 47 if sic>= 6200 & sic<= 6299
	qui replace industry= 47 if sic>= 6700 & sic<= 6700
	qui replace industry= 47 if sic>= 6710 & sic<= 6719
	qui replace industry= 47 if sic>= 6720 & sic<= 6722
	qui replace industry= 47 if sic>= 6723 & sic<= 6723
	qui replace industry= 47 if sic>= 6724 & sic<= 6724
	qui replace industry= 47 if sic>= 6725 & sic<= 6725
	qui replace industry= 47 if sic>= 6726 & sic<= 6726
	qui replace industry= 47 if sic>= 6730 & sic<= 6733
	qui replace industry= 47 if sic>= 6740 & sic<= 6779
	qui replace industry= 47 if sic>= 6790 & sic<= 6791
	qui replace industry= 47 if sic>= 6792 & sic<= 6792
	qui replace industry= 47 if sic>= 6793 & sic<= 6793
	qui replace industry= 47 if sic>= 6794 & sic<= 6794
	qui replace industry= 47 if sic>= 6795 & sic<= 6795
	qui replace industry= 47 if sic>= 6798 & sic<= 6798
	qui replace industry= 47 if sic>= 6799 & sic<= 6799
	
	qui replace industry= 48 if sic>= 4950 & sic<= 4959
	qui replace industry= 48 if sic>= 4960 & sic<= 4961
	qui replace industry= 48 if sic>= 4970 & sic<= 4971
	qui replace industry= 48 if sic>= 4990 & sic<= 4991

}


save "crsp_calculated.dta", replace




use "crsp_calculated.dta", clear

merge m:1 date using "capm.dta", keepusing(rf mktrf smb hml rmw cma)
	keep if _merge ==3
	drop _merge
gen year = year(date)
	order year, before(date)
	drop if ticker ==""
duplicates drop ticker date, force
	sort ticker date
	duplicates examples ticker date
	*(firm date level panel data)

*generate excess return and winsorize at 1% level to avoid outlier
gen exret = ret-rf
summarize exret, detail
winsor exret, gen(exret_w) p(0.01)
summarize exret_w, detail

*histogram
histogram exret_w

*summary statistics
fsum exret_w mktrf smb hml rmw cma


*capm model
reg exret_w mktrf
reg exret_w mktrf i.industry
reg exret_w mktrf i.industry i.year
reg exret_w mktrf i.industry i.year, cl(ticker) r



*ff3 factor model
reg exret_w mktrf smb hml i.industry i.year, cl(ticker) r


*ff5 factor model
reg exret_w mktrf smb hml rmw cma i.industry i.year, cl(ticker) r



**************************************Are stocks overpeform or underperforme during covid19 period?*******************************
preserve 
drop if year<2010 

*capm model (2010-2018)
reg exret_w mktrf i.industry i.year if year>=2010 & year<=2018, cl(ticker) r
predict norm_exret_capm
gen abnorm_exret_capm = exret-norm_exret_capm

*ff3 factor model (2010-2018)
reg exret_w mktrf smb hml i.industry i.year if year>=2010 & year<=2018, cl(ticker) r
predict norm_exret_ff3
gen abnorm_exret_ff3 = exret-norm_exret_ff3

*ff5 factor model (2010-2018)
reg exret_w mktrf smb hml rmw cma i.industry i.year if year>=2010 & year<=2018, cl(ticker) r
predict norm_exret_ff5
gen abnorm_exret_ff5 = exret-norm_exret_ff5



**************************************Time series analysis*******************************

summarize abnorm_exret_capm abnorm_exret_ff3 abnorm_exret_ff5 if year>=2010 & year<=2018
summarize abnorm_exret_capm abnorm_exret_ff3 abnorm_exret_ff5 if year>=2019 & year<=2022
gen covid = 1 if year >=2019 & year<=2022
replace covid = 0 if year>=2010 & year<=2018
ttest abnorm_exret_capm, by(covid)

forvalues i=2010(1)2022 {
	summarize abnorm_exret_capm abnorm_exret_ff3 abnorm_exret_ff5 if year==`i'
}

*placebo test

replace post =.
replace post  = 1 if year ==2019 
replace post = 0 if year>=2010 & year<=2018
ttest abnorm_exret_capm, by(post)


replace post =.
replace post  = 1 if year ==2020 
replace post = 0 if year>=2010 & year<=2018
ttest abnorm_exret_capm, by(post)

replace post =.
replace post  = 1 if year ==2021 
replace post = 0 if year>=2010 & year<=2018
ttest abnorm_exret_capm, by(post)

replace post =.
replace post  = 1 if year ==2022 
replace post = 0 if year>=2010 & year<=2018
ttest abnorm_exret_capm, by(post)




*placebo test

replace post =.
replace post  = 1 if year ==2019 
replace post = 0 if year>=2010 & year<=2018
ttest abnorm_exret_ff3, by(post)


replace post =.
replace post  = 1 if year ==2020 
replace post = 0 if year>=2010 & year<=2018
ttest abnorm_exret_ff3, by(post)

replace post =.
replace post  = 1 if year ==2021 
replace post = 0 if year>=2010 & year<=2018
ttest abnorm_exret_ff3, by(post)

replace post =.
replace post  = 1 if year ==2022 
replace post = 0 if year>=2010 & year<=2018
ttest abnorm_exret_ff3, by(post)



*placebo test

replace post =.
replace post  = 1 if year ==2019 
replace post = 0 if year>=2010 & year<=2018
ttest abnorm_exret_ff5, by(post)


replace post =.
replace post  = 1 if year ==2020 
replace post = 0 if year>=2010 & year<=2018
ttest abnorm_exret_ff5, by(post)

replace post =.
replace post  = 1 if year ==2021 
replace post = 0 if year>=2010 & year<=2018
ttest abnorm_exret_ff5, by(post)

replace post =.
replace post  = 1 if year ==2022 
replace post = 0 if year>=2010 & year<=2018
ttest abnorm_exret_ff5, by(post)


*scatter plot for some stock examples (APPLE)

twoway scatter abnorm_exret_capm date if year>=2015 & year<=2022 & abnorm_exret_capm>=-0.1 & abnorm_exret_capm<=0.1 & ticker == "AAPL" || fpfit abnorm_exret_capm date if year>=2015 & year<=2018 & abnorm_exret_capm>=-0.1 & abnorm_exret_capm<=0.1 & ticker == "AAPL" || fpfit abnorm_exret_capm date if year>=2019 & year<=2022 & abnorm_exret_capm>=-0.1 & abnorm_exret_capm<=0.1 & ticker == "AAPL", msize(thick) legend(order(1 "Abnoral return (CAPM) scatter" 2 "Abnoral return (CAPM) polynomial fit" )) xtitle(date) ytitle(Abnoral return (CAPM) ) xline(21581) 

twoway scatter abnorm_exret_ff3 date if year>=2010 & year<=2022 & ticker == "AAPL" 
twoway scatter abnorm_exret_ff5 date if year>=2010 & year<=2022 & ticker == "AAPL" 


* create bin indicator [break into 80 equally spaced categories from -0.1 to +0.1]
di date("19900101","YMD")
di date("20190201","YMD")
di date("20221231","YMD")
gen bin = autocode(date, 800, 10958, 23010) if year>=2015 & year<=2022 & abnorm_exret_capm>=-0.1 & abnorm_exret_capm<=0.1 & ticker == "AAPL"
* code average dv in each bin
egen abnorm_exret_capm_bin = mean(abnorm_exret_capm) if year>=2010 & year<=2022 & abnorm_exret_capm>=-0.1 & abnorm_exret_capm<=0.1 & ticker == "AAPL", by(bin) 

* scatter plot and polynomial fit within bin

twoway scatter abnorm_exret_capm_bin date if year>=2015 & year<=2022 & abnorm_exret_capm>=-0.1 & abnorm_exret_capm<=0.1 & ticker == "AAPL" || fpfit abnorm_exret_capm_bin date if year>=2015 & year<=2018 & abnorm_exret_capm>=-0.1 & abnorm_exret_capm<=0.1 & ticker == "AAPL" || fpfit abnorm_exret_capm_bin date if year>=2019 & year<=2022 & abnorm_exret_capm>=-0.1 & abnorm_exret_capm<=0.1 & ticker == "AAPL", msize(thick) legend(order(1 "Abnoral return (CAPM) scatter" 2 "Abnoral return (CAPM) polynomial fit" )) xtitle(date) ytitle(Abnoral return (CAPM) ) xline(21581) 






*regression analysis


reg abnorm_exret_capm covid i.industry i.year , cl(ticker) r
reg abnorm_exret_ff3 covid i.industry i.year , cl(ticker) r
reg abnorm_exret_ff5 covid i.industry i.year , cl(ticker) r









**************************************Industry analysis: which industry is mostly affected by covid?*******************************

forvalues i=1(1)48{
	reg abnorm_exret_capm covid i.year if industry == `i', cl(ticker) r
	outreg2 using Table_1, append excel tstat bdec(3) tdec(3) rdec(3) ctitle (abnorm_exret_capm ) keep (covid) addtext(Industry 2-digit SIC, `i', Year FE, YES)
	}
	
forvalues i=1(1)48{
	reg abnorm_exret_ff3 covid i.year if industry == `i', cl(ticker) r
	outreg2 using Table_1, append excel tstat bdec(3) tdec(3) rdec(3) ctitle (abnorm_exret_ff3 ) keep (covid) addtext(Industry 2-digit SIC, `i', Year FE, YES)
	}	
	
forvalues i=1(1)48{
	reg abnorm_exret_ff5 covid i.year if industry == `i', cl(ticker) r
	outreg2 using Table_1, append excel tstat bdec(3) tdec(3) rdec(3) ctitle (abnorm_exret_ff5 ) keep (covid) addtext(Industry 2-digit SIC, `i', Year FE, YES)
	}	

	

	
	
**************************************Can we use CAPM, FF3 and FF5 model to predict stock return during crisis period?*******************************
*Answer: No, becuase stocks usually underperform during crisis period.




















