context("grab_legend")

test_that("example", {
  library(ggplot2)
  histPlot <- qplot(
    x = Sepal.Length,
    data = iris,
    fill = Species,
    geom = "histogram",
    binwidth = 1 / 4
  )
  (right <- histPlot)
  (bottom <- histPlot + theme(legend.position = "bottom"))
  (top <- histPlot + theme(legend.position = "top"))
  (left <- histPlot + theme(legend.position = "left"))


  gr <- grab_legend(right)
  gb <- grab_legend(bottom)
  gt <- grab_legend(top)
  gl <- grab_legend(left)

  print(gr); print(gb); print(gt); print(gl, plotNew = FALSE)

  expect_true(!is.null(gr))
  expect_true(!is.null(gb))
  expect_true(!is.null(gt))
  expect_true(!is.null(gl))

})
