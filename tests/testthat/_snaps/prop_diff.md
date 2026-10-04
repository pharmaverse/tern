# prop_diff_ha (proportion difference by Anderson-Hauck)

    Code
      res
    Output
      $diff
      [1] 0.25
      
      $diff_ci
      [1] -0.9195011  1.0000000
      

---

    Code
      res
    Output
      $diff
      [1] 0
      
      $diff_ci
      [1] -0.8451161  0.8451161
      

# prop_diff_nc (proportion difference by Newcombe)

    Code
      res
    Output
      $diff
      [1] 0.25
      
      $diff_ci
      [1] -0.2966681  0.6750199
      

---

    Code
      res
    Output
      $diff
      [1] 0
      
      $diff_ci
      [1] -0.361619  0.361619
      

# prop_diff_wald (proportion difference by Wald's test: with correction)

    Code
      res
    Output
      $diff
      [1] 0.25
      
      $diff_ci
      [1] -0.8069203  1.0000000
      

---

    Code
      res
    Output
      $diff
      [1] 0
      
      $diff_ci
      [1] -0.9208106  0.9208106
      

---

    Code
      res
    Output
      $diff
      [1] 0
      
      $diff_ci
      [1] -0.375  0.375
      

# prop_diff_wald (proportion difference by Wald's test: without correction)

    Code
      res
    Output
      $diff
      [1] 0.25
      
      $diff_ci
      [1] -0.4319203  0.9319203
      

---

    Code
      res
    Output
      $diff
      [1] 0
      
      $diff_ci
      [1] -0.4208106  0.4208106
      

---

    Code
      res
    Output
      $diff
      [1] 0
      
      $diff_ci
      [1] 0 0
      

# prop_diff_cmh (proportion difference by CMH)

    Code
      res
    Output
      $prop
        Placebo Treatment 
      0.5331117 0.3954251 
      
      $prop_ci
      $prop_ci$Placebo
      [1] 0.4306536 0.6355698
      
      $prop_ci$Treatment
      [1] 0.2890735 0.5017768
      
      
      $diff
      [1] -0.1376866
      
      $diff_ci
      [1] -0.285363076  0.009989872
      
      $se_diff
      [1] 0.08978092
      
      $weights
            a.x       b.x       a.y       b.y       a.z       b.z 
      0.1148388 0.2131696 0.1148388 0.2131696 0.1767914 0.1671918 
      
      $n1
      a.x b.x a.y b.y a.z b.z 
        4  11   8  11  13  11 
      
      $n2
      a.x b.x a.y b.y a.z b.z 
        8   9   4   9   6   6 
      

# prop_diff_cmh with Sato variance estimator for difference

    Code
      res
    Output
      $prop
        Placebo Treatment 
      0.5331117 0.3954251 
      
      $prop_ci
      $prop_ci$Placebo
      [1] 0.4306536 0.6355698
      
      $prop_ci$Treatment
      [1] 0.2890735 0.5017768
      
      
      $diff
      [1] -0.1376866
      
      $diff_ci
      [1] -0.31541846  0.04004526
      
      $se_diff
      [1] 0.1080533
      
      $weights
            a.x       b.x       a.y       b.y       a.z       b.z 
      0.1148388 0.2131696 0.1148388 0.2131696 0.1767914 0.1671918 
      
      $n1
      a.x b.x a.y b.y a.z b.z 
        4  11   8  11  13  11 
      
      $n2
      a.x b.x a.y b.y a.z b.z 
        8   9   4   9   6   6 
      

# prop_diff_cmh works correctly when some strata don't have both groups

    Code
      res
    Output
      $prop
        Placebo Treatment 
       0.569842  0.398075 
      
      $prop_ci
      $prop_ci$Placebo
      [1] 0.4637119 0.6759721
      
      $prop_ci$Treatment
      [1] 0.2836122 0.5125378
      
      
      $diff
      [1] -0.171767
      
      $diff_ci
      [1] -0.32786094 -0.01567301
      
      $se_diff
      [1] 0.09489839
      
      $weights
            a.x       b.x       a.y       b.y       a.z       b.z 
      0.0000000 0.2408257 0.1297378 0.2408257 0.1997279 0.1888829 
      
      $n1
      a.x b.x a.y b.y a.z b.z 
       12  11   8  11  13  11 
      
      $n2
      a.x b.x a.y b.y a.z b.z 
        0   9   4   9   6   6 
      

