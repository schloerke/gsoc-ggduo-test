

#' Background colored correlation plot of two columns of data
#'
#' Display the correlation of the given data and
#'
#' @param data data set using
#' @param mapping aesthetics being used. Must contain 'x' and 'y'. 'color' will be ignored
#' @param color color of main text. Default = "black"
#' @param size ggplot2 size of main text. Default = 6
#' @param pallete should be a character string that matches a RColorBrewer color pallete
#' @param breaks can be a vector of breaks points between -1 and 1.  If a single numeric number, will set breaks with that many groups
#' @param ... other arguments being supplied to ggally_text
#' @param method \code{method} suppied to cor function
#' @param use \code{use} supplied to cor function
#' @param reversePalette boolean to determine if the palette should be reversed
#' @author Barret Schloerke \email{schloerke@@gmail.com}
#' @importFrom stats cor.test
#' @importFrom RColorBrewer brewer.pal
#' @export
#' @keywords hplot
#' @examples
#' ggally_cor_color(iris, ggplot2::aes(x = Sepal.Length, y = Petal.Width))
#' ggally_cor_color(
#'   iris,
#'   ggplot2::aes(x = Sepal.Length, y = -1 * Petal.Width),
#'   method = "spearman"
#' )
#'
#' require(GGally)
#' ggpairs(iris, 1:4, upper = list(continuous = ggally_cor_color))
#' # use kendall correlation, only three color groups and reverse the pallete
#' ggpairs(
#'   iris, 1:3,
#'   lower = "blank",
#'   upper = list(
#'     continuous = wrap(
#'       ggally_cor_color,
#'       method = "kendall",
#'       breaks = 3,
#'       reversePalette = TRUE
#'     )
#'   )
#' )
#' # use kendall correlation, only three color groups but breaking at abs(0.2)
#' ggpairs(
#'   iris, 1:3,
#'   lower = "blank",
#'   upper = list(
#'     continuous = wrap(
#'       ggally_cor_color,
#'       method = "spearman",
#'       breaks = c(-0.20, 0.20)
#'     )
#'   )
#' )
ggally_cor_color <- function(data, mapping, color = I("black"), size = 6, pallete = "RdYlGn", breaks = c(-0.99, -0.8, -0.6, 0.6, 0.8, 0.99), ..., use = "everything", method = "pearson", reversePalette = FALSE) {

  if (!is.null(mapping$colour)) {
    warning("mapping 'colour' will be ignored")
  }

  x = eval(mapping$x, data)
  y = eval(mapping$y, data)
  corVal <- cor(
    x = x, y = y,
    use = use,
    method = method
  )

  corText <- as.character(format(
    corVal,
    digits = 2
  )[1])

  # plot the cor value
  p <- ggally_text(
    label = corText,
    mapping = aes(),
    xP = 0.5, yP = 0.5,
    xrange = range(x, na.rm = TRUE),
    yrange = range(y, na.rm = TRUE),
    size = size,
    color = color,
    ...
  ) +
    theme(
      panel.background = element_rect(color = "black", linetype = "dashed"),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_blank()
    )

  # if a single break value was supplied, turn it into a sequence
  if (length(breaks) == 1) {
    breaks <- seq(from = -1, to = 1, length.out = breaks + 1)
    breaks <- breaks[2:(length(breaks) - 1)]
  }

  # no extreme values allowed
  if (breaks[1] == -1) {
    breaks <- breaks[-1]
  }
  if (breaks[length(breaks)] == 1) {
    breaks <- breaks[-1 * length(breaks)]
  }

  if (!all(order(breaks) == seq_along(breaks))) {
    stop("breaks are not ordered. Please make them ordered from most negative to most positive")
  }

  colorN <- length(breaks)
  # pad the breaks so they are not extreme
  corColors <- RColorBrewer::brewer.pal(n = colorN + 1, name = pallete)
  if (identical(reversePalette, TRUE)) {
    corColors <- rev(corColors)
  }

  if (corVal < 0) {
    colorPos <- which.max(corVal <= breaks)
  } else {
    colorPos <- max(c(1, which(corVal >= breaks) + 1))
  }

  p <- p + theme(
    panel.background = element_rect(fill = corColors[colorPos])
  )

  p
}