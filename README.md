
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

Benjamin P. Burford, Nicholas Carey, William F. Gilly, Jeremy A.
Goldbogen. 2019. Grouping reduces the metabolic demand of a social
squid. *Marine Ecology Progress Series*. 612: 141–150
<https://doi.org/10.3354/meps12880>

This function integrates with the
[`respR`](https://github.com/januarharianto/respR) package: objects
saved from the `respR::convert_rate` function can be entered, and the
rate and units will be automatically extracted.

### Example

``` r
## Simple example
split_rate(masses = c(2, 3, 4, 5, 6), # body masses
           tR = 500,                  # total metabolic rate of group
           b = 0.75,                  # metabolic scaling exponent
           units = "mg/h")            # units
```

Output:

    #> 
    #> Rate Division Complete: 
    #>  
    #> Intercept (a, calculated) :                    35.7984448854878
    #> Metabolic Scaling Exponent (b, user entered):  0.75
    #> Total Group Rate (tR, user entered):           500
    #> Masses (masses, user entered): 
    #> [1] 2 3 4 5 6
    #> 
    #> Individual Rates Calculated: 
    #> [1]  60.20557  81.60281 101.25329 119.69931 137.23902
    #> 
    #> Rate units: mg/h

### Future functionality

In due course I’ll add a few more functions I find useful in working
with respirometry and metabolic data.

For analysing your respirometry data check out my other package
[`respR`](https://github.com/januarharianto/respR).
