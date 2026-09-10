test_that("get_complete_cases() returns data unchanged when there are no missing values", {
  df <- data.frame(a = 1:3, b = letters[1:3])

  expect_identical(get_complete_cases(df), df)
})

test_that("get_complete_cases() removes rows with missing values in one column", {
  df <- data.frame(a = c(1, NA, 3), b = letters[1:3])

  expect_warning(
    result <- get_complete_cases(df),
    "1.*omitted"
  )

  expect_identical(
    result,
    data.frame(a = c(1, 3), b = c("a", "c"), row.names = c(1L, 3L))
  )
})

test_that("get_complete_cases() removes rows with missing values in multiple columns", {
  df <- data.frame(
    a = c(1, NA, 3, NA, 6),
    b = c("a", "b", NA, "d", "k"),
    c = c(NA, 2, 3, 4, 3)
  )

  expect_warning(
    result <- get_complete_cases(df),
    "4.*omitted"
  )

  expect_identical(
    result,
    data.frame(a = 6, b = "k", c = 3, row.names = 5L)
  )
})

test_that("get_complete_cases() preserves data.frame structure with one column", {
  df <- data.frame(a = c(1, NA, 3))

  expect_warning(
    result <- get_complete_cases(df),
    "1.*omitted"
  )

  expect_identical(
    result,
    data.frame(a = c(1, 3), row.names = c(1L, 3L))
  )
})

test_that("get_complete_cases() removes all rows when every row contains missing values", {
  df <- data.frame(a = c(1, NA, 3), b = c(NA, "b", NA))

  expect_warning(
    result <- get_complete_cases(df),
    "3.*omitted"
  )

  expect_identical(result, df[0, , drop = FALSE])
})

test_that("get_complete_cases() handles data.frame with no rows", {
  df <- data.frame(a = integer(), b = character())

  expect_identical(get_complete_cases(df), df)
})

test_that("get_complete_cases() appends additional message to warning", {
  df <- data.frame(a = c(1, NA, 3), b = letters[1:3])

  expect_warning(
    result <- get_complete_cases(
      df,
      additional_message = "Please check the input data."
    ),
    "1.*omitted.*Please check the input data\\."
  )

  expect_identical(
    result,
    data.frame(a = c(1, 3), b = c("a", "c"), row.names = c(1L, 3L))
  )
})

test_that("get_complete_cases() suppresses warning when quiet is TRUE", {
  df <- data.frame(a = c(1, NA, 3), b = letters[1:3])

  expect_no_warning(
    result <- get_complete_cases(df, TRUE)
  )

  expect_identical(
    result,
    data.frame(a = c(1, 3), b = c("a", "c"), row.names = c(1L, 3L))
  )
})
