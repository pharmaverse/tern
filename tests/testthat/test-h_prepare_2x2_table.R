test_that("h_prepare_2x2_table() works without strata", {
  set.seed(123)
  n <- 100
  data <- data.frame(
    rsp = sample(c(TRUE, FALSE), n, replace = TRUE),
    grp = sample(c("Placebo", "X"), n, replace = TRUE)
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp"
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
    grp = sample(c("Placebo", "X"), n, replace = TRUE),
    strata = factor(sample(LETTERS[1:4], n, replace = TRUE))
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
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

test_that("h_prepare_2x2_table() works with multiple strata variables", {
  set.seed(123)
  n <- 100
  data <- data.frame(
    rsp = sample(c(TRUE, FALSE), n, replace = TRUE),
    grp = sample(c("Placebo", "X"), n, replace = TRUE),
    strata_1 = factor(sample(LETTERS[1:4], n, replace = TRUE)),
    strata_2 = factor(sample(letters[1:2], n, replace = TRUE))
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = c("strata_1", "strata_2")
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
    strata = interaction(data[c(grp_nonref, grp_ref), c("strata_1", "strata_2")]),
    tbl = as.table(array(
      c(
        5L, 5L, 3L, 4L, 4L, 4L, 2L, 2L,
        3L, 3L, 2L, 4L, 4L, 7L, 1L, 4L,
        1L, 4L, 6L, 4L, 4L, 2L, 3L, 3L,
        2L, 2L, 2L, 1L, 3L, 4L, 1L, 1L
      ),
      dim = c(2L, 2L, 8L),
      dimnames = list(
        grp = c("ref", "Not-ref"),
        rsp = c("TRUE", "FALSE"),
        strata = c("A.a", "B.a", "C.a", "D.a", "A.b", "B.b", "C.b", "D.b")
      )
    ))
  )

  expect_identical(result, expected)
})

test_that("h_prepare_2x2_table() handles a custom val", {
  data <- data.frame(
    rsp = c("RES", "NORES", "RES", "RES", "NORES", "NORES"),
    grp = c("Placebo", "X", "Placebo", "X", "X", "X"),
    strata = factor(c("S1", "S2", "S1", "S2", "S2", "S1"))
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      val = "RES",
      strata_vars = NULL
    )
  )

  expect_silent(
    result_strata <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      val = "RES",
      strata_vars = "strata"
    )
  )

  # Expected.
  rsp <- c(FALSE, TRUE, FALSE, FALSE, TRUE, TRUE)
  grp <- factor(c(rep("Not-ref", 4L), "ref", "ref"), levels = c("ref", "Not-ref"))
  strata <- factor(c("S2", "S2", "S2", "S1", "S1", "S1"), levels = c("S1", "S2"))
  tbl <- table(grp, rsp = factor(rsp, levels = c("TRUE", "FALSE")), strata = strata)
  expected <- list(rsp = rsp, grp = grp, strata = NULL, tbl = margin.table(tbl, 1:2))
  expected_strata <- list(rsp = rsp, grp = grp, strata = strata, tbl = tbl)

  expect_identical(result, expected)
  expect_identical(result_strata, expected_strata)
})

test_that("h_prepare_2x2_table() gives the same result with one stratum", {
  set.seed(123)
  n <- 20
  data <- data.frame(
    rsp = sample(c(TRUE, FALSE), n, replace = TRUE),
    grp = sample(c("Active", "Control"), n, replace = TRUE),
    strata = factor(rep("A", n))
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "Active"),
      df_ref = subset(data, grp == "Control"),
      var = "rsp",
      strata_vars = NULL
    )
  )

  expect_silent(
    result_1stratum <- h_prepare_2x2_table(
      df = subset(data, grp == "Active"),
      df_ref = subset(data, grp == "Control"),
      var = "rsp",
      strata_vars = "strata"
    )
  )

  expect_identical(result[c("rsp", "grp")], result_1stratum[c("rsp", "grp")])
  expect_identical(result$tbl, result_1stratum$tbl[, , 1])
})

