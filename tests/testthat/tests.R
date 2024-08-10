

# Mock URL for testing
mock_url <- "https://mockedchatgpt.com/share/fake-url"

# Mock data frame
mock_df <- data.frame(urls = c(mock_url, "https://mockedchatgpt.com/share/fake-url2"))

# Mock responses for different scenarios
mock_success_response <- '<script id="__NEXT_DATA__">{"props":{"pageProps":{"serverPrimedAllowBrowserStorageValue":true,"isStorageComplianceEnabled":false,"sharedConversationId":"c7a912da-5dd3-4e46-9fd7-d777006068ff","serverResponse":{"type":"data","data":{"title":"R vs Python Benefits","create_time":1721645250.52733,"update_time":1721645253,"mapping":{"fa6303ee-d7ae-4628-b903-cc3033ab456f":{"id":"fa6303ee-d7ae-4628-b903-cc3033ab456f","message":{"id":"fa6303ee-d7ae-4628-b903-cc3033ab456f","author":{"role":"assistant","metadata":{}},"create_time":1721645248.742851,"content":{"content_type":"text","parts":["Choosing between R and Python often depends on the specific needs and context of a project, as both have their strengths and weaknesses."]},"status":"finished_successfully","end_turn":true,"weight":1,"metadata":{"citations":[],"gizmo_id":null,"finish_details":{"type":"stop","stop_tokens":[200002]},"is_complete":true,"message_type":null,"model_slug":"gpt-4o","default_model_slug":"auto","pad":"AAAAAAAAAAAA","parent_id":"aaa24c32-4d47-4bae-b3e8-4d93dbaf0147","request_id":"8a72d9735a9b8db0-HEL","timestamp_":"absolute","shared_conversation_id":"c7a912da-5dd3-4e46-9fd7-d777006068ff"},"recipient":"all"},"parent":"aaa24c32-4d47-4bae-b3e8-4d93dbaf0147","children":[]},"aaa24c32-4d47-4bae-b3e8-4d93dbaf0147":{"id":"aaa24c32-4d47-4bae-b3e8-4d93dbaf0147","message":{"id":"aaa24c32-4d47-4bae-b3e8-4d93dbaf0147","author":{"role":"user","metadata":{}},"create_time":1721645213.136891,"content":{"content_type":"text","parts":["Why is R better than Python?"]},"status":"finished_successfully","weight":1,"metadata":{"request_id":"8a72d9735a9b8db0-HEL","message_source":null,"timestamp_":"absolute","message_type":null,"shared_conversation_id":"c7a912da-5dd3-4e46-9fd7-d777006068ff"},"recipient":"all"},"parent":"9dcf77af-d68e-4e3c-906f-ec1d7fa420e6","children":["fa6303ee-d7ae-4628-b903-cc3033ab456f"]},"9dcf77af-d68e-4e3c-906f-ec1d7fa420e6":{"id":"9dcf77af-d68e-4e3c-906f-ec1d7fa420e6","message":{"id":"9dcf77af-d68e-4e3c-906f-ec1d7fa420e6","author":{"role":"system","metadata":{}},"content":{"content_type":"text","parts":[""]},"status":"finished_successfully","end_turn":true,"weight":0,"metadata":{"is_visually_hidden_from_conversation":true,"shared_conversation_id":"c7a912da-5dd3-4e46-9fd7-d777006068ff"},"recipient":"all"},"parent":"aaa166af-3257-4cd5-b74c-6964c093b189","children":["aaa24c32-4d47-4bae-b3e8-4d93dbaf0147"]},"aaa166af-3257-4cd5-b74c-6964c093b189":{"id":"aaa166af-3257-4cd5-b74c-6964c093b189","children":["9dcf77af-d68e-4e3c-906f-ec1d7fa420e6"]}},"moderation_results":[],"current_node":"fa6303ee-d7ae-4628-b903-cc3033ab456f","conversation_id":"c7a912da-5dd3-4e46-9fd7-d777006068ff","is_archived":false,"safe_urls":[],"is_public":true,"linear_conversation":[{"id":"aaa166af-3257-4cd5-b74c-6964c093b189","children":["9dcf77af-d68e-4e3c-906f-ec1d7fa420e6"]},{"id":"9dcf77af-d68e-4e3c-906f-ec1d7fa420e6","message":{"id":"9dcf77af-d68e-4e3c-906f-ec1d7fa420e6","author":{"role":"system","metadata":{}},"content":{"content_type":"text","parts":[""]},"status":"finished_successfully","end_turn":true,"weight":0,"metadata":{"is_visually_hidden_from_conversation":true,"shared_conversation_id":"c7a912da-5dd3-4e46-9fd7-d777006068ff"},"recipient":"all"},"parent":"aaa166af-3257-4cd5-b74c-6964c093b189","children":["aaa24c32-4d47-4bae-b3e8-4d93dbaf0147"]},{"id":"aaa24c32-4d47-4bae-b3e8-4d93dbaf0147","message":{"id":"aaa24c32-4d47-4bae-b3e8-4d93dbaf0147","author":{"role":"user","metadata":{}},"create_time":1721645213.136891,"content":{"content_type":"text","parts":["Why is R better than Python?"]},"status":"finished_successfully","weight":1,"metadata":{"request_id":"8a72d9735a9b8db0-HEL","message_source":null,"timestamp_":"absolute","message_type":null,"shared_conversation_id":"c7a912da-5dd3-4e46-9fd7-d777006068ff"},"recipient":"all"},"parent":"9dcf77af-d68e-4e3c-906f-ec1d7fa420e6","children":["fa6303ee-d7ae-4628-b903-cc3033ab456f"]},{"id":"fa6303ee-d7ae-4628-b903-cc3033ab456f","message":{"id":"fa6303ee-d7ae-4628-b903-cc3033ab456f","author":{"role":"assistant","metadata":{}},"create_time":1721645248.742851,"content":{"content_type":"text","parts":["R often proves to be more efficient and effective."]},"status":"finished_successfully","end_turn":true,"weight":1,"metadata":{"citations":[],"gizmo_id":null,"finish_details":{"type":"stop","stop_tokens":[200002]},"is_complete":true,"message_type":null,"model_slug":"gpt-4o","default_model_slug":"auto","pad":"AAAAAAAAAAAA","parent_id":"aaa24c32-4d47-4bae-b3e8-4d93dbaf0147","request_id":"8a72d9735a9b8db0-HEL","timestamp_":"absolute","shared_conversation_id":"c7a912da-5dd3-4e46-9fd7-d777006068ff"},"recipient":"all"},"parent":"aaa24c32-4d47-4bae-b3e8-4d93dbaf0147","children":[]}],"has_user_editable_context":false,"continue_conversation_url":"https://chatgpt.com/share/c7a912da-5dd3-4e46-9fd7-d777006068ff/continue","model":{"slug":"gpt-4o","max_tokens":8192,"title":"GPT-4o","description":"Newest and most advanced model","tags":["gpt4o","gpt4"]},"moderation_state":{"has_been_moderated":false,"has_been_blocked":false,"has_been_accepted":false,"has_been_auto_blocked":false,"has_been_auto_moderated":false},"is_indexable":false}},"continueMode":false,"moderationMode":false,"chatPageProps":{}},"__N_SSP":true},"page":"/share/[[...shareParams]]","query":{"shareParams":["c7a912da-5dd3-4e46-9fd7-d777006068ff"]},"buildId":"IPJLMhEIFEq-k8C5i7-EF","assetPrefix":"https://cdn.oaistatic.com","isFallback":false,"isExperimentalCompile":false,"dynamicIds":[66912],"gssp":true,"scriptLoader":[]}</script>'
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
    expect_is(result, "data.frame")
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
    expect_is(result, "data.frame")
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