# prop_diff_cmh works correctly when strata combinations are empty

    Code
      res
    Output
      $prop
        Placebo Treatment 
       0.569842  0.398075 
      
      $prop_ci
      $prop_ci$Placebo
      [1] 0.4637119 0.6759721
      
      $prop_ci$Treatment
      [1] 0.2836122 0.5125378
      
      
      $diff
      [1] -0.171767
      
      $diff_ci
      [1] -0.32786094 -0.01567301
      
      $se_diff
      [1] 0.09489839
      
      $weights
            a.x       b.x       a.y       b.y       a.z       b.z 
             NA 0.2408257 0.1297378 0.2408257 0.1997279 0.1888829 
      
      $n1
      a.x b.x a.y b.y a.z b.z 
        0  11   8  11  13  11 
      
      $n2
      a.x b.x a.y b.y a.z b.z 
        0   9   4   9   6   6 
      

# prop_diff_strat_nc output matches equivalent SAS function output

    Code
      res
    Output
           value      lower      upper 
      0.25390590 0.03467969 0.44544132 

# h_prop_cmh works as expected with non-sparse tables

    Code
      res
    Output
      $x1
      S1 S2 S3 
      12 15  9 
      
      $n1
      S1 S2 S3 
      30 35 23 
      
      $p1
             S1        S2        S3 
      0.4000000 0.4285714 0.3913043 
      
      $x2
      S1 S2 S3 
       8 10  6 
      
      $n2
      S1 S2 S3 
      30 35 27 
      
      $p2
             S1        S2        S3 
      0.2666667 0.2857143 0.2222222 
      
      $w
         S1    S2    S3 
      15.00 17.50 12.42 
      
      $w_normalized
             S1        S2        S3 
      0.3339270 0.3895815 0.2764915 
      
      $est1
            ref 
      0.4087266 
      
      $est2
        Not-ref 
      0.2617988 
      
      $est_both_groups
            ref   Not-ref 
      0.4087266 0.2617988 
      
      $var1
              ref 
      0.002745713 
      
      $var2
          Not-ref 
      0.002101216 
      
      $ci_both_groups
      $ci_both_groups$ref
      [1] 0.3060254 0.5114279
      
      $ci_both_groups$`Not-ref`
      [1] 0.1719559 0.3516416
      
      

---

    Code
      res
    Output
      $x1
      S1 S2 S3 
       1 42  0 
      
      $n1
      S1 S2 S3 
       8 50 95 
      
      $p1
         S1    S2    S3 
      0.125 0.840 0.000 
      
      $x2
      S1 S2 S3 
       0  3  2 
      
      $n2
      S1 S2 S3 
      13 70 13 
      
      $p2
              S1         S2         S3 
      0.00000000 0.04285714 0.15384615 
      
      $w
             S1        S2        S3 
       4.952381 29.166667 11.435185 
      
      $w_normalized
             S1        S2        S3 
      0.1087140 0.6402625 0.2510235 
      
      $est1
            ref 
      0.5514097 
      
      $est2
         Not-ref 
      0.06605883 
      
      $est_both_groups
             ref    Not-ref 
      0.55140974 0.06605883 
      
      $var1
              ref 
      0.001263492 
      
      $var2
           Not-ref 
      0.0008712136 
      
      $ci_both_groups
      $ci_both_groups$ref
      [1] 0.4817416 0.6210779
      
      $ci_both_groups$`Not-ref`
      [1] 0.00820789 0.12390977
      
      

