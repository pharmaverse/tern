test_that("mantel_fleiss_crit() works with multiple observations and strata", {
  tbl <- array(
    c(9L, 8L, 6L, 9L, 6L, 5L, 8L, 5L, 5L, 5L, 5L, 4L, 11L, 5L, 7L, 2L),
    dim = c(2L, 2L, 4L)
  )

  expect_silent(
    result <- mantel_fleiss_crit(tbl)
  )
  expect_silent(
    result_val <- mantel_fleiss_crit(tbl, TRUE)
  )

  expect_identical(result, TRUE)
  expect_identical(result_val, result, ignore_attr = TRUE)
  expect_equal(attributes(result_val), list(value = 20.16857), tolerance = 1e-6)
})

test_that("mantel_fleiss_crit() works with small stratified data and dimnames", {
  tbl <- array(
    c(2L, 2L, 1L, 2L, 0L, 1L, 2L, 1L, 1L, 1L, 3L, 1L, 1L, 0L, 1L, 1L),
    dim = c(2L, 2L, 4L),
    dimnames = list(grp = c("Gr1", "Gr2"), rsp = c("T", "F"), strata = LETTERS[1:4])
  )

  expect_silent(
    result <- mantel_fleiss_crit(tbl)
  )
  expect_silent(
    result_val <- mantel_fleiss_crit(tbl, TRUE)
  )

  expect_identical(result, FALSE)
  expect_identical(result_val, result, ignore_attr = TRUE)
  expect_equal(attributes(result_val), list(value = 2.785714), tolerance = 1e-6)
})

test_that("mantel_fleiss_crit() works with 1 stratum", {
  tbl <- array(c(4L, 4L, 7L, 5L), dim = c(2L, 2L, 1L))

  expect_silent(
    result <- mantel_fleiss_crit(tbl)
  )
  expect_silent(
    result_val <- mantel_fleiss_crit(tbl, TRUE)
  )

  expect_identical(result, FALSE)
  expect_identical(result_val, result, ignore_attr = TRUE)
  expect_equal(attributes(result_val), list(value = 3.6), tolerance = 1e-6)
})

test_that("mantel_fleiss_crit() ignores unobserved strata levels", {
  tbl <- array(
    c(1L, 4L, 3L, 3L, 5L, 0L, 7L, 4L, 0L, 0L, 0L, 0L, 3L, 1L, 0L, 6L),
    dim = c(2L, 2L, 4L)
  )

  expect_silent(
    result <- mantel_fleiss_crit(tbl)
  )
  expect_silent(
    result_val <- mantel_fleiss_crit(tbl, TRUE)
  )

  expect_identical(result, TRUE)
  expect_identical(result_val, result, ignore_attr = TRUE)
  expect_equal(attributes(result_val), list(value = 5.231818), tolerance = 1e-6)
})

test_that("mantel_fleiss_crit() returns NA when all cell counts equal zero", {
  tbl <- array(rep(0L, 16L), dim = c(2L, 2L, 4L))

  expect_silent(
    result <- mantel_fleiss_crit(tbl)
  )
  expect_silent(
    result_val <- mantel_fleiss_crit(tbl, TRUE)
  )

  expect_identical(result, NA)
  expect_identical(result_val, result, ignore_attr = TRUE)
  expect_identical(attributes(result_val), list(value = NA_real_))
})

test_that("mantel_fleiss_crit() handles a stratum with observations in one cell only", {
  tbl <- array(c(1L, 1L, 1L, 1L, 0L, 4L, 0L, 0L), dim = c(2L, 2L, 2L))

  result <- mantel_fleiss_crit(tbl)
  result_val <- mantel_fleiss_crit(tbl, TRUE)

  expect_identical(result, FALSE)
  expect_identical(result_val, result, ignore_attr = TRUE)
  expect_equal(attributes(result_val), list(value = 1), tolerance = 1e-6)
})

test_that("mantel_fleiss_crit() includes the MF = 5 boundary", {
  tbl <- array(c(5L, 5L, 10L, 10L), dim = c(2L, 2L, 1L))

  result <- mantel_fleiss_crit(tbl, include_value = TRUE)

  expect_identical(result, TRUE, ignore_attr = TRUE)
  expect_identical(attributes(result), list(value = 5))
})

