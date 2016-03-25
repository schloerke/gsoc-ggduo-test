
context("ggally_cor_color")


test_that("color", {

  expect_warning(
    ggally_cor_color(
      iris,
      aes(x = Sepal.Length, y = Petal.Width, color = Species)
    ),
    "mapping 'colour'"
  )
})

test_that("method", {
  lapply(c("pearson", "kendall", "spearman"), function(method) {
    p <- ggally_cor_color(
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
    ggally_cor_color(
      iris,
      aes(x = Sepal.Length, y = Petal.Width),
      breaks = c(1/3, -1/3)
    ),
    "breaks are not ordered"
  )

})
