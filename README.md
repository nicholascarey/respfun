
<!-- README.md is generated from README.Rmd. Please edit that file -->

# respfun

[![Travis build
status](https://travis-ci.org/nicholascarey/respfun.svg?branch=master)](https://travis-ci.org/nicholascarey/respfun)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/nicholascarey/respfun?branch=master&svg=true)](https://ci.appveyor.com/project/nicholascarey/respfun)
[![Coverage
status](https://codecov.io/gh/nicholascarey/respfun/branch/master/graph/badge.svg)](https://codecov.io/github/nicholascarey/respfun?branch=master)

This package is a collection of random functions for use with
respirometry data. More will be added with time. Not intended to be a
fully featured R package.

### Installation

`respfun` can be installed using the `devtools` package:

``` r
install.packages("devtools")
devtools::install_github("nicholascarey/respfun")
```

### Contents

For now there is just one function, `split_rate`. This function divides
a metabolic rate between a group of individuals based on their masses
and a metabolic scaling exponent. It was used in this recent
publication:

*Benjamin P. Burford, Nicholas Carey, William F. Gilly, Jeremy A.
Goldbogen. 2019. Grouping reduces the metabolic demand of a social
squid. **Marine Ecology Progress Series**. 612: 141–150
<https://doi.org/10.3354/meps12880>*

This function integrates with the
[`respR`](https://github.com/januarharianto/respR) package: objects
saved from the `respR::convert_rate` function can be entered (or `%>%`
piped), and the rate and units will be automatically extracted.

### Example

``` r
## Simple example
split_rate(tR = 500,                  # total metabolic rate of group
           masses = c(2, 3, 4, 5, 6), # body masses
           b = 0.75,                  # metabolic scaling exponent
           units = "mg/h")            # units
```

Output:

    #> 
    #> # split_rate # -------------------------
    #> Rate Division Complete: 
    #> 
    #> Intercept (a, calculated) :               35.7984448854878
    #> Metabolic Scaling Exponent (b, entered):  0.75
    #> Total Group Rate (tR, entered):           500
    #> Masses (masses, entered): 
    #> [1] 2 3 4 5 6
    #> 
    #> Individual rates (indiv.rates, calculated): 
    #> [1]  60.20557  81.60281 101.25329 119.69931 137.23902
    #> 
    #> Rate units: mg/h

### `respR` Example

``` r
## Simple example
library(respR)                                           # Load respR

urchins.rd %>%                                           # NOT a group respirometry experiment,
                                                          # - Just using it as an example,
  inspect(1, 15) %>%                                     # inspect
  calc_rate(from = 4, to = 29, by = "time") %>%          # calculate rate
  print() %>%
  adjust_rate(
    calc_rate.bg(urchins.rd, xcol = 1, ycol = 18:19,     # adjust for background
                 from = 5, to = 40, by = "time")) %>%
  print() %>%
  convert_rate(o2.unit = "mgl-1", time.unit = "m",       # convert
               output.unit = "mg/h", volume = 1.09) %>%
  split_rate(c(2, 3, 4, 5, 6, 7, 8),                     # divide
             0.75) %>%
  print()
```

Output:

    #> 
    #> # calc_rate # -------------------
    #> Rate(s):
    #> [1] -0.02177588
    #> 
    #> Rate adjustments applied. Use print() command for more info.
    #> 
    #> # adjust_rate # -------------------------
    #> Note: please consider the sign of the value while correcting the rate.
    #> 
    #> Rank/position 1 result shown. To see all results use summary().
    #> Input rate: -0.02177588
    #> Adjustment: -0.0008287306
    #> Adj. rate: -0.02094715 
    #> 
    #> # convert_rate # ------------------------
    #> Rank/position 1 result shown. To see all results use summary().
    #> Input:
    #> [1] -0.02094715
    #> [1] "mg/L" "min" 
    #> Converted:
    #> [1] -1.369944
    #> [1] "mg/hour"
    #> 
    #> # split_rate # -------------------------
    #> Rate Division Complete: 
    #> --- respR::convert_rate object detected ---
    #> 
    #> Intercept (a, calculated) :               -0.0594918110462312
    #> Metabolic Scaling Exponent (b, entered):  0.75
    #> Total Group Rate (tR, entered):           -1.36994367466591
    #> Masses (masses, entered): 
    #> [1] 2 3 4 5 6 7 8
    #> 
    #> Individual rates (indiv.rates, calculated): 
    #> [1] -0.1000529 -0.1356120 -0.1682683 -0.1989229 -0.2280713 -0.2560240
    #> [7] -0.2829923
    #> 
    #> Rate units: mg/hour

### Future functionality

In due course I’ll add a few more functions I find useful in working
with respirometry and metabolic data.

For analysing your respirometry data check out my other package
[`respR`](https://github.com/januarharianto/respR).
