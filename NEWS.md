# respfun 0.4.4
Very minor update

- A startup message is now shown on package load

# respfun 0.4.3
Minor update

- `split_rate` now accepts multiple input rates, including from `convert_rate` objects. These should obviously all be rates from the *same group*. Minor change to output object as a result: `$indiv.rates` is now a `list` object with each element a vector of individual rates for teh associated group rate in `tR`. Extract via ``$indiv.rates[[1]]` etc.

# respfun 0.4.2
Another minor fix to `scale_rate`. 

- The `scale_rate` function now properly extracts all rates from `respR::convert_rate` objects, not just the first one. 

# respfun 0.4.1

This patch fixes a major issue in `eff_vol`. All previous versions of this function returned incorrect results at anything other than neutral buoyancy (multiplication instead of division in the mass & density to volume equation, doh!).

- MAJOR FIX: fix for incorrect results returned by `eff_vol`. If you have used this function previously, please review your code and results. 
- FIX:`spec_density` : warning when wet_mass and buoy_mass are equal (leads to infinite density calculation)

