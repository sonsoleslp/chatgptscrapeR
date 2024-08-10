#' Scrape ChatGPT Conversations
#'
#' A generic function to scrape ChatGPT conversations from a provided URL or data frame.
#'
#' @export
#' @rdname scrape_chatgpt
#' @param x A URL or data frame containing URLs to scrape.
#' @param ... Additional arguments passed to specific methods.
#' @return A `data.frame` with the scraped conversation data.
#' @examples
#' scrape_chatgpt("https://chatgpt.com/share/b96f65e6-80c2-4c8b-940b-c9a98e048d95")
#'
scrape_chatgpt <-  function(x, ...) {
  UseMethod("scrape_chatgpt")
}


#' @export
#' @rdname scrape_chatgpt
scrape_chatgpt.default <- function(x, ...) {
  stopifnot_(!missing(x), "Argument {.arg x} is missing.")
  scrape_chatgpt_(x)
}


#' @export
#' @rdname scrape_chatgpt
scrape_chatgpt.character <- function(x, ...) {
  stopifnot_(!missing(x), "Argument {.arg x} is missing.")
  x <- try_(as.vector(x))
  stopifnot_(!inherits(x, "try-error"), "Argument {.arg x} must be coercible to a {.cls vector}.")

  scrape_chatgpt_(x)
}


#' @exportS3Method
#' @rdname scrape_chatgpt
scrape_chatgpt.data.frame <- function(x, column, ...) {
  stopifnot_(!missing(x), "Argument {.arg x} is missing.")
  stopifnot_(!missing(column), "Argument {.arg column} is missing. Specify which column contains the conversation URLs.")

  df <- dplyr::mutate(x, res = purrr::map(!!dplyr::sym(column), scrape_chatgpt_)) |>
    tidyr::unnest(res) |> data.frame()

  return(df)
}


#' Scrape ChatGPT Conversation Helper Function
#'
#' A helper function to scrape ChatGPT conversations from a single URL.
#'
#' @param x A URL to scrape.
#' @return A data.frame with the scraped conversation data.
#' @noRd
scrape_chatgpt_ <- function(x) {
  messages_df <- data.frame()
  failed <- c()
  for(i in c(x)) {
    # Get the HTML content from the URL
    response <- httr::GET(i)

    if (response$status_code != 200) {
      warning_(paste("Failed to retrieve data from URL:", i))
      failed <- c(failed, i)
      next
    }

    content <- httr::content(response, as = "text")

    # Parse the HTML content
    webpage <- xml2::read_html(content)

    # Extract the JSON data from the <script> tag
    json_data <- xml2::xml_find_first(webpage, "//script[@id='__NEXT_DATA__']")
    if (is.null(json_data)) {
      warning_(paste("No JSON data found in the script tag at URL:", i))
      failed <- c(failed, i)
      next
    }
    json_text <- xml2::xml_text(json_data)

    # Parse the JSON data
    json_parsed <- tryCatch({
      jsonlite::fromJSON(json_text, flatten = TRUE)
    }, error = function(e) {
      warning_(paste("Failed to parse JSON data at URL:", i))
      failed <- c(failed, i)
      return(NULL)
    })

    if (is.null(json_parsed)) {
      warning_(paste("Failed to parse JSON data at URL:", i))
      failed <- c(failed, i)
      next
    }

    # Navigate through the JSON structure to get the conversation data
    if (!"props" %in% names(json_parsed) || !"pageProps" %in% names(json_parsed$props) ||
        !"serverResponse" %in% names(json_parsed$props$pageProps) ||
        !"data" %in% names(json_parsed$props$pageProps$serverResponse) ||
        !"linear_conversation" %in% names(json_parsed$props$pageProps$serverResponse$data)) {
      warning_(paste("Invalid JSON structure at URL:", i))
      failed <- c(failed, i)
      next
    }

    messages <- json_parsed$props$pageProps$serverResponse$data$linear_conversation |>
      dplyr::rowwise() |>
      dplyr::mutate_at(dplyr::vars(children,
                                   message.content.parts,
                                   message.metadata.citations,
                                   message.metadata.finish_details.stop_tokens),
                       \(x) paste(x, collapse = "\n")) |>
      dplyr::ungroup() |>
      dplyr::mutate(order = cumsum(!is.na(message.create_time))) |>
      dplyr::mutate(order = ifelse(is.na(message.create_time), NA, order),
                    conversationId = json_parsed$props$pageProps$sharedConversationId,
                    title = json_parsed$props$pageProps$serverResponse$data$title,
                    create_time = json_parsed$props$pageProps$serverResponse$data$create_time,
                    update_time = json_parsed$props$pageProps$serverResponse$data$update_time
      )
    messages_df <- dplyr::bind_rows(messages_df, messages)
  }

  if(length(failed) > 0) {
    warning_(paste("\nThe following URLs failed to parse: ", paste(failed, collapse = ", ")))
  }
  return(messages_df)
}
