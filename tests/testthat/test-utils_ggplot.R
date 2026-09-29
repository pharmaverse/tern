testthat::test_that("rtable2gg works as expected", {
  dta <- data.frame(
    USUBJID = rep(1:6, each = 3),
    PARAMCD = rep("lab", 6 * 3),
    AVISIT  = rep(paste0("V", 1:3), 6),
    ARM     = rep(LETTERS[1:3], rep(6, 3)),
    AVAL    = c(9:1, rep(NA, 9))
  )

  lyt <- basic_table() |>
    split_cols_by(var = "ARM") |>
    split_rows_by(var = "AVISIT") |>
    analyze_vars(vars = "AVAL")

  tbl <- build_table(lyt, df = dta)

  # defaults
  testthat::expect_silent(rtable2gg_default <- tbl |> rtable2gg())
  expect_snapshot_ggplot("rtable2gg_default", rtable2gg_default, width = 5)

  # custom fontsize
  testthat::expect_silent(rtable2gg_fs <- tbl |> rtable2gg(fontsize = 5))
  expect_snapshot_ggplot("rtable2gg_fs", rtable2gg_fs, width = 5)

  # custom colwidths
  testthat::expect_silent(rtable2gg_cw <- tbl |> rtable2gg(colwidths = c(4, 2, 2, 3)))
  expect_snapshot_ggplot("rtable2gg_cw", rtable2gg_cw, width = 5)

  # custom lbl_col_padding
  testthat::expect_silent(rtable2gg_lblpad <- tbl |> rtable2gg(lbl_col_padding = -5))
  expect_snapshot_ggplot("rtable2gg_lblpad", rtable2gg_lblpad, width = 5)
})

testthat::test_that("rtable2gg works with multiple column splits", {
  dta2 <- data.frame(
    USUBJID = rep(1:6, each = 3),
    PARAMCD = rep("lab", 6 * 3),
    AVISIT  = rep(paste0("V", 1:2), 9),
    ARM     = rep(LETTERS[1:2], rep(9, 2)),
    SEX     = rep(c("M", "F", "M"), 6),
    AVAL    = c(1:15, rep(NA, 3))
  )

  lyt <- basic_table(show_colcounts = TRUE) |>
    split_cols_by(var = "ARM") |>
    split_cols_by(var = "AVISIT") |>
    split_cols_by(var = "SEX") |>
    analyze_vars(vars = "AVAL")

  tbl <- build_table(lyt, df = dta2)

  testthat::expect_silent(rtable2gg_colsplits <- tbl |> rtable2gg())
  expect_snapshot_ggplot("rtable2gg_colsplits", rtable2gg_colsplits, width = 10, height = 3)
})

testthat::test_that("rtable2gg renders spanned header labels without a subscript warning", {
  # Regression test: previously rtable2gg() selected spanned header cells with a
  # logical index one element shorter than the number of columns, which triggered a
  # "length of dimension 2 is not a multiple of logical subscript length" warning
  # under R-devel (an error on CRAN). The warning only fires on R-devel, so we also
  # assert that the spanned header labels are rendered correctly on every R version.
  dta <- data.frame(
    AVISIT = rep(paste0("V", 1:2), 9),
    ARM    = rep(LETTERS[1:2], rep(9, 2)),
    SEX    = rep(c("M", "F", "M"), 6),
    AVAL   = c(1:15, rep(NA, 3))
  )

  lyt <- basic_table(show_colcounts = TRUE) |>
    split_cols_by(var = "ARM") |>
    split_cols_by(var = "AVISIT") |>
    split_cols_by(var = "SEX") |>
    analyze_vars(vars = "AVAL")

  tbl <- build_table(lyt, df = dta)

  testthat::expect_no_warning(gg <- rtable2gg(tbl))

  # Collect all text-annotation labels from the ggplot object.
  labels <- unlist(lapply(gg$layers, function(l) {
    lab <- l$aes_params$label
    if (is.null(lab)) lab <- l$data$label
    lab
  }))

  # Spanned header labels from the ARM and AVISIT column splits must be present.
  testthat::expect_true(all(c("A", "B", "V1", "V2") %in% labels))
})

testthat::test_that("df2gg works as expected", {
  # defaults
  testthat::expect_silent(df2gg_default <- head(iris, 5) |> df2gg())
  expect_snapshot_ggplot("df2gg_default", df2gg_default, width = 5)

  # custom fontsize, background color
  testthat::expect_silent(df2gg_fs <- head(iris, 5) |> df2gg(font_size = 15, bg_fill = "#00000020"))
  expect_snapshot_ggplot("df2gg_fs", df2gg_fs, width = 8)

  # custom colwidths
  testthat::expect_silent(df2gg_cw <- head(iris, 5) |> df2gg(colwidths = c(1, 1, 1, 1, 1)))
  expect_snapshot_ggplot("df2gg_cw", df2gg_cw, width = 5)
})