test_that("mantel_fleiss_crit() handles data with no non-responses", {
  tbl <- array(c(2L, 4L, 0L, 0L), dim = c(2L, 2L, 2L))

  result <- mantel_fleiss_crit(tbl)
  result_val <- mantel_fleiss_crit(tbl, TRUE)

  expect_identical(result, FALSE)
  expect_identical(result_val, result, ignore_attr = TRUE)
  expect_identical(attributes(result_val), list(value = 0))
})

test_that("mantel_fleiss_crit() handles data with no responses", {
  tbl <- array(c(0L, 0L, 4L, 0L), dim = c(2L, 2L, 2L))

  result <- mantel_fleiss_crit(tbl)
  result_val <- mantel_fleiss_crit(tbl, TRUE)

  expect_identical(result, FALSE)
  expect_identical(result_val, result, ignore_attr = TRUE)
  expect_identical(attributes(result_val), list(value = 0))
})

test_that("mantel_fleiss_crit() works with observations from one group only (Gr1)", {
  tbl <- array(c(46L, 0L, 4L, 0L), dim = c(2L, 2L, 2L))

  result <- mantel_fleiss_crit(tbl)
  result_val <- mantel_fleiss_crit(tbl, TRUE)

  expect_identical(result, FALSE)
  expect_identical(result_val, result, ignore_attr = TRUE)
  expect_identical(attributes(result_val), list(value = 0))
})

test_that("mantel_fleiss_crit() works with observations from one group only (Gr2)", {
  tbl <- array(c(0L, 30L, 0L, 3L), dim = c(2L, 2L, 2L))

  result <- mantel_fleiss_crit(tbl)
  result_val <- mantel_fleiss_crit(tbl, TRUE)

  expect_identical(result, FALSE)
  expect_identical(result_val, result, ignore_attr = TRUE)
  expect_identical(attributes(result_val), list(value = 0))
})

test_that("mantel_fleiss_crit() respects the threshold", {
  tbl <- array(c(5L, 5L, 10L, 10L), dim = c(2L, 2L, 1L))

  expect_identical(mantel_fleiss_crit(tbl, threshold = 5), TRUE)
  expect_identical(mantel_fleiss_crit(tbl, threshold = 6), FALSE)

  result <- mantel_fleiss_crit(tbl, include_value = TRUE, threshold = 6)
  expect_identical(result, FALSE, ignore_attr = TRUE)
  expect_identical(attributes(result), list(value = 5))
})

test_that("mantel_fleiss_crit() validates inputs", {
  # tbl
  expect_error(mantel_fleiss_crit(matrix(1L, nrow = 2, ncol = 2)))
  expect_error(mantel_fleiss_crit(array(1L, dim = c(2L, 2L, 2L, 1L))))
  expect_error(mantel_fleiss_crit(array(1L, dim = c(3L, 2L, 2L))))
  expect_error(mantel_fleiss_crit(array(1L, dim = c(2L, 3L, 2L))))

  # Missing / invalid values.
  dim3d <- c(2L, 2L, 2L)
  expect_error(mantel_fleiss_crit(array(NA_integer_, dim = dim3d)))
  expect_error(mantel_fleiss_crit(array("1", dim = dim3d)))
  expect_error(mantel_fleiss_crit(array(NA_real_, dim = dim3d)))
  expect_error(mantel_fleiss_crit(array(NaN, dim = dim3d)))
  expect_error(mantel_fleiss_crit(array(-1, dim = dim3d)))
  expect_error(mantel_fleiss_crit(array(-1L, dim = dim3d)))
  expect_error(mantel_fleiss_crit(array(Inf, dim = dim3d)))

  # include_value
  tbl <- array(1L, dim = c(2L, 2L, 3L))
  expect_error(mantel_fleiss_crit(tbl, include_value = c(TRUE, FALSE)))
  expect_error(mantel_fleiss_crit(tbl, include_value = 1L))
  expect_error(mantel_fleiss_crit(tbl, include_value = 1))

  # threshold
  expect_error(mantel_fleiss_crit(tbl, threshold = c(5, 10)))
  expect_error(mantel_fleiss_crit(tbl, threshold = "5"))
  expect_error(mantel_fleiss_crit(tbl, threshold = NA_real_))
  expect_error(mantel_fleiss_crit(tbl, threshold = NaN))
})
