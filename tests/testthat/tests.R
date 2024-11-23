

# Mock URL for testing
mock_url <- "https://mockedchatgpt.com/share/fake-url"

# Mock data frame
mock_df <- data.frame(urls = c(mock_url, "https://mockedchatgpt.com/share/fake-url2"))

# Mock responses for different scenarios
mock_success_response <-  paste(readLines("./22.html"), collapse="\n")
mock_fail_response <- '<html><body>No data here</body></html>'

# Mocking httr::GET and httr::content functions
mock_GET <- function(url) {
  list(status_code = if (url == mock_url) 200 else 404)
}

mock_content <- function(response, as = "text") {
  if (response$status_code == 200) {
    return(mock_success_response)
  } else {
    return(mock_fail_response)
  }
}

with_mock(
  `httr::GET` = mock_GET,
  `httr::content` = mock_content,

  test_that("scrape_chatgpt.character works with valid URL", {
    result <- scrape_chatgpt(mock_url)
    expect_s3_class(result, "data.frame")
    expect_equal(nrow(result), 4)
    expect_true("order" %in% colnames(result))
    expect_true("conversationId" %in% colnames(result))
  }),

  test_that("scrape_chatgpt.character fails with invalid URL", {
    warnings <- capture_warnings({
      result <- scrape_chatgpt("https://mockedchatgpt.com/share/invalid-url")
    })
    expect_true(length(warnings) == 2)
  }),

  test_that("scrape_chatgpt.data.frame works with valid data frame", {
    result <- scrape_chatgpt(mock_df, column = "urls")
    expect_s3_class(result, "data.frame")
    expect_equal(nrow(result), 4)
    print(result)
    expect_true("order" %in% names(result))
    expect_true("conversationId" %in% names(result))
  }),

  test_that("scrape_chatgpt.data.frame fails when column is missing", {
    expect_error(scrape_chatgpt(mock_df),
                 "Argument `column` is missing. Specify which column contains the conversation URLs.")
  }),

  test_that("scrape_chatgpt.default handles missing argument", {
    expect_error(scrape_chatgpt(),
                 "Argument `x` is missing.")
  })
)
