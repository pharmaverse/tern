test_that("h_prepare_2x2_table() works without strata", {
  set.seed(123)
  n <- 100
  data <- data.frame(
    rsp = sample(c(TRUE, FALSE), n, replace = TRUE),
    grp = factor(sample(c("Placebo", "X"), n, replace = TRUE))
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      val = TRUE
    )
  )

  grp_ref <- which(data$grp == "Placebo")
  grp_nonref <- which(data$grp == "X")

  expected <- list(
    rsp = data[c(grp_nonref, grp_ref), 1],
    grp = factor(
      c(rep("Not-ref", length(grp_nonref)), rep("ref", length(grp_ref))),
      levels = c("ref", "Not-ref")
    ),
    strata = NULL,
    tbl = as.table(array(
      c(26L, 31L, 20L, 23L),
      dim = c(2L, 2L),
      dimnames = list(grp = c("ref", "Not-ref"), rsp = c("TRUE", "FALSE"))
    ))
  )

  expect_identical(result, expected)
})

test_that("h_prepare_2x2_table() works with strata", {
  set.seed(123)
  n <- 100
  data <- data.frame(
    rsp = sample(c(TRUE, FALSE), n, replace = TRUE),
    grp = factor(sample(c("Placebo", "X"), n, replace = TRUE)),
    strata = factor(sample(LETTERS[1:4], n, replace = TRUE))
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      val = TRUE,
      strata_vars = "strata"
    )
  )

  grp_ref <- which(data$grp == "Placebo")
  grp_nonref <- which(data$grp == "X")

  expected <- list(
    rsp = data[c(grp_nonref, grp_ref), "rsp"],
    grp = factor(
      c(rep("Not-ref", length(grp_nonref)), rep("ref", length(grp_ref))),
      levels = c("ref", "Not-ref")
    ),
    strata = factor(data[c(grp_nonref, grp_ref), "strata"]),
    tbl = as.table(array(
      c(6L, 9L, 9L, 8L, 8L, 6L, 5L, 5L, 5L, 5L, 4L, 5L, 7L, 11L, 2L, 5L),
      dim = c(2, 2, 4),
      dimnames = list(grp = c("ref", "Not-ref"), rsp = c("TRUE", "FALSE"), strata = LETTERS[1:4])
    ))
  )

  expect_identical(result, expected)
})