---

    Code
      res
    Output
      $x1
      S1 
       1 
      
      $n1
      S1 
       8 
      
      $p1
         S1 
      0.125 
      
      $x2
      S1 
       0 
      
      $n2
      S1 
      13 
      
      $p2
      S1 
       0 
      
      $w
            S1 
      4.952381 
      
      $w_normalized
      S1 
       1 
      
      $est1
        ref 
      0.125 
      
      $est2
      Not-ref 
            0 
      
      $est_both_groups
          ref Not-ref 
        0.125   0.000 
      
      $var1
             ref 
      0.01367188 
      
      $var2
      Not-ref 
            0 
      
      $ci_both_groups
      $ci_both_groups$ref
      [1] -0.1041723  0.3541723
      
      $ci_both_groups$`Not-ref`
      [1] 0 0
      
      

# h_prop_cmh handles empty and sparse contingency tables

    Code
      res
    Output
      $x1
      S1 S2 S3 
       0  0  0 
      
      $n1
      S1 S2 S3 
       0  0  0 
      
      $p1
      S1 S2 S3 
      NA NA NA 
      
      $x2
      S1 S2 S3 
       0  0  0 
      
      $n2
      S1 S2 S3 
       0  0  0 
      
      $p2
      S1 S2 S3 
      NA NA NA 
      
      $w
      S1 S2 S3 
      NA NA NA 
      
      $w_normalized
      S1 S2 S3 
      NA NA NA 
      
      $est1
      ref 
       NA 
      
      $est2
      Not-ref 
           NA 
      
      $est_both_groups
          ref Not-ref 
           NA      NA 
      
      $var1
      ref 
       NA 
      
      $var2
      Not-ref 
           NA 
      
      $ci_both_groups
      $ci_both_groups$ref
      [1] NA NA
      
      $ci_both_groups$`Not-ref`
      [1] NA NA
      
      

---

    Code
      res
    Output
      $x1
      S1 S2 S3 
       1  0  0 
      
      $n1
      S1 S2 S3 
       1  0  0 
      
      $p1
      S1 S2 S3 
       1 NA NA 
      
      $x2
      S1 S2 S3 
       0  0  0 
      
      $n2
      S1 S2 S3 
       0  0  0 
      
      $p2
      S1 S2 S3 
      NA NA NA 
      
      $w
      S1 S2 S3 
       0 NA NA 
      
      $w_normalized
      S1 S2 S3 
      NA NA NA 
      
      $est1
      ref 
       NA 
      
      $est2
      Not-ref 
           NA 
      
      $est_both_groups
          ref Not-ref 
           NA      NA 
      
      $var1
      ref 
       NA 
      
      $var2
      Not-ref 
           NA 
      
      $ci_both_groups
      $ci_both_groups$ref
      [1] NA NA
      
      $ci_both_groups$`Not-ref`
      [1] NA NA
      
      

---

    Code
      res
    Output
      $x1
      S1 S2 S3 
       0  1  0 
      
      $n1
      S1 S2 S3 
       0  1  0 
      
      $p1
      S1 S2 S3 
      NA  1 NA 
      
      $x2
      S1 S2 S3 
       0  0  0 
      
      $n2
      S1 S2 S3 
       0  0  0 
      
      $p2
      S1 S2 S3 
      NA NA NA 
      
      $w
      S1 S2 S3 
      NA  0 NA 
      
      $w_normalized
      S1 S2 S3 
      NA NA NA 
      
      $est1
      ref 
       NA 
      
      $est2
      Not-ref 
           NA 
      
      $est_both_groups
          ref Not-ref 
           NA      NA 
      
      $var1
      ref 
       NA 
      
      $var2
      Not-ref 
           NA 
      
      $ci_both_groups
      $ci_both_groups$ref
      [1] NA NA
      
      $ci_both_groups$`Not-ref`
      [1] NA NA
      
      

---

    Code
      res
    Output
      $x1
      S1 S2 S3 
       0  0  0 
      
      $n1
      S1 S2 S3 
       3  0  0 
      
      $p1
      S1 S2 S3 
       0 NA NA 
      
      $x2
      S1 S2 S3 
       0  0  0 
      
      $n2
      S1 S2 S3 
       0  0  0 
      
      $p2
      S1 S2 S3 
      NA NA NA 
      
      $w
      S1 S2 S3 
       0 NA NA 
      
      $w_normalized
      S1 S2 S3 
      NA NA NA 
      
      $est1
      ref 
       NA 
      
      $est2
      Not-ref 
           NA 
      
      $est_both_groups
          ref Not-ref 
           NA      NA 
      
      $var1
      ref 
       NA 
      
      $var2
      Not-ref 
           NA 
      
      $ci_both_groups
      $ci_both_groups$ref
      [1] NA NA
      
      $ci_both_groups$`Not-ref`
      [1] NA NA
      
      

