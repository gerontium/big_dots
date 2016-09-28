# BigDots
Daniel Newman  




# Stim Locked Beta

```
## Automatically converting the following non-factors to factors: Time, Hemifield
```

```
## Loading required package: plyr
```

```
## -------------------------------------------------------------------------
```

```
## You have loaded plyr after dplyr - this is likely to cause problems.
## If you need functions from both plyr and dplyr, please load plyr first, then dplyr:
## library(plyr); library(dplyr)
```

```
## -------------------------------------------------------------------------
```

```
## 
## Attaching package: 'plyr'
```

```
## The following object is masked from 'package:lubridate':
## 
##     here
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    -558      -8     542     542    1092    1642
```

```
## Loading required package: dplyr
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:plyr':
## 
##     arrange, count, desc, failwith, id, mutate, rename, summarise,
##     summarize
```

```
## The following object is masked from 'package:MASS':
## 
##     select
```

```
## The following objects are masked from 'package:lubridate':
## 
##     intersect, setdiff, union
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```
## [[1]]
## [1] TRUE
## 
## [[2]]
## [1] TRUE
## 
## [[3]]
## [1] TRUE
## 
## [[4]]
## [1] TRUE
## 
## [[5]]
## [1] TRUE
## 
## [[6]]
## [1] TRUE
## 
## [[7]]
## [1] TRUE
## 
## [[8]]
## [1] TRUE
## 
## [[9]]
## [1] TRUE
## 
## [[10]]
## [1] TRUE
## 
## [[11]]
## [1] TRUE
## 
## [[12]]
## [1] TRUE
## 
## [[13]]
## [1] TRUE
## 
## [[14]]
## [1] TRUE
## 
## [[15]]
## [1] TRUE
```

![](markdown_BigDots_files/figure-html/Stim Locked Beta-1.png)<!-- -->![](markdown_BigDots_files/figure-html/Stim Locked Beta-2.png)<!-- -->

```
## Adding missing grouping variables: `ID`
```

# Resp Locked Beta Slope

```
## Automatically converting the following non-factors to factors: Time, Hemifield
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    -400    -280    -160    -160     -40      80
```

```
## Loading required package: dplyr
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:plyr':
## 
##     arrange, count, desc, failwith, id, mutate, rename, summarise,
##     summarize
```

```
## The following object is masked from 'package:MASS':
## 
##     select
```

```
## The following objects are masked from 'package:lubridate':
## 
##     intersect, setdiff, union
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```
## [[1]]
## [1] TRUE
## 
## [[2]]
## [1] TRUE
## 
## [[3]]
## [1] TRUE
## 
## [[4]]
## [1] TRUE
## 
## [[5]]
## [1] TRUE
## 
## [[6]]
## [1] TRUE
## 
## [[7]]
## [1] TRUE
## 
## [[8]]
## [1] TRUE
## 
## [[9]]
## [1] TRUE
## 
## [[10]]
## [1] TRUE
## 
## [[11]]
## [1] TRUE
## 
## [[12]]
## [1] TRUE
## 
## [[13]]
## [1] TRUE
## 
## [[14]]
## [1] TRUE
## 
## [[15]]
## [1] TRUE
```

![](markdown_BigDots_files/figure-html/Resp Locked Beta-1.png)<!-- -->

```
## Adding missing grouping variables: `ID`
```

#Run the Shapiro-Wilk test of normality on the RT, CPPonset, N2c, etc. measures as a function of hemifield

Table: Normality tests