test_that("h_prepare_2x2_table() retains unobserved response outcomes (TRUE only)", {
  data <- data.frame(
    rsp = rep(TRUE, 4),
    grp = c("Placebo", "X", "Placebo", "X"),
    strata = factor(c("S1", "S2", "S1", "S2"))
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = NULL
    )
  )

  expect_silent(
    result_strata <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = "strata"
    )
  )

  # Expected.
  rsp <- c(TRUE, TRUE, TRUE, TRUE)
  grp <- factor(c("Not-ref", "Not-ref", "ref", "ref"), levels = c("ref", "Not-ref"))
  strata <- factor(c("S2", "S2", "S1", "S1"), levels = c("S1", "S2"))
  tbl <- table(grp, rsp = factor(rsp, levels = c("TRUE", "FALSE")), strata = strata)
  expected <- list(rsp = rsp, grp = grp, strata = NULL, tbl = margin.table(tbl, 1:2))
  expected_strata <- list(rsp = rsp, grp = grp, strata = strata, tbl = tbl)

  expect_identical(result, expected)
  expect_identical(result_strata, expected_strata)
})

test_that("h_prepare_2x2_table() retains unobserved response outcomes (FALSE only)", {
  data <- data.frame(
    rsp = rep(FALSE, 4),
    grp = c("Placebo", "X", "Placebo", "X"),
    strata = factor(c("S1", "S2", "S1", "S2"))
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = NULL
    )
  )

  expect_silent(
    result_strata <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = "strata"
    )
  )

  # Expected.
  rsp <- c(FALSE, FALSE, FALSE, FALSE)
  grp <- factor(c("Not-ref", "Not-ref", "ref", "ref"), levels = c("ref", "Not-ref"))
  strata <- factor(c("S2", "S2", "S1", "S1"), levels = c("S1", "S2"))
  tbl <- table(grp, rsp = factor(rsp, levels = c("TRUE", "FALSE")), strata = strata)
  expected <- list(rsp = rsp, grp = grp, strata = NULL, tbl = margin.table(tbl, 1:2))
  expected_strata <- list(rsp = rsp, grp = grp, strata = strata, tbl = tbl)

  expect_identical(result, expected)
  expect_identical(result_strata, expected_strata)
})

test_that("h_prepare_2x2_table() handles empty and NULL df_ref", {
  data <- data.frame(
    rsp = c(TRUE, FALSE, TRUE, FALSE),
    grp = rep("X", 4),
    strata = factor(c("S1", "S2", "S2", "S1"))
  )

  # Empty df_ref.
  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = NULL
    )
  )
  expect_silent(
    result_strata <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = "strata"
    )
  )

  # df_ref is NULL.
  expect_silent(
    result_dfref_null <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = NULL,
      var = "rsp",
      strata_vars = NULL
    )
  )
  expect_silent(
    result_dfref_null_strata <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = NULL,
      var = "rsp",
      strata_vars = "strata"
    )
  )

  # Expected.
  rsp <- data$rsp
  grp <- factor(rep("Not-ref", 4L), levels = c("ref", "Not-ref"))
  strata <- data$strata
  tbl <- table(grp, rsp = factor(rsp, levels = c("TRUE", "FALSE")), strata = strata)
  expected <- list(rsp = rsp, grp = grp, strata = NULL, tbl = margin.table(tbl, 1:2))
  expected_strata <- list(rsp = rsp, grp = grp, strata = strata, tbl = tbl)

  expect_identical(result, expected)
  expect_identical(result_strata, expected_strata)

  expect_identical(result, result_dfref_null)
  expect_identical(result_strata, result_dfref_null_strata)
})


test_that("h_prepare_2x2_table() retains unused strata levels", {
  data <- data.frame(
    rsp = c(TRUE, FALSE, TRUE, FALSE),
    grp = c("X", "X", "Placebo", "Placebo"),
    strata = factor(c("A", "A", "B", "B"), levels = c("A", "B", "Z"))
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = NULL
    )
  )

  expect_silent(
    result_strata <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = "strata"
    )
  )

  # Expected.
  rsp <- data$rsp
  grp <- factor(c("Not-ref", "Not-ref", "ref", "ref"), levels = c("ref", "Not-ref"))
  strata <- data$strata
  tbl <- table(grp, rsp = factor(rsp, levels = c("TRUE", "FALSE")), strata = strata)
  expected <- list(rsp = rsp, grp = grp, strata = NULL, tbl = margin.table(tbl, 1:2))
  expected_strata <- list(rsp = rsp, grp = grp, strata = strata, tbl = tbl)

  expect_identical(result, expected)
  expect_identical(result_strata, expected_strata)
})