---

    Code
      res
    Output
      $x1
      S1 S2 S3 
       0  0  0 
      
      $n1
      S1 S2 S3 
       0  0  1 
      
      $p1
      S1 S2 S3 
      NA NA  0 
      
      $x2
      S1 S2 S3 
       0  0  0 
      
      $n2
      S1 S2 S3 
       0  0  0 
      
      $p2
      S1 S2 S3 
      NA NA NA 
      
      $w
      S1 S2 S3 
      NA NA  0 
      
      $w_normalized
      S1 S2 S3 
      NA NA NA 
      
      $est1
      ref 
       NA 
      
      $est2
      Not-ref 
           NA 
      
      $est_both_groups
          ref Not-ref 
           NA      NA 
      
      $var1
      ref 
       NA 
      
      $var2
      Not-ref 
           NA 
      
      $ci_both_groups
      $ci_both_groups$ref
      [1] NA NA
      
      $ci_both_groups$`Not-ref`
      [1] NA NA
      
      

---

    Code
      res
    Output
      $x1
      S1 S2 S3 
       4  0  0 
      
      $n1
      S1 S2 S3 
       4  0  0 
      
      $p1
      S1 S2 S3 
       1 NA NA 
      
      $x2
      S1 S2 S3 
       0  7  0 
      
      $n2
      S1 S2 S3 
       0  7  0 
      
      $p2
      S1 S2 S3 
      NA  1 NA 
      
      $w
      S1 S2 S3 
       0  0 NA 
      
      $w_normalized
      S1 S2 S3 
      NA NA NA 
      
      $est1
      ref 
       NA 
      
      $est2
      Not-ref 
           NA 
      
      $est_both_groups
          ref Not-ref 
           NA      NA 
      
      $var1
      ref 
       NA 
      
      $var2
      Not-ref 
           NA 
      
      $ci_both_groups
      $ci_both_groups$ref
      [1] NA NA
      
      $ci_both_groups$`Not-ref`
      [1] NA NA
      
      

---

    Code
      res
    Output
      $x1
      S1 S2 S3 
       0  0  0 
      
      $n1
      S1 S2 S3 
       9  0  0 
      
      $p1
      S1 S2 S3 
       0 NA NA 
      
      $x2
      S1 S2 S3 
       0  0  0 
      
      $n2
      S1 S2 S3 
       0 12  0 
      
      $p2
      S1 S2 S3 
      NA  0 NA 
      
      $w
      S1 S2 S3 
       0  0 NA 
      
      $w_normalized
      S1 S2 S3 
      NA NA NA 
      
      $est1
      ref 
       NA 
      
      $est2
      Not-ref 
           NA 
      
      $est_both_groups
          ref Not-ref 
           NA      NA 
      
      $var1
      ref 
       NA 
      
      $var2
      Not-ref 
           NA 
      
      $ci_both_groups
      $ci_both_groups$ref
      [1] NA NA
      
      $ci_both_groups$`Not-ref`
      [1] NA NA
      
      

---

    Code
      res
    Output
      $x1
      S1 S2 S3 
       4  0 10 
      
      $n1
      S1 S2 S3 
       4  0 22 
      
      $p1
             S1        S2        S3 
      1.0000000        NA 0.4545455 
      
      $x2
      S1 S2 S3 
       0  0 40 
      
      $n2
      S1 S2 S3 
       0  0 83 
      
      $p2
             S1        S2        S3 
             NA        NA 0.4819277 
      
      $w
            S1       S2       S3 
       0.00000       NA 17.39048 
      
      $w_normalized
      S1 S2 S3 
       0 NA  1 
      
      $est1
            ref 
      0.4545455 
      
      $est2
        Not-ref 
      0.4819277 
      
      $est_both_groups
            ref   Not-ref 
      0.4545455 0.4819277 
      
      $var1
             ref 
      0.01126972 
      
      $var2
          Not-ref 
      0.003008113 
      
      $ci_both_groups
      $ci_both_groups$ref
      [1] 0.2464777 0.6626132
      
      $ci_both_groups$`Not-ref`
      [1] 0.3744310 0.5894244
      
      

