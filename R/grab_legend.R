
#' Grab the legend and print it as a plot
#'
#' @param p ggplot2 plot object
#' @param x legend object that has been grabbed from a ggplot2 object
#' @param ... ignored
#' @param plotNew boolean to determine if the `grid.newpage()` command and a new blank rectangle should be printed
#' @import ggplot2
#' @export
#' @examples
#' library(ggplot2)
#' histPlot <- qplot(
#'   x = Sepal.Length,
#'   data = iris,
#'   fill = Species,
#'   geom = "histogram",
#'   binwidth = 1/4
#' )
#' (right <- histPlot)
#' (bottom <- histPlot + theme(legend.position = "bottom"))
#' (top <- histPlot + theme(legend.position = "top"))
#' (left <- histPlot + theme(legend.position = "left"))
#'
#' grab_legend(right)
#' grab_legend(bottom)
#' grab_legend(top)
#' grab_legend(left)
grab_legend <- function(p) {
  builtP <- ggplot_build(p)
  pTable <- ggplot_gtable(builtP)

  ret <- gtable_filter(pTable, "guide-box")
  class(ret) <- c("legend_guide_box", class(ret))
  return(ret)
}

#' @importFrom grid grid.newpage grid.draw
#' @importFrom gtable gtable_filter
#' @rdname grab_legend
#' @export
print.legend_guide_box <- function(x, ..., plotNew = TRUE) {
  if (identical(plotNew, TRUE)) {
    grid.newpage()
    grid::grid.rect()
  }

  grid.draw(x)
}