test_that("h_prepare_2x2_table() handles sparse contingency tables", {
  data <- data.frame(
    rsp = c(TRUE, TRUE, TRUE, TRUE),
    grp = c("Y", "Y", "Cntrl", "Cntrl"),
    strata = factor(c("A", "A", "B", "B"))
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "Y"),
      df_ref = subset(data, grp == "Cntrl"),
      var = "rsp",
      strata_vars = "strata"
    )
  )

  # Expected.
  rsp <- data$rsp
  grp <- factor(c("Not-ref", "Not-ref", "ref", "ref"), levels = c("ref", "Not-ref"))
  strata <- data$strata
  tbl <- table(grp, rsp = factor(rsp, levels = c("TRUE", "FALSE")), strata = strata)
  expected <- list(rsp = rsp, grp = grp, strata = strata, tbl = tbl)

  expect_identical(result, expected)
})

test_that("h_prepare_2x2_table() handles empty data with an unused stratum level", {
  data <- data.frame(
    rsp = logical(),
    grp = character(),
    strata = factor(levels = "S1")
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = NULL
    )
  )

  expect_silent(
    result_strata <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = "strata"
    )
  )

  # Expected.
  rsp <- data$rsp
  grp <- factor(levels = c("ref", "Not-ref"))
  strata <- data$strata
  tbl <- table(grp, rsp = factor(rsp, levels = c("TRUE", "FALSE")), strata = strata)
  expected <- list(rsp = rsp, grp = grp, strata = NULL, tbl = margin.table(tbl, 1:2))
  expected_strata <- list(rsp = rsp, grp = grp, strata = strata, tbl = tbl)

  expect_identical(result, expected)
  expect_identical(result_strata, expected_strata)
})


test_that("h_prepare_2x2_table() handles empty data with no stratum levels", {
  data <- data.frame(
    rsp = logical(),
    grp = character(),
    strata = factor()
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "Y"),
      df_ref = subset(data, grp == "Cntrl"),
      var = "rsp",
      strata_vars = "strata"
    )
  )

  # Expected.
  rsp <- data$rsp
  grp <- factor(levels = c("ref", "Not-ref"))
  strata <- data$strata
  tbl <- table(grp, rsp = factor(rsp, levels = c("TRUE", "FALSE")), strata = strata)
  expected <- list(rsp = rsp, grp = grp, strata = strata, tbl = tbl)

  expect_identical(result, expected)
})

test_that("h_prepare_2x2_table() handles empty data without strata", {
  data <- data.frame(
    rsp = logical(),
    grp = character()
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "Y"),
      df_ref = subset(data, grp == "Cntrl"),
      var = "rsp",
      strata_vars = NULL
    )
  )

  # Expected.
  rsp <- data$rsp
  grp <- factor(levels = c("ref", "Not-ref"))
  tbl <- table(grp, rsp = factor(rsp, levels = c("TRUE", "FALSE")))
  expected <- list(rsp = rsp, grp = grp, strata = NULL, tbl = tbl)

  expect_identical(result, expected)
})

testthat::test_that("h_prepare_2x2_table() removes incomplete cases", {
  data <- data.frame(
    rsp = c(TRUE, NA, FALSE, TRUE, NA, FALSE),
    grp = factor(c("X", "X", "X", "Placebo", "Placebo", "Placebo")),
    strata = factor(c("S1", "S1", NA, "S1", "S2", "S2"))
  )

  expect_silent(
    result_quiet <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = "strata",
      complete_cases = TRUE,
      quiet = TRUE
    )
  )

  rsp <- c(TRUE, TRUE, FALSE)
  grp <- factor(c("Not-ref", "ref", "ref"), levels = c("ref", "Not-ref"))
  strata <- factor(c("S1", "S1", "S2"), levels = c("S1", "S2"))
  tbl <- table(grp, rsp = factor(rsp, levels = c("TRUE", "FALSE")), strata = strata)
  expected <- list(rsp = rsp, grp = grp, strata = strata, tbl = tbl)

  expect_identical(result_quiet, expected)
})