key                        ShapiroWilk_p_value   Anderson_Darling_p_value   CramerVonMises_p_value   Shapiro_Francia_p_value   Kolmogorov_Smirnov_p_value   average_p_value
------------------------  --------------------  -------------------------  -----------------------  ------------------------  ---------------------------  ----------------
Beta_LeftTarget                         0.0000                     0.0000                   0.0000                    0.0000                       0.0001            0.0000
PreAlpha_LeftHemi                       0.0000                     0.0000                   0.0000                    0.0000                       0.0003            0.0001
Beta_RightTarget                        0.0000                     0.0004                   0.0011                    0.0001                       0.0012            0.0006
PreAlpha_RightHemi                      0.0000                     0.0000                   0.0002                    0.0001                       0.0047            0.0010
RT_Right                                0.0042                     0.0008                   0.0006                    0.0066                       0.0000            0.0024
RT_Left                                 0.0074                     0.0069                   0.0117                    0.0115                       0.0050            0.0085
Beta_slope_LeftTarget                   0.0002                     0.0041                   0.0064                    0.0002                       0.0358            0.0094
N2i_latency_LeftTarget                  0.0006                     0.0027                   0.0240                    0.0028                       0.0429            0.0146
N2c_latency_LeftTarget                  0.0052                     0.0052                   0.0104                    0.0037                       0.0733            0.0196
CPPslope_LeftTarget                     0.0281                     0.0339                   0.0739                    0.0465                       0.1255            0.0616
N2i_latency_RightTarget                 0.0102                     0.0594                   0.1797                    0.0357                       0.0837            0.0737
N2c_RightTarget                         0.2607                     0.1636                   0.0979                    0.1458                       0.0710            0.1478
CPPslope_RightTarget                    0.0316                     0.1115                   0.2422                    0.0504                       0.3796            0.1631
CPPonset_RightTarget                    0.2368                     0.2326                   0.3083                    0.1364                       0.1971            0.2222
N2c_latency_RightTarget                 0.3077                     0.2236                   0.2044                    0.4142                       0.1073            0.2514
Beta_slope_RightTarget                  0.4875                     0.1687                   0.1056                    0.4690                       0.0447            0.2551
N2i_RightTarget                         0.4963                     0.3320                   0.3637                    0.3537                       0.2313            0.3554
N2i_LeftTarget                          0.7587                     0.5311                   0.4459                    0.6838                       0.3698            0.5579
CPPonset_LeftTarget                     0.8845                     0.7969                   0.7322                    0.5580                       0.5883            0.7120
N2c_LeftTarget                          0.7328                     0.8604                   0.8168                    0.8690                       0.8110            0.8180


#Test the effect of Target Hemifield on RT, CPPonset, N2c, etc. using repeated measures ANOVA

##In cases where the assumption of normality was violated, a factorial permutation test for the effect of Target Hemifield was performed with 1000 permutations and the permuted p-value also reported

```
## [1] "Repeated Measures ANOVA  for the effect of Hemifield on RT:"
```

```
## $ANOVA
##      Effect DFn DFd        F           p p<.05        ges
## 2 Hemifield   1  79 11.09909 0.001315453     * 0.00614155
```



Hemifield        mean          sd
----------  ---------  ----------
RT_Left      560.5923    90.97017
RT_Right     575.9704   105.36280

```
## [1] "Factorial Permutation test for the effect of Hemifield on RT:"
```

```
##      Effect     p p<.05
## 1 Hemifield 0.001     *
```

![](markdown_BigDots_files/figure-html/effect of Target Hemifield-1.png)<!-- -->

```
## [1] "Repeated Measures ANOVA  for the effect of Hemifield on Stim Locked Beta Amplitude:"
```

```
## $ANOVA
##      Effect DFn DFd         F        p p<.05          ges
## 2 Hemifield   1  79 0.6776128 0.412888       0.0006998092
```



Hemifield                 mean          sd
-----------------  -----------  ----------
Beta_LeftTarget     -0.0634617   0.0490625
Beta_RightTarget    -0.0662810   0.0577910

```
## [1] "Factorial Permutation test for the effect of Hemifield on Stim Locked Beta Amplitude:"
```

```
##      Effect     p p<.05
## 1 Hemifield 0.418
```

```
## [1] "Repeated Measures ANOVA  for the effect of Hemifield on Resp Locked Beta Slope:"
```

```
## $ANOVA
##      Effect DFn DFd         F         p p<.05          ges
## 2 Hemifield   1  79 0.1933328 0.6613577       0.0002554888
```



Hemifield                       mean          sd
-----------------------  -----------  ----------
Beta_slope_LeftTarget     -0.0003165   0.0002790
Beta_slope_RightTarget    -0.0003082   0.0002436

```
## [1] "Factorial Permutation test for the effect of Hemifield on SResp Locked Beta Slope:"
```

```
##      Effect    p p<.05
## 1 Hemifield 0.66
```

```
## [1] "Repeated Measures ANOVA  for the effect of Hemifield on CPP Onset:"
```

```
## $ANOVA
##      Effect DFn DFd        F         p p<.05        ges
## 2 Hemifield   1  79 5.540077 0.0210716     * 0.02451972
```



