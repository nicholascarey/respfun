
<!-- README.md is generated from README.Rmd. Please edit that file -->

# respfun

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

I’ll be revising the function soon to integrate nicely with
[`respR`](https://github.com/januarharianto/respR) functions.

### Example

``` r
## Simple example
split_rate(masses = c(2, 3, 4, 5, 6), # body masses
           tR = 500,                  # total metabolic rate of group
           b = 0.75)                  # metabolic scaling exponent
```

Output:

    #> Split Complete: 
    #>  
    #> Intercept (a, calculated) :                    35.8
    #> Metabolic Scaling Exponent (b, user entered):  0.75
    #> Total Group Rate (tR, user entered):           500
    #> Masses (masses, user entered): 
    #> [1] 2 3 4 5 6
    #> 
    #> Individual Rates Calculated: 
    #> [1]  60.21  81.60 101.25 119.70 137.24

### Future functionality

In due course I’ll add a few more functions I find useful in working
with respirometry and metabolic data.

For analysing your respirometry data check out my other package
[`respR`](https://github.com/januarharianto/respR).
