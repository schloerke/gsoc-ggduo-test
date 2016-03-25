[![Travis-CI Build Status](https://travis-ci.org/schloerke/gsoc-ggduo-test.svg?branch=master)](https://travis-ci.org/schloerke/gsoc-ggduo-test)
[![codecov.io](https://codecov.io/github/schloerke/gsoc-ggduo-test/coverage.svg?branch=master)](https://codecov.io/github/schloerke/gsoc-ggduo-test?branch=master)


# GSoC 2016
## ggduo: pairs plots for multiple regression, cca, time series

## Test Suite
* Easy: Install the GGally package from github (you might have to install the devtools package first). Run one of the examples, put the chart in a knitr/Rmarkdown document and write a paragraph to explain the chart.
* Medium: Make a new correlation plot that can be used in ggpairs. The plot function should change background color depending on the correlation value, the regular background and grid should be removed from the plot.
* Hard: Make a function that prints the legend of a ggplot2 object. Display the results in a knitr/Rmarkdown document.
* Hard: All documents should be vignettes in a small package that depends upon GGally. The R code necessary will be located in the R directory and documented.

# Install
```{r}
library(devtools)
install_github("schloerke/gsoc-ggduo-test")
library(GSoCggduoTest)

# Easy Test
vignette("easy_test")

# Medium Test
vignette("medium_test")

# Hard Test
vignette("hard_test")
```
* [Easy Link](https://schloerke.github.io/gsoc-ggduo-test/easy_test.html)
* [Medium Link](https://schloerke.github.io/gsoc-ggduo-test/medium_test.html)
* [Hard Link](https://schloerke.github.io/gsoc-ggduo-test/hard_test.html)