# h_prop_cmh respects a custom confidence level

    Code
      res
    Output
      $x1
      S1 S2 S3 
      12 15  9 
      
      $n1
      S1 S2 S3 
      30 35 23 
      
      $p1
             S1        S2        S3 
      0.4000000 0.4285714 0.3913043 
      
      $x2
      S1 S2 S3 
       8 10  6 
      
      $n2
      S1 S2 S3 
      30 35 27 
      
      $p2
             S1        S2        S3 
      0.2666667 0.2857143 0.2222222 
      
      $w
         S1    S2    S3 
      15.00 17.50 12.42 
      
      $w_normalized
             S1        S2        S3 
      0.3339270 0.3895815 0.2764915 
      
      $est1
            ref 
      0.4087266 
      
      $est2
        Not-ref 
      0.2617988 
      
      $est_both_groups
            ref   Not-ref 
      0.4087266 0.2617988 
      
      $var1
              ref 
      0.002745713 
      
      $var2
          Not-ref 
      0.002101216 
      
      $ci_both_groups
      $ci_both_groups$ref
      [1] 0.3415739 0.4758794
      
      $ci_both_groups$`Not-ref`
      [1] 0.2030537 0.3205438
      
      

# h_cmh_sato_var works as expected with non-sparse tables

    0.00484709089617089

---

    0.00301389352651087

---

    0.013671875

# h_cmh_sato_var empty and sparse contingency tables

    NA_real_

---

    NA_real_

---

    NA_real_

---

    NA_real_

---

    NA_real_

---

    NA_real_

---

    NA_real_

---

    0.0142778351745434

# h_miettinen_nurminen_var works as expected with non-sparse tables

    Code
      res1
    Output
      $p1_est
             S1        S2        S3 
      0.4075605 0.4307970 0.3778246 
      
      $p2_est
             S1        S2        S3 
      0.2606327 0.2838692 0.2308967 
      
      $var_est
              S1         S2         S3 
      0.01471723 0.01299995 0.01714055 
      

---

    Code
      res2
    Output
      $p1_est
             S1        S2        S3 
      0.4853509 0.6010255 0.4953824 
      
      $p2_est
              S1         S2         S3 
      0.00000000 0.11567462 0.01003146 
      
      $var_est
               S1          S2          S3 
      0.032784334 0.006309801 0.003426996 
      

---

    Code
      res3
    Output
      $p1_est
         S1 
      0.125 
      
      $p2_est
                S1 
      1.110223e-16 
      
      $var_est
              S1 
      0.01435547 
      

# h_miettinen_nurminen_var empty and sparse contingency tables

    Code
      res1
    Output
      $p1_est
      S1 S2 S3 
      NA NA NA 
      
      $p2_est
      S1 S2 S3 
      NA NA NA 
      
      $var_est
      S1 S2 S3 
      NA NA NA 
      

---

    Code
      res2
    Output
      $p1_est
      S1 S2 S3 
      NA NA NA 
      
      $p2_est
      S1 S2 S3 
      NA NA NA 
      
      $var_est
      S1 S2 S3 
      NA NA NA 
      

---

    Code
      res3
    Output
      $p1_est
      S1 S2 S3 
      NA NA NA 
      
      $p2_est
      S1 S2 S3 
      NA NA NA 
      
      $var_est
      S1 S2 S3 
      NA NA NA 
      

---

    Code
      res4
    Output
      $p1_est
      S1 S2 S3 
      NA NA NA 
      
      $p2_est
      S1 S2 S3 
      NA NA NA 
      
      $var_est
      S1 S2 S3 
      NA NA NA 
      