Hemifield                   mean         sd
---------------------  ---------  ---------
CPPonset_LeftTarget     319.3149   71.56050
CPPonset_RightTarget    340.9217   65.44587

![](markdown_BigDots_files/figure-html/effect of Target Hemifield-2.png)<!-- -->

```
## [1] "Repeated Measures ANOVA  for the effect of Hemifield on CPP Slope:"
```

```
## $ANOVA
##      Effect DFn DFd        F         p p<.05          ges
## 2 Hemifield   1  79 1.256175 0.2657719       0.0007765846
```



Hemifield                    mean          sd
---------------------  ----------  ----------
CPPslope_LeftTarget     0.0420739   0.0257619
CPPslope_RightTarget    0.0435124   0.0261618

```
## [1] "Repeated Measures ANOVA  for the effect of Hemifield on N2i_latency:"
```

```
## $ANOVA
##      Effect DFn DFd         F         p p<.05          ges
## 2 Hemifield   1  79 0.1545535 0.6952802       0.0006968114
```



Hemifield                    mean         sd
------------------------  -------  ---------
N2i_latency_LeftTarget     345.95   76.95863
N2i_latency_RightTarget    342.05   71.56689

```
## [1] "Factorial Permutation test for the effect of Hemifield on N2i_latency:"
```

```
##      Effect     p p<.05
## 1 Hemifield 0.691
```

```
## [1] "Repeated Measures ANOVA  for the effect of Hemifield on N2i Amplitude:"
```

```
## $ANOVA
##      Effect DFn DFd        F         p p<.05         ges
## 2 Hemifield   1  79 1.258714 0.2652931       0.005234692
```



Hemifield                mean         sd
----------------  -----------  ---------
N2i_LeftTarget     -0.6201119   1.666900
N2i_RightTarget    -0.8326304   1.251842

```
## [1] "Repeated Measures ANOVA  for the effect of Hemifield on N2c_latency:"
```

```
## $ANOVA
##      Effect DFn DFd           F         p p<.05           ges
## 2 Hemifield   1  79 0.005734358 0.9398289       0.00001832557
```



Hemifield                      mean         sd
------------------------  ---------  ---------
N2c_latency_LeftTarget     278.8255   42.92764
N2c_latency_RightTarget    278.4000   56.20343

```
## [1] "Factorial Permutation test for the effect of Hemifield on N2c_latency:"
```

```
##      Effect     p p<.05
## 1 Hemifield 0.946
```

```
## [1] "Repeated Measures ANOVA  for the effect of Hemifield on N2c Amplitude:"
```

```
## $ANOVA
##      Effect DFn DFd          F         p p<.05          ges
## 2 Hemifield   1  79 0.07554369 0.7841474       0.0003143128
```



Hemifield               mean         sd
----------------  ----------  ---------
N2c_LeftTarget     -2.046855   1.691659
N2c_RightTarget    -1.983437   1.901314

```
## [1] "Repeated Measures ANOVA  for the effect of Hemisphere on Pre-target Alpha Power:"
```

```
## $ANOVA
##       Effect DFn DFd        F           p p<.05         ges
## 2 Hemisphere   1  79 11.47905 0.001100043     * 0.004303091
```



Hemisphere                mean          sd
-------------------  ---------  ----------
PreAlpha_LeftHemi     1.854965   0.9656206
PreAlpha_RightHemi    1.980385   0.9542062

```
## [1] "Factorial Permutation test for the effect of Hemisphere on Pre-target Alpha Power:"
```

```
##       Effect     p p<.05
## 1 Hemisphere 0.001     *
```

![](markdown_BigDots_files/figure-html/effect of Target Hemifield-3.png)<!-- -->



#test correlation between all of the Asymmetry measures (i.e. RT, N2, CPP, alpha, asymmetry) 

Table: Normality tests

