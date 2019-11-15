`respfun`
================

  - [Installation](#installation)
  - [Functions](#functions)
      - [`split_rate`](#split_rate)
      - [`eff_vol`](#eff_vol)
      - [`spec_density`](#spec_density)
      - [`wm_to_vol`](#wm_to_vol)
      - [`scale_rate`](#scale_rate)
      - [`q_ten`](#q_ten)
  - [Future functionality](#future-functionality)
  - [Full respirometry analyses](#full-respirometry-analyses)

<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis build
status](https://travis-ci.org/nicholascarey/respfun.svg?branch=master)](https://travis-ci.org/nicholascarey/respfun)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/nicholascarey/respfun?branch=master&svg=true)](https://ci.appveyor.com/project/nicholascarey/respfun)
[![Coverage
status](https://codecov.io/gh/nicholascarey/respfun/branch/master/graph/badge.svg)](https://codecov.io/github/nicholascarey/respfun?branch=master)

This package is a collection of functions for use with respirometry data
and experiments. I will add to it periodically (suggestions
[welcome](https://github.com/nicholascarey/respfun/issues)). It is not
intended to be a fully featured R package, more a collection of handy
functions. Similar functions are available in other packages and work
perfectly well, I just like writing my own as a learning exercise.

### Installation

`respfun` can be installed using the `devtools` package:

``` r
install.packages("devtools")
devtools::install_github("nicholascarey/respfun")
```

### Functions

Currently there are six functions:

#### `split_rate`

This function divides a metabolic rate between a group of individuals
based on their masses and a metabolic scaling exponent. It was used in
this recent publication:

*Benjamin P. Burford, Nicholas Carey, William F. Gilly, Jeremy A.
Goldbogen. 2019. Grouping reduces the metabolic demand of a social
squid. **Marine Ecology Progress Series**. 612: 141–150
<https://doi.org/10.3354/meps12880>*

This function integrates with the
[`respR`](https://github.com/januarharianto/respR) package: objects
saved from the `respR::convert_rate` function can be entered (or `%>%`
piped), and the rate and units will be automatically extracted.

``` r
## Simple example

split_rate(tR = 500,                  # total metabolic rate of group
           masses = c(2, 3, 4, 5, 6), # body masses
           b = 0.75,                  # metabolic scaling exponent
           units = "mg/h")            # units
```

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

``` r
## respR example

library(respR)                                           # Load respR

urchins.rd %>%                                           # NOT a group respirometry experiment,
                                                          # - Just using it as an example,
  inspect(1, 15) %>%                                     # inspect
  calc_rate(from = 4, to = 29, by = "time") %>%          # calculate rate
  print() %>%
  convert_rate(o2.unit = "mgl-1", time.unit = "m",       # convert
               output.unit = "mg/h", volume = 1.09) %>%
  split_rate(c(2, 3, 4, 5, 6, 7, 8),                     # divide
             0.75) %>%
  print()
```

    #> 
    #> # calc_rate # -------------------
    #> Rate(s):
    #> [1] -0.02177588
    #> 
    #> # convert_rate # ------------------------
    #> Rank/position 1 result shown. To see all results use summary().
    #> Input:
    #> [1] -0.02177588
    #> [1] "mg/L" "min" 
    #> Converted:
    #> [1] -1.424143
    #> [1] "mg/hour"
    #> 
    #> # split_rate # -------------------------
    #> Rate Division Complete: 
    #> --- respR::convert_rate object detected ---
    #> 
    #> Intercept (a, calculated) :               -0.0618454810725696
    #> Metabolic Scaling Exponent (b, entered):  0.75
    #> Total Group Rate (tR, entered):           -1.42414265277951
    #> Masses (masses, entered): 
    #> [1] 2 3 4 5 6 7 8
    #> 
    #> Individual rates (indiv.rates, calculated): 
    #> [1] -0.1040113 -0.1409772 -0.1749254 -0.2067928 -0.2370945 -0.2661531 -0.2941883
    #> 
    #> Rate units: mg/hour

#### `eff_vol`

This calculates the ‘effective volume’ of a respirometer, that is the
volume *minus* the volume of the specimen. This allows you to input the
correct water volume into respirometry analyses in order to calculate
the correct amount of oxygen used, for example in the
[`respR::convert_rate`](https://januarharianto.github.io/respR/reference/convert_rate.html)
function.

The respirometer volume (`resp_vol`) can be corrected to get the
effective volume in a number of ways:

  - A specimen volume (`spec_vol`) can be entered directly (if for
    instance you have calculated it geometrically or measured the
    displacement volume separately), in which case the effective volume
    is a simple subtraction.

  - Alternatively, you can enter the specimen mass and density (see
    `spec_density` function below), in which case the specimen volume is
    calculated and the correction performed using that. If your specimen
    is neutrally buoyant you could enter the density of the water here
    (seawater density is usually around 1026 kg/m^3, but see next option
    for precise calculation).

  - Lastly, you can enter the specimen mass and make the assumption the
    specimen is the same density as the water, in which case temperature
    and salinity are required to calculate the water density and perform
    the correction (strictly speaking atmospheric pressure is also
    required; in reality it has a negligible effect within normal
    ranges, although the default value can be changed if desired). This
    is common in fish respirometry when the specimen is known to be
    neutrally buoyant, or nearly so.

See `?eff_vol` for more.

#### `spec_density`

This function calculates a specimen density from a total wet mass and a
bouyant mass (see
[here](https://www.researchgate.net/publication/266911357_Buoyant_weight_technique_Application_to_freshwater_bivalves)).
This is common in studies of shell bearing species such as molluscs and
echinoderms where it is a non-lethal way of examining the ratio of shell
to tissue mass. It can also be used to determine the animal volume for
correcting respirometry water volumes (see above). The water temperature
and salinity at which buoyant mass was determined are required. See
`?spec_density` for more.

#### `wm_to_vol`

This is a simple function to convert a water mass to a water volume.
Sometimes it is easier to weigh a respirometer to determine the water
mass than try to measure the volume, for example across large size
ranges of specimen and respirometer size (e.g. [Carey et
al. 2016](https://www.dropbox.com/s/d4zp3vm6xakzkts/Carey%20et%20al%20JEB%202016.pdf?dl=0)),
where systematic error is a concern. The water temperature and salinity
are required. See `?wm_to_vol` for more.

#### `scale_rate`

This function scales a physiological rate to a different body mass using
a scaling exponent. Works with both absolute (i.e. whole animal) and
mass-specific rates. See `?wm_to_vol` for more.

#### `q_ten`

Calculates any of the five parameters in the Q10 temperature
relationship for physiological or chemical processes. Q10 describes the
ratio by which a physiological or chemical rate changes with a 10°C
increase in temperature. Essentially the same as the `Q10` function in
the
[`respirometry`](https://cran.r-project.org/web/packages/respirometry/index.html)
package by Matthew Birk, although that has additional functionality for
determining the best fit Q10 for a range of rates/temperatures. See
`?q_ten` for more.

### Future functionality

In due course I’ll add a few more functions I find useful in working
with respirometry and metabolic rate data. Suggestions for additional
functions are welcome via [email](mailto:nicholascarey@gmail.com), or by
[opening an issue](https://github.com/nicholascarey/respfun/issues).

### Full respirometry analyses

For analysing your respirometry data check out another package I
co-developed: [`respR`](https://github.com/januarharianto/respR).
