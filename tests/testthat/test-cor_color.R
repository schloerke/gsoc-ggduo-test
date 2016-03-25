
context("color_cor")
library(ggplot2)

test_that("color", {

  expect_warning(
    color_cor(
      iris,
      aes(x = Sepal.Length, y = Petal.Width, color = Species)
    ),
    "mapping 'colour'"
  )

  p <- color_cor(
    iris,
    aes(x = Sepal.Length, y = Petal.Width),
    reversePalette = TRUE,
  )
  p2 <- color_cor(
    iris,
    aes(x = Sepal.Length, y = Petal.Width),
    reversePalette = FALSE,
  )
  expect_true(
    p$theme$panel.background$fill != p2$theme$panel.background$fill
  )

})

test_that("method", {
  lapply(c("pearson", "kendall", "spearman"), function(method) {
    p <- color_cor(
      iris,
      aes(x = Sepal.Length, y = Petal.Width),
      method = method
    )

    val <- p$layers[[1]]$aes_params$label
    expectedValue <- format(
      cor(iris$Sepal.Length, iris$Petal.Width, method = method),
      digits = 2
    )
    expect_equivalent(val, expectedValue)
  })
})

test_that("breaks", {

  expect_error(
    color_cor(
      iris,
      aes(x = Sepal.Length, y = Petal.Width),
      breaks = c(1 / 3, -1 / 3)
    ),
    "breaks are not ordered"
  )

  pGood <- color_cor(
    iris,
    aes(x = Sepal.Length, y = Petal.Width),
    breaks = c(-1 / 3, 1 / 3)
  )
  p <- color_cor(
    iris,
    aes(x = Sepal.Length, y = Petal.Width),
    breaks = c(-1 / 3, 1 / 3, 1)
  )
  p2 <- color_cor(
    iris,
    aes(x = Sepal.Length, y = Petal.Width),
    breaks = c(-1, -1 / 3, 1 / 3)
  )
  p3 <- color_cor(
    iris,
    aes(x = Sepal.Length, y = Petal.Width),
    breaks = 3
  )
  expect_equivalent(pGood$layers, p$layers)
  expect_equivalent(pGood$layers, p2$layers)
  expect_equivalent(pGood$layers, p3$layers)

})
