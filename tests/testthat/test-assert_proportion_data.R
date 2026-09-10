test_that("assert_proportion_data() accepts valid data", {
  rsp <- c(TRUE, FALSE, TRUE, FALSE)
  grp <- factor(c("Active", "Active", "Control", "Control"))
  strata <- factor(c("A", "A", "B", "B"))

  expect_silent(
    result <- assert_proportion_data(rsp, grp)
  )
  expect_silent(
    result_strata <- assert_proportion_data(rsp, grp, strata)
  )
  expect_null(result)
  expect_null(result_strata)
})

test_that("assert_proportion_data() accepts a single stratum", {
  rsp <- c(TRUE, FALSE, TRUE, FALSE)
  grp <- factor(c("X", "X", "Placebo", "Placebo"))
  strata <- factor(rep("S1", 4))

  expect_silent(
    result <- assert_proportion_data(rsp, grp, strata)
  )
  expect_null(result)
})

test_that("assert_proportion_data() accepts empty data with an unused stratum level", {
  grp <- factor(levels = c("Placebo", "X"))
  strata <- factor(levels = "S1")

  expect_silent(
    result <- assert_proportion_data(logical(), grp)
  )
  expect_silent(
    result_strata <- assert_proportion_data(logical(), grp, strata)
  )
  expect_null(result)
  expect_null(result_strata)
})

test_that("assert_proportion_data() accepts empty data with no strata levels", {
  grp <- factor(levels = c("Placebo", "X"))

  expect_silent(
    result <- assert_proportion_data(logical(), grp)
  )
  expect_silent(
    result_strata <- assert_proportion_data(logical(), grp, factor())
  )
  expect_null(result)
  expect_null(result_strata)
})

test_that("assert_proportion_data() accepts empty data without strata", {
  expect_silent(
    result <- assert_proportion_data(logical(), factor(levels = c("Placebo", "X")))
  )

  expect_null(result)
})

test_that("assert_proportion_data() accepts a single observed response outcome", {
  grp <- factor(c("X", "X", "Placebo"))

  # FALSE only
  expect_silent(assert_proportion_data(rep(FALSE, 3), grp))
  expect_null(assert_proportion_data(rep(FALSE, 3), grp))

  # TRUE only
  expect_silent(assert_proportion_data(rep(TRUE, 3), grp))
  expect_null(assert_proportion_data(rep(TRUE, 3), grp))
})

test_that("assert_proportion_data() accepts unobserved group levels", {
  rsp <- c(TRUE, FALSE, TRUE, FALSE)
  grp <- factor(rep("X", 4), levels = c("Placebo", "X"))

  expect_silent(assert_proportion_data(rsp, grp))
  expect_null(assert_proportion_data(rsp, grp))
})

test_that("assert_proportion_data() validates rsp", {
  rsp <- c(TRUE, FALSE, TRUE, FALSE)
  grp <- factor(c("Active", "Active", "Control", "Control"))

  expect_error(assert_proportion_data(as.character(rsp), grp))
  expect_error(assert_proportion_data(as.numeric(rsp), grp))
  expect_error(assert_proportion_data(c(rsp[-1], NA), grp))
})

test_that("assert_proportion_data() validates grp", {
  rsp <- c(TRUE, FALSE, TRUE, FALSE)
  grp <- c("Active", "Active", "Control", "Control")

  expect_error(assert_proportion_data(rsp, grp))
  expect_error(assert_proportion_data(rsp, c(1, 1, 2, 2)))
  expect_error(assert_proportion_data(rsp, factor(rep("Active", 4))))
  expect_error(assert_proportion_data(rsp, factor(c("X", "X", "P"), levels = c("X", "P", "O"))))
  expect_error(assert_proportion_data(rsp, factor(grp[-1])))
  expect_error(assert_proportion_data(rsp, factor(c(NA, grp[-1]))))
})

test_that("assert_proportion_data() validates strata", {
  rsp <- c(TRUE, FALSE, TRUE, FALSE)
  grp <- factor(c("Active", "Active", "Control", "Control"))
  strata <- c("A", "A", "B", "B")

  expect_error(assert_proportion_data(rsp, grp, strata))
  expect_error(assert_proportion_data(rsp, grp, c(1, 1, 2, 2)))
  expect_error(assert_proportion_data(rsp, grp, strata[-1]))
  expect_error(assert_proportion_data(rsp, grp, c(strata[-1], NA)))
})
