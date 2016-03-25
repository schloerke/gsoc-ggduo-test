[![Travis-CI Build Status](https://travis-ci.org/schloerke/gsoc-ggduo-test.svg?branch=master)](https://travis-ci.org/schloerke/gsoc-ggduo-test)


# GSoC 2016
## ggduo: pairs plots for multiple regression, cca, time series

## Test Suite
* Easy: Install the GGally package from github (you might have to install the devtools package first). Run one of the examples, put the chart in a knitr/Rmarkdown document and write a paragraph to explain the chart.
* Medium: Make a new correlation plot that can be used in ggpairs. The plot function should change background color depending on the correlation value, the regular background and grid should be removed from the plot.
* Hard: Make a function that prints the legend of a ggplot2 object. Display the results in a knitr/Rmarkdown document.
* Hard: All documents should be vignettes in a small package that depends upon GGally. The R code necessary will be located in the R directory and documented.
