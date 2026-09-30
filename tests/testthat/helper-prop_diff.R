h_get_prop_data <- function(sparse = FALSE) {
  checkmate::assert_flag(sparse)

  dimnames <- list(grp = c("ref", "Not-ref"), rsp = c("TRUE", "FALSE"), strata = c("S1", "S2", "S3"))

  tables <- if (!sparse) {
    list(
      tbl1 = array(
        c(
          12, 8, 18, 22, # S1
          15, 10, 20, 25, # S2
          9, 6, 14, 21 # S3
        ),
        dim = c(2L, 2L, 3L),
        dimnames = dimnames
      ),
      tbl2 = array(
        c(
          1, 0, 7, 13, # S1
          42, 3, 8, 67, # S2
          0, 2, 95, 11 # S3
        ),
        dim = c(2L, 2L, 3L),
        dimnames = dimnames
      ),
      tbl3 = array(
        c(1, 0, 7, 13), # S1
        dim = c(2L, 2L, 1L),
        dimnames = list(grp = c("ref", "Not-ref"), rsp = c("TRUE", "FALSE"), strata = "S1")
      )
    )
  } else {
    list(
      tbl1 = array(
        c(
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0
        ),
        dim = c(2L, 2L, 3L), dimnames = dimnames
      ),
      tbl2 = array(
        c(
          1, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0
        ),
        dim = c(2L, 2L, 3L), dimnames = dimnames
      ),
      tbl3 = array(
        c(
          0, 0, 0, 0,
          1, 0, 0, 0,
          0, 0, 0, 0
        ),
        dim = c(2L, 2L, 3L), dimnames = dimnames
      ),
      tbl4 = array(
        c(
          0, 0, 3, 0,
          0, 0, 0, 0,
          0, 0, 0, 0
        ),
        dim = c(2L, 2L, 3L), dimnames = dimnames
      ),
      tbl5 = array(
        c(
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 1, 0
        ),
        dim = c(2L, 2L, 3L), dimnames = dimnames
      ),
      tbl6 = array(
        c(
          4, 0, 0, 0,
          0, 7, 0, 0,
          0, 0, 0, 0
        ),
        dim = c(2L, 2L, 3L), dimnames = dimnames
      ),
      tbl7 = array(
        c(
          0, 0, 9, 0,
          0, 0, 0, 12,
          0, 0, 0, 0
        ),
        dim = c(2L, 2L, 3L), dimnames = dimnames
      ),
      tbl8 = array(
        c(
          4, 0, 0, 0,
          0, 0, 0, 0,
          10, 40, 12, 43
        ),
        dim = c(2L, 2L, 3L), dimnames = dimnames
      )
    )
  }

  tables
}