testthat::test_that("h_prepare_2x2_table() removes incomplete cases without strata", {
  data <- data.frame(
    rsp = c(TRUE, NA, FALSE, TRUE, NA, FALSE),
    grp = factor(c(NA, "X", "X", "Placebo", "Placebo", "Placebo")),
    strata = factor(c("S1", "S1", NA, "S1", NA, "S2"))
  )

  expect_silent(
    result <- h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      complete_cases = TRUE,
      quiet = TRUE
    )
  )

  rsp <- c(FALSE, TRUE, FALSE)
  grp <- factor(c("Not-ref", "ref", "ref"), levels = c("ref", "Not-ref"))
  tbl <- table(grp, rsp = factor(rsp, levels = c("TRUE", "FALSE")))
  expected <- list(rsp = rsp, grp = grp, strata = NULL, tbl = tbl)

  expect_identical(result, expected)
})

testthat::test_that("h_prepare_2x2_table() warns when NAs are removed and quiet = FALSE", {
  data <- data.frame(
    rsp = c(TRUE, NA, FALSE, TRUE, NA, FALSE),
    grp = factor(c("X", "X", "X", "Placebo", "Placebo", "Placebo")),
    strata = factor(c("S1", "S1", NA, "S1", "S2", "S2"))
  )

  # expect_snapshot() captures warnings.
  expect_snapshot(
    h_prepare_2x2_table(
      df = subset(data, grp == "X"),
      df_ref = subset(data, grp == "Placebo"),
      var = "rsp",
      strata_vars = "strata",
      complete_cases = TRUE,
      quiet = FALSE
    )
  )

  data_no_missing <- data.frame(
    rsp = c(TRUE, TRUE, FALSE, TRUE, TRUE, FALSE),
    grp = factor(c("X", "X", "X", "Placebo", "Placebo", "Placebo")),
    strata = factor(c("S1", "S1", "S2", "S1", "S2", "S2"))
  )

  expect_silent(
    h_prepare_2x2_table(
      df = subset(data_no_missing, grp == "X"),
      df_ref = subset(data_no_missing, grp == "Placebo"),
      var = "rsp",
      strata_vars = "strata",
      complete_cases = TRUE,
      quiet = FALSE
    )
  )
})

test_that("h_prepare_2x2_table() validates that var exists in df and df_ref", {
  data <- data.frame(
    rsp = c(TRUE, FALSE, TRUE, FALSE),
    grp = factor(c("G1", "G1", "G2", "G2")),
    strata = factor(c("A", "A", "B", "B"))
  )

  expect_error(
    h_prepare_2x2_table(
      df = subset(data, grp == "G1"),
      df_ref = subset(data, grp == "G2"),
      var = "wrong_var"
    ),
    "var"
  )
})

test_that("h_prepare_2x2_table() validates strata_vars in df and df_ref", {
  data <- data.frame(
    rsp = c(TRUE, FALSE, TRUE, FALSE),
    grp = factor(c("G1", "G1", "G2", "G2")),
    strata = factor(c("A", "A", "B", "B"))
  )

  expect_error(
    h_prepare_2x2_table(
      df = subset(data, grp == "G1"),
      df_ref = subset(data, grp == "G2"),
      var = "rsp",
      strata_vars = "wrong_strata"
    ),
    "strata_vars"
  )

  data$strata <- as.character(data$strata)

  expect_error(
    h_prepare_2x2_table(
      df = subset(data, grp == "G1"),
      df_ref = subset(data, grp == "G2"),
      var = "rsp",
      strata_vars = "strata"
    ),
    "strata_vars.*factor"
  )
})

test_that("h_prepare_2x2_table() validates val", {
  data <- data.frame(
    rsp = c(1L, 0L, 1L, 1L),
    grp = c("G1", "G1", "G2", "G2"),
    strata = factor(c("A", "A", "B", "B"))
  )

  expect_error(
    h_prepare_2x2_table(
      df = subset(data, grp == "G1"),
      df_ref = subset(data, grp == "G2"),
      var = "rsp",
      val = 1L,
      strata_vars = "strata"
    ),
    "val"
  )
})

testthat::test_that("h_prepare_2x2_table() validates complete_cases and quiet", {
  data <- data.frame(
    rsp = c(TRUE, FALSE),
    grp = factor(c("G1", "G2"))
  )

  expect_error(
    h_prepare_2x2_table(
      df = subset(data, grp == "G1"),
      df_ref = subset(data, grp == "G2"),
      var = "rsp",
      complete_cases = 1
    ),
    "complete_cases"
  )

  expect_error(
    h_prepare_2x2_table(
      df = subset(data, grp == "G1"),
      df_ref = subset(data, grp == "G2"),
      var = "rsp",
      quiet = 1
    ),
    "quiet"
  )
})
