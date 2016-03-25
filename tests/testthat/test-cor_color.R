
context("color_cor")


test_that("color", {

  expect_warning(
    color_cor(
      iris,
      aes(x = Sepal.Length, y = Petal.Width, color = Species)
    ),
    "mapping 'colour'"
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

})
