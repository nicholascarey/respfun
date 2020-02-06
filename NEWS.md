# respfun 0.4.3

# respfun 0.4.2
Another minor fix to `scale_rate`. 

- The `scale_rate` function now properly extracts all rates from `respR::convert_rate` objects, not just the first one. 

# respfun 0.4.1

This patch fixes a major issue in `eff_vol`. All previous versions of this function returned incorrect results at anything other than neutral buoyancy (multiplication instead of division in the mass & density to volume equation, doh!).

- MAJOR FIX: fix for incorrect results returned by `eff_vol`. If you have used this function previously, please review your code and results. 
- FIX:`spec_density` : warning when wet_mass and buoy_mass are equal (leads to infinite density calculation)