key                 ShapiroWilk_p_value   Anderson_Darling_p_value   CramerVonMises_p_value   Shapiro_Francia_p_value   Kolmogorov_Smirnov_p_value   average_p_value
-----------------  --------------------  -------------------------  -----------------------  ------------------------  ---------------------------  ----------------
N2i_Asym                         0.0000                     0.0000                   0.0000                    0.0000                       0.0000            0.0000
Beta_Asym                        0.0000                     0.0000                   0.0000                    0.0000                       0.0000            0.0000
Beta_slope_Asym                  0.0000                     0.0000                   0.0000                    0.0000                       0.0000            0.0000
N2c_Asym                         0.0000                     0.0000                   0.0000                    0.0000                       0.0000            0.0000
CPPslope_Asym                    0.0000                     0.0000                   0.0000                    0.0000                       0.0000            0.0000
CPPonset_Asym                    0.0001                     0.0000                   0.0001                    0.0001                       0.0016            0.0004
RT_Asym                          0.0072                     0.0015                   0.0009                    0.0071                       0.0056            0.0045
N2c_latency_Asym                 0.0409                     0.0739                   0.1188                    0.0272                       0.0150            0.0552
N2i_latency_Asym                 0.4109                     0.3248                   0.2624                    0.3902                       0.1485            0.3073
PreAlphaAsym                     0.9362                     0.8864                   0.7902                    0.9589                       0.5177            0.8179

```
## png 
##   2
```

![](markdown_BigDots_files/figure-html/correlation between Asymmetry measures-1.png)<!-- -->

```
## png 
##   2
```

![](markdown_BigDots_files/figure-html/correlation between Asymmetry measures-2.png)<!-- -->![](markdown_BigDots_files/figure-html/correlation between Asymmetry measures-3.png)<!-- -->![](markdown_BigDots_files/figure-html/correlation between Asymmetry measures-4.png)<!-- -->![](markdown_BigDots_files/figure-html/correlation between Asymmetry measures-5.png)<!-- -->![](markdown_BigDots_files/figure-html/correlation between Asymmetry measures-6.png)<!-- -->![](markdown_BigDots_files/figure-html/correlation between Asymmetry measures-7.png)<!-- -->![](markdown_BigDots_files/figure-html/correlation between Asymmetry measures-8.png)<!-- -->![](markdown_BigDots_files/figure-html/correlation between Asymmetry measures-9.png)<!-- -->![](markdown_BigDots_files/figure-html/correlation between Asymmetry measures-10.png)<!-- -->

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

```
## png 
##   2
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](markdown_BigDots_files/figure-html/correlation between Asymmetry measures-11.png)<!-- -->

#Look at multiple regression to predice RT_Asym 

```
## Analysis of Variance Table
## 
## Model 1: RT_Asym ~ 1
## Model 2: RT_Asym ~ Location + Sex + Age
## Model 3: RT_Asym ~ Location + Sex + Age + PreAlphaAsym
## Model 4: RT_Asym ~ Location + Sex + Age + PreAlphaAsym + N2c_Asym
## Model 5: RT_Asym ~ Location + Sex + Age + PreAlphaAsym + N2c_Asym + N2c_latency_Asym
## Model 6: RT_Asym ~ Location + Sex + Age + PreAlphaAsym + N2c_Asym + N2c_latency_Asym + 
##     CPPonset_Asym
## Model 7: RT_Asym ~ Location + Sex + Age + PreAlphaAsym + N2c_Asym + N2c_latency_Asym + 
##     CPPonset_Asym + CPPslope_Asym
## Model 8: RT_Asym ~ Location + Sex + Age + PreAlphaAsym + N2c_Asym + N2c_latency_Asym + 
##     CPPonset_Asym + CPPslope_Asym + Beta_Asym
##   Res.Df      RSS Df Sum of Sq      F  Pr(>F)   
## 1     79 0.080663                               
## 2     76 0.077307  3 0.0033561 1.2676 0.29223   
## 3     75 0.073756  1 0.0035507 4.0232 0.04874 * 
## 4     74 0.073747  1 0.0000095 0.0108 0.91750   
## 5     73 0.069951  1 0.0037956 4.3007 0.04178 * 
## 6     72 0.063390  1 0.0065614 7.4345 0.00808 **
## 7     71 0.062519  1 0.0008710 0.9869 0.32392   
## 8     70 0.061779  1 0.0007401 0.8385 0.36296   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```



term                  estimate   std.error   statistic     p.value
-----------------  -----------  ----------  ----------  ----------
(Intercept)         -0.0122048   0.0038876   -3.139450   0.0024105
PreAlphaAsym         0.0928053   0.0479848    1.934055   0.0568293
N2c_latency_Asym     0.0660998   0.0355564    1.859015   0.0668960
CPPonset_Asym        0.0795374   0.0263933    3.013549   0.0035071