---

    Code
      res5
    Output
      $p1_est
      S1 S2 S3 
      NA NA NA 
      
      $p2_est
      S1 S2 S3 
      NA NA NA 
      
      $var_est
      S1 S2 S3 
      NA NA NA 
      

---

    Code
      res6
    Output
      $p1_est
      S1 S2 S3 
      NA NA NA 
      
      $p2_est
      S1 S2 S3 
      NA NA NA 
      
      $var_est
      S1 S2 S3 
      NA NA NA 
      

---

    Code
      res7
    Output
      $p1_est
      S1 S2 S3 
      NA NA NA 
      
      $p2_est
      S1 S2 S3 
      NA NA NA 
      
      $var_est
      S1 S2 S3 
      NA NA NA 
      

---

    Code
      res8
    Output
      $p1_est
             S1        S2        S3 
      0.9726177       NaN 0.4545455 
      
      $p2_est
             S1        S2        S3 
      1.0000000       NaN 0.4819277 
      
      $var_est
              S1         S2         S3 
              NA         NA 0.01441512 
      

# h_miettinen_nurminen_var works as expected

    list(p1_est = 0.342213591803752, p2_est = 0.442213591803752, 
        var_est = 0.0405774934104561)

---

    list(p1_est = c(0.342213591803752, 0.265846883932378), p2_est = c(0.442213591803752, 
    0.365846883932378), var_est = c(0.0405774934104561, 0.0301587022300622
    ))

# h_miettinen_nurminen_stratified_ci works as expected with non-sparse tables

    Code
      res1
    Output
      $ci
      [1] -0.281568259 -0.008104148
      
      $se
      [1] 0.07017465
      

---

    Code
      res2
    Output
      $ci
      [1] -0.5899410 -0.3703714
      
      $se
      [1] 0.05648034
      

---

    Code
      res3
    Output
      $ci
      [1] -0.4797396  0.1311335
      
      $se
      [1] 0.1198143
      

# h_miettinen_nurminen_stratified_ci empty and sparse contingency tables

    Code
      res1
    Output
      $ci
      [1] NA NA
      
      $se
      [1] NA
      

---

    Code
      res2
    Output
      $ci
      [1] NA NA
      
      $se
      [1] NA
      

---

    Code
      res3
    Output
      $ci
      [1] NA NA
      
      $se
      [1] NA
      

---

    Code
      res4
    Output
      $ci
      [1] NA NA
      
      $se
      [1] NA
      

---

    Code
      res5
    Output
      $ci
      [1] NA NA
      
      $se
      [1] NA
      

---

    Code
      res6
    Output
      $ci
      [1] NA NA
      
      $se
      [1] NA
      

---

    Code
      res7
    Output
      $ci
      [1] NA NA
      
      $se
      [1] NA
      

---

    Code
      res8
    Output
      $ci
      [1] -0.2015304  0.2461176
      
      $se
      [1] 0.120063
      

# h_miettinen_nurminen_stratified_ci respects a custom confidence level

    Code
      res
    Output
      $ci
      [1] -0.2357582 -0.0563385
      
      $se
      [1] 0.07017465
      

# estimate_proportion_diff is compatible with rtables

    Code
      res
    Output
                                        B         A       
      ————————————————————————————————————————————————————
      Difference in Response rate (%)            25.0     
        90% CI (Anderson-Hauck)             (-92.0, 100.0)

# estimate_proportion_diff and cmh is compatible with rtables

    Code
      res
    Output
                                           B            A         
      ————————————————————————————————————————————————————————————
      Difference in Response rate (%)                -4.2133      
        90% CI (CMH, without correction)       (-20.0215, 11.5950)

# s_proportion_diff works with no strata

    Code
      res
    Output
      $diff
       diff_ha 
      14.69622 
      attr(,"label")
      [1] "Difference in Response rate (%)"
      
      $diff_ci
      diff_ci_ha_l diff_ci_ha_u 
         -3.118966    32.511412 
      attr(,"label")
      [1] "90% CI (Anderson-Hauck)"
      
      $diff_est_ci
           diff_ha diff_ci_ha_l diff_ci_ha_u 
         14.696223    -3.118966    32.511412 
      attr(,"label")
      [1] "Difference in Response rate (%) and 90% CI (Anderson-Hauck)"
      

