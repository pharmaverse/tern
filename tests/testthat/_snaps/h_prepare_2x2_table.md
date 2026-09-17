# h_prepare_2x2_table() warns when NAs are removed and quiet = FALSE

    Code
      h_prepare_2x2_table(df = subset(data, grp == "X"), df_ref = subset(data, grp ==
        "Placebo"), var = "rsp", strata_vars = "strata", complete_cases = TRUE,
      quiet = FALSE)
    Condition
      Warning:
      2 row(s) with missing values were omitted from the non-reference group (df).
      Warning:
      1 row(s) with missing values were omitted from the reference group (df_ref).
    Output
      $rsp
      [1]  TRUE FALSE  TRUE
      
      $grp
      [1] ref     ref     Not-ref
      Levels: ref Not-ref
      
      $strata
      [1] S1 S2 S1
      Levels: S1 S2
      
      $tbl
      , , strata = S1
      
               rsp
      grp       TRUE FALSE
        ref        1     0
        Not-ref    1     0
      
      , , strata = S2
      
               rsp
      grp       TRUE FALSE
        ref        0     1
        Not-ref    0     0
      
      