```
##               term df       sumsq       meansq statistic     p.value
## 1     PreAlphaAsym  1 0.004036664 0.0040366643  4.677697 0.033701686
## 2 N2c_latency_Asym  1 0.003204580 0.0032045797  3.713475 0.057712720
## 3    CPPonset_Asym  1 0.007836949 0.0078369490  9.081477 0.003507135
## 4        Residuals 76 0.065584937 0.0008629597        NA          NA
```

```
## Loading required package: boot
```

```
## 
## Attaching package: 'boot'
```

```
## The following object is masked from 'package:survival':
## 
##     aml
```

```
## The following object is masked from 'package:psych':
## 
##     logit
```

```
## 
## Attaching package: 'QuantPsyc'
```

```
## The following object is masked from 'package:Matrix':
## 
##     norm
```

```
## The following object is masked from 'package:base':
## 
##     norm
```

```
## 
## Attaching package: 'car'
```

```
## The following object is masked from 'package:boot':
## 
##     logit
```

```
## The following object is masked from 'package:dplyr':
## 
##     recode
```

```
## The following object is masked from 'package:psych':
## 
##     logit
```

```
##     PreAlphaAsym N2c_latency_Asym    CPPonset_Asym 
##        0.2010498        0.1924425        0.3131420
```

```
##                         2.5 %       97.5 %
## (Intercept)      -0.019947508 -0.004462044
## PreAlphaAsym     -0.002764770  0.188375318
## N2c_latency_Asym -0.004716814  0.136916493
## CPPonset_Asym     0.026970651  0.132104128
```

