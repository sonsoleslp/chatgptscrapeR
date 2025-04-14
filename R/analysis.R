

#' @export
get_keywords <- function(df, col = "message.content.parts", remove_stopwords = TRUE, lang = "en", token = "words", top = NULL) {
  text_data <- df |>
    tidytext::unnest_tokens(word, !!sym(col), token = token)

  if (isTRUE(remove_stopwords)) {
    text_data <- dplyr::anti_join(text_data, tidytext::get_stopwords(language = lang), by = "word")
  }
  text_data <- dplyr::count(text_data, word, sort = TRUE)

  if (!is.null(top)) {
    text_data <- text_data |> dplyr::filter(row_number() <= top)
  }

  text_data
}

#' @export
wordcloud <- function(x) {
  wordcloud2::wordcloud2(x, size = 1)
}

#' @export
sentiments <- function(x, col  = "message.content.parts", source = "bing") {
  sentiments <- tidytext::get_sentiments(source)
  y <- NULL
  if (source == "afinn") {
    y <- dplyr::left_join(x,
    x |> group_by(conversationId, order) |>
      get_keywords() |>
      dplyr::inner_join(sentiments, by = "word") |>
      dplyr::group_by(conversationId, order) |>
      dplyr::summarize(Sentiment = sum(value)/n()) ,
    by = c("conversationId","order"))
  } else if (source == "bing") {
    y <- dplyr::left_join(x,
    x |> group_by(conversationId, order) |>
      get_keywords() |>
      dplyr::inner_join(sentiments, by = "word") |>
      dplyr::group_by(conversationId, order, sentiment) |>
      dplyr::summarize(n = sum(n), length = n_distinct(word)) |>
      dplyr::ungroup() |>
      dplyr::mutate(n = ifelse(sentiment == "positive",n,-n)) |>
      dplyr::group_by(conversationId, order) |>
      dplyr::summarize(Sentiment = sum(n) / sum(length)),
    by = c("conversationId","order"))

  } else if (source == "nrc") {
    y <- dplyr::left_join(x,
                          x |> group_by(conversationId, order) |>
                            get_keywords() |>
                            dplyr::inner_join(sentiments, by = "word") |>
                            dplyr::group_by(conversationId, order) |>
                            dplyr::mutate(n = n/n()) |>
                            tidyr::pivot_wider(names_from = "sentiment",
                                               values_from = n,
                                               values_fn = sum,
                                               values_fill = 0,
                                               id_cols = c("conversationId", "order")),
                          by = c("conversationId","order"))
  }
  y
}

#' @export
plot_sentiments <- function(x, case_id = "conversationId") {
  stopifnot_(!missing(x), "Argument {.arg x} is missing.")
  stopifnot_(case_id %in% names(x), "Argument {.arg case_id} is not in {.arg x} names")

  if ("Sentiment" %in% names(x)) {
    if (any(x$Sentiment < 0)){
      print(plot_sentiment(x, "afinn", case_id = case_id))
    } else {
      print(plot_sentiment(x, "bing", case_id = case_id))
    }

  } else {
    for(i in c('anger', 'anticipation', 'disgust', 'fear', 'joy',
               'negative', 'positive', 'sadness', 'surprise', 'trust')) {
      if (i %in% names(x)) {
        print(plot_sentiment(dplyr::rename(x, Sentiment = i), "nrc", case_id = case_id, label = i))
      }
    }
  }
}

plot_sentiment <- function(x, source, case_id = "conversationId", label = "Sentiment") {
  if(source == "nrc") {
    color_scale <- ggplot2::scale_fill_gradient2(low = "white", midpoint = 0.05,
                                                 high = "purple", limits = c(0,1))
  } else {
    if(source == "bing"){limits <- c(-1,1)} else {limits <- c(-5,5)}
    color_scale <- ggplot2::scale_fill_gradient2(low = "red", mid = "yellow",
                                                 high = "green",
                                                 limits = limits)
  }
  y <- ggplot2::ggplot(x, ggplot2::aes(x = order, y = !!sym(case_id), fill = Sentiment)) +
    ggplot2::geom_tile( linewidth = .5, color = "black") +
    color_scale +
    ggplot2::theme_minimal() +
    ggplot2::theme_bw() +
    ggplot2::theme(legend.position = "bottom",
                   panel.border = ggplot2::element_blank(),
                   axis.ticks =  ggplot2::element_line(),
                   axis.line.x = ggplot2::element_line(),
                   panel.grid = ggplot2::element_blank()
    ) +
    ggplot2::labs(fill = label) +
    ggplot2::coord_equal(ratio = 1, expand = F) +
    ggplot2::ylab("") +
    ggplot2::xlab("")

  y
}


