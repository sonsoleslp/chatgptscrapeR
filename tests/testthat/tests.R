

# Mock URL for testing
mock_url <- "https://chatgpt.com/share/c7a912da-5dd3-4e46-9fd7-d777006068ff"
mock_df <- data.frame(names = c("a","b"), urls = c(mock_url, mock_url))
test_that("scrape_chatgpt.character works with valid URL", {
  result <- scrape_chatgpt(mock_url)
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 4)
  expect_true("order" %in% colnames(result))
  expect_true("conversationId" %in% colnames(result))
})

test_that("scrape_chatgpt.character fails with invalid URL", {
  warnings <- capture_warnings({
    result <- scrape_chatgpt("https://mockedchatgpt.com/share/invalid-url")
  })
  expect_true(length(warnings) == 2)
})

test_that("scrape_chatgpt.data.frame works with valid data frame", {
  result <- scrape_chatgpt(mock_df, column = "urls")
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 4)
  print(result)
  expect_true("order" %in% names(result))
  expect_true("conversationId" %in% names(result))
})

test_that("scrape_chatgpt.data.frame fails when column is missing", {
  expect_error(scrape_chatgpt(mock_df),
               "Argument `column` is missing. Specify which column contains the conversation URLs.")
})

test_that("scrape_chatgpt.default handles missing argument", {
  expect_error(scrape_chatgpt(),
               "Argument `x` is missing.")
})