![](markdown_BigDots_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

```
## Percentage of sample with standardized residuals greater than abs 2:
```

```
## 3.75 %
```

```
##             ID standardized.residuals cooks.distance   leverage
## 11     114M_CS              -2.192238     0.05129041 0.04094168
## 53     414M_LA              -2.534599     0.26270902 0.14057956
## 61 AA_15_04_14              -3.189023     0.07355423 0.02811684
##    covariance.ratios
## 11         0.8466146
## 53         0.8617520
## 61         0.6107168
```

```
##  lag Autocorrelation D-W Statistic p-value
##    1     -0.05587817       2.10579   0.624
##  Alternative hypothesis: rho != 0
```

```
##     PreAlphaAsym N2c_latency_Asym    CPPonset_Asym 
##         1.010076         1.001661         1.009278
```

```
##     PreAlphaAsym N2c_latency_Asym    CPPonset_Asym 
##        0.9900241        0.9983418        0.9908076
```

```
## Start:  AIC=-553.3
## RT_Asym ~ Location + Sex + Age + PreAlphaAsym + N2c_Asym + N2c_latency_Asym + 
##     CPPonset_Asym + CPPslope_Asym + Beta_Asym
## 
##                    Df Sum of Sq      RSS     AIC
## - Location          1 0.0000050 0.061784 -555.29
## - Sex               1 0.0000338 0.061813 -555.25
## - N2c_Asym          1 0.0001532 0.061932 -555.10
## - Beta_Asym         1 0.0007401 0.062519 -554.35
## - CPPslope_Asym     1 0.0009995 0.062778 -554.01
## - Age               1 0.0015636 0.063342 -553.30
## <none>                          0.061779 -553.30
## - N2c_latency_Asym  1 0.0023375 0.064116 -552.33
## - PreAlphaAsym      1 0.0026927 0.064472 -551.88
## - CPPonset_Asym     1 0.0053837 0.067163 -548.61
## 
## Step:  AIC=-555.29
## RT_Asym ~ Sex + Age + PreAlphaAsym + N2c_Asym + N2c_latency_Asym + 
##     CPPonset_Asym + CPPslope_Asym + Beta_Asym
## 
##                    Df Sum of Sq      RSS     AIC
## - Sex               1 0.0000367 0.061821 -557.24
## - N2c_Asym          1 0.0001596 0.061943 -557.08
## - Beta_Asym         1 0.0007383 0.062522 -556.34
## - CPPslope_Asym     1 0.0010131 0.062797 -555.99
## <none>                          0.061784 -555.29
## - Age               1 0.0015890 0.063373 -555.26
## - N2c_latency_Asym  1 0.0023325 0.064116 -554.33
## - PreAlphaAsym      1 0.0027599 0.064544 -553.80
## + Location          1 0.0000050 0.061779 -553.30
## - CPPonset_Asym     1 0.0055642 0.067348 -550.39
## 
## Step:  AIC=-557.24
## RT_Asym ~ Age + PreAlphaAsym + N2c_Asym + N2c_latency_Asym + 
##     CPPonset_Asym + CPPslope_Asym + Beta_Asym
## 
##                    Df Sum of Sq      RSS     AIC
## - N2c_Asym          1 0.0001379 0.061958 -559.07
## - Beta_Asym         1 0.0007072 0.062528 -558.33
## - CPPslope_Asym     1 0.0011532 0.062974 -557.77
## <none>                          0.061821 -557.24
## - Age               1 0.0015782 0.063399 -557.23
## - N2c_latency_Asym  1 0.0023740 0.064194 -556.23
## - PreAlphaAsym      1 0.0029096 0.064730 -555.56
## + Sex               1 0.0000367 0.061784 -555.29
## + Location          1 0.0000079 0.061813 -555.25
## - CPPonset_Asym     1 0.0055486 0.067369 -552.37
## 
## Step:  AIC=-559.07
## RT_Asym ~ Age + PreAlphaAsym + N2c_latency_Asym + CPPonset_Asym + 
##     CPPslope_Asym + Beta_Asym
## 
##                    Df Sum of Sq      RSS     AIC
## - Beta_Asym         1 0.0006489 0.062607 -560.23
## - CPPslope_Asym     1 0.0012336 0.063192 -559.49
## - Age               1 0.0015652 0.063524 -559.07
## <none>                          0.061958 -559.07
## - N2c_latency_Asym  1 0.0022388 0.064197 -558.23
## - PreAlphaAsym      1 0.0028313 0.064790 -557.49
## + N2c_Asym          1 0.0001379 0.061821 -557.24
## + Sex               1 0.0000150 0.061943 -557.08
## + Location          1 0.0000135 0.061945 -557.08
## - CPPonset_Asym     1 0.0055183 0.067477 -554.24
## 
## Step:  AIC=-560.23
## RT_Asym ~ Age + PreAlphaAsym + N2c_latency_Asym + CPPonset_Asym + 
##     CPPslope_Asym
## 
##                    Df Sum of Sq      RSS     AIC
## - CPPslope_Asym     1 0.0010207 0.063628 -560.94
## - Age               1 0.0014767 0.064084 -560.37
## <none>                          0.062607 -560.23
## + Beta_Asym         1 0.0006489 0.061958 -559.07
## - PreAlphaAsym      1 0.0030020 0.065609 -558.49
## + N2c_Asym          1 0.0000797 0.062528 -558.33
## - N2c_latency_Asym  1 0.0031332 0.065741 -558.33
## + Sex               1 0.0000008 0.062607 -558.23
## + Location          1 0.0000005 0.062607 -558.23
## - CPPonset_Asym     1 0.0055456 0.068153 -555.44
## 
## Step:  AIC=-560.94
## RT_Asym ~ Age + PreAlphaAsym + N2c_latency_Asym + CPPonset_Asym
## 
##                    Df Sum of Sq      RSS     AIC
## <none>                          0.063628 -560.94
## - Age               1 0.0019569 0.065585 -560.51
## + CPPslope_Asym     1 0.0010207 0.062607 -560.23
## + Beta_Asym         1 0.0004361 0.063192 -559.49
## + N2c_Asym          1 0.0001477 0.063480 -559.12
## + Sex               1 0.0000601 0.063568 -559.01
## + Location          1 0.0000092 0.063619 -558.95
## - N2c_latency_Asym  1 0.0032578 0.066886 -558.94
## - PreAlphaAsym      1 0.0033134 0.066941 -558.88
## - CPPonset_Asym     1 0.0066902 0.070318 -554.94
```

```
## Stepwise Model Path 
## Analysis of Deviance Table
## 
## Initial Model:
## RT_Asym ~ Location + Sex + Age + PreAlphaAsym + N2c_Asym + N2c_latency_Asym + 
##     CPPonset_Asym + CPPslope_Asym + Beta_Asym
## 
## Final Model:
## RT_Asym ~ Age + PreAlphaAsym + N2c_latency_Asym + CPPonset_Asym
## 
## 
##              Step Df       Deviance Resid. Df Resid. Dev       AIC
## 1                                          70 0.06177881 -553.2977
## 2      - Location  1 0.000005021331        71 0.06178383 -555.2912
## 3           - Sex  1 0.000036678343        72 0.06182051 -557.2437
## 4      - N2c_Asym  1 0.000137903740        73 0.06195841 -559.0655
## 5     - Beta_Asym  1 0.000648936838        74 0.06260735 -560.2319
## 6 - CPPslope_Asym  1 0.001020723159        75 0.06362807 -560.9382
```

```
##               term     estimate    std.error statistic     p.value
## 1      (Intercept) -0.043303371 0.0208360723 -2.078289 0.041104180
## 2              Age  0.001328244 0.0008745638  1.518751 0.133029687
## 3     PreAlphaAsym  0.094039403 0.0475845172  1.976261 0.051802913
## 4 N2c_latency_Asym  0.069201255 0.0353137059  1.959615 0.053756846
## 5    CPPonset_Asym  0.074158101 0.0264078734  2.808181 0.006347719
```

![](markdown_BigDots_files/figure-html/unnamed-chunk-1-2.png)<!-- -->![](markdown_BigDots_files/figure-html/unnamed-chunk-1-3.png)<!-- -->![](markdown_BigDots_files/figure-html/unnamed-chunk-1-4.png)<!-- -->![](markdown_BigDots_files/figure-html/unnamed-chunk-1-5.png)<!-- -->

```
## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
## Based on 2000 bootstrap replicates
## 
## CALL : 
## boot.ci(boot.out = bootResults, type = "bca", index = 1)
## 
## Intervals : 
## Level       BCa          
## 95%   (-0.0758,  0.0006 )  
## Calculations and Intervals on Original Scale
```

```
## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
## Based on 2000 bootstrap replicates
## 
## CALL : 
## boot.ci(boot.out = bootResults, type = "bca", index = 2)
## 
## Intervals : 
## Level       BCa          
## 95%   (-0.0201,  0.0161 )  
## Calculations and Intervals on Original Scale
```

```
## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
## Based on 2000 bootstrap replicates
## 
## CALL : 
## boot.ci(boot.out = bootResults, type = "bca", index = 3)
## 
## Intervals : 
## Level       BCa          
## 95%   (-0.0165,  0.0151 )  
## Calculations and Intervals on Original Scale
```

```
## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
## Based on 2000 bootstrap replicates
## 
## CALL : 
## boot.ci(boot.out = bootResults, type = "bca", index = 4)
## 
## Intervals : 
## Level       BCa          
## 95%   (-0.0007,  0.0028 )  
## Calculations and Intervals on Original Scale
```

```
## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
## Based on 2000 bootstrap replicates
## 
## CALL : 
## boot.ci(boot.out = bootResults, type = "bca", index = 5)
## 
## Intervals : 
## Level       BCa          
## 95%   (-0.0167,  0.1936 )  
## Calculations and Intervals on Original Scale
```

```
## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
## Based on 2000 bootstrap replicates
## 
## CALL : 
## boot.ci(boot.out = bootResults, type = "bca", index = 6)
## 
## Intervals : 
## Level       BCa          
## 95%   (-0.0099,  0.0054 )  
## Calculations and Intervals on Original Scale
```

```
## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
## Based on 2000 bootstrap replicates
## 
## CALL : 
## boot.ci(boot.out = bootResults, type = "bca", index = 7)
## 
## Intervals : 
## Level       BCa          
## 95%   (-0.0301,  0.1423 )  
## Calculations and Intervals on Original Scale
```

```
## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
## Based on 2000 bootstrap replicates
## 
## CALL : 
## boot.ci(boot.out = bootResults, type = "bca", index = 8)
## 
## Intervals : 
## Level       BCa          
## 95%   ( 0.0153,  0.1357 )  
## Calculations and Intervals on Original Scale
```

```
## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
## Based on 2000 bootstrap replicates
## 
## CALL : 
## boot.ci(boot.out = bootResults, type = "bca", index = 9)
## 
## Intervals : 
## Level       BCa          
## 95%   (-0.0094,  0.0413 )  
## Calculations and Intervals on Original Scale
```