# s_proportion_diff works with strata

    Code
      res
    Output
      $diff
      diff_cmh 
      13.76866 
      attr(,"label")
      [1] "Difference in Response rate (%)"
      
      $diff_ci
      diff_ci_cmh_l diff_ci_cmh_u 
         -0.9989872    28.5363076 
      attr(,"label")
      [1] "90% CI (CMH, without correction)"
      
      $se_diff
      se_diff_cmh 
         8.978092 
      attr(,"label")
      [1] "Standard Error of Difference in Response rate (%)"
      
      $diff_est_ci
           diff_cmh diff_ci_cmh_l diff_ci_cmh_u 
         13.7686602    -0.9989872    28.5363076 
      attr(,"label")
      [1] "Difference in Response rate (%) and 90% CI (CMH, without correction)"
      

# s_proportion_diff works with CMH Sato method

    Code
      res
    Output
      $diff
      diff_cmh_sato 
           13.76866 
      attr(,"label")
      [1] "Difference in Response rate (%)"
      
      $diff_ci
      diff_ci_cmh_sato_l diff_ci_cmh_sato_u 
               -4.004526          31.541846 
      attr(,"label")
      [1] "90% CI (CMH, Sato variance estimator)"
      
      $se_diff
      se_diff_cmh_sato 
              10.80533 
      attr(,"label")
      [1] "Standard Error of Difference in Response rate (%)"
      
      $diff_est_ci
           diff_cmh_sato diff_ci_cmh_sato_l diff_ci_cmh_sato_u 
               13.768660          -4.004526          31.541846 
      attr(,"label")
      [1] "Difference in Response rate (%) and 90% CI (CMH, Sato variance estimator)"
      

# s_proportion_diff works with CMH Miettinen and Nurminen method

    list(diff = structure(c(diff_cmh_mn = 13.7686601988347), label = "Difference in Response rate (%)"), 
        diff_ci = structure(c(diff_ci_cmh_mn_l = -3.45069418895496, 
        diff_ci_cmh_mn_u = 30.2144371774115), label = "90% CI (CMH, Miettinen and Nurminen)"), 
        se_diff = structure(c(se_diff_cmh_mn = 10.4103330371023), label = "Standard Error of Difference in Response rate (%)"), 
        diff_est_ci = structure(c(diff_cmh_mn = 13.7686601988347, 
        diff_ci_cmh_mn_l = -3.45069418895496, diff_ci_cmh_mn_u = 30.2144371774115
        ), label = "Difference in Response rate (%) and 90% CI (CMH, Miettinen and Nurminen)"))

# s_proportion_diff returns diff_est_ci with correct structure

    Code
      res
    Output
      $diff
      diff_wald 
      -7.272727 
      attr(,"label")
      [1] "Difference in Response rate (%)"
      
      $diff_ci
      diff_ci_wald_l diff_ci_wald_u 
           -26.73988       12.19443 
      attr(,"label")
      [1] "95% CI (Wald, without correction)"
      
      $diff_est_ci
           diff_wald diff_ci_wald_l diff_ci_wald_u 
           -7.272727     -26.739881      12.194426 
      attr(,"label")
      [1] "Difference in Response rate (%) and 95% CI (Wald, without correction)"
      

# s_proportion_diff ref column returns empty diff_est_ci

    Code
      res
    Output
      $diff
      numeric(0)
      attr(,"label")
      [1] "Difference in Response rate (%)"
      
      $diff_ci
      numeric(0)
      attr(,"label")
      [1] "95% CI (Wald, without correction)"
      
      $diff_est_ci
      numeric(0)
      attr(,"label")
      [1] "Difference in Response rate (%) and 95% CI (Wald, without correction)"
      

# estimate_proportion_diff with diff_est_ci builds single-row table

    Code
      res
    Output
                                                                                      A            B
      ——————————————————————————————————————————————————————————————————————————————————————————————
      Difference in Response rate (%) and 95% CI (Wald, without correction)   -7.3 (-26.7, 12.2)    

