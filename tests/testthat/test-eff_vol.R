# library(testthat)

output <- eff_vol(resp_vol = 1,
                  spec_vol = NULL,
                  spec_mass = 0.1,
                  spec_density = 1000.714,
                  t = NULL,
                  S = NULL,
                  P = 1.013253)

# test class
expect_is(output,
          "numeric")


# test messages
expect_error(eff_vol(NULL, 1, 1, 1, 1, 1, 1),
             "Enter a respirometer volume - resp_vol")
expect_error(eff_vol(1, NULL, NULL, 1, 1, 1, 1))
expect_error(eff_vol(1, 1, 1, 1, 1, 1, 1),
             "Only one of spec_mass or spec_vol should be entered.")
expect_message(eff_vol(1, NULL, 1, 1, 1, 1, 1),
               "NOTE: spec_density used for calculations. t and S inputs IGNORED.")
expect_error(eff_vol(1, NULL, 1, NULL, NULL, 1, 1),
             "A spec_mass input requires either a density, or t and S inputs with which to calculate water density.")
expect_message(eff_vol(1, 1, NULL, 1, 1, 1, 1),
               "Calculating Effective Volume as resp_vol minus spec_vol. \n All other inputs IGNORED. ")

# test density calcs
## 10% volume at neutral buoyancy should = 0.9 vol at this t and S

dens <- spec_density(wet_mass = 0.1,
                     buoy_mass = 0,
                     t = 1,
                     S = 1,
                     P = 1.013253)

output <- eff_vol(resp_vol = 1,
                  spec_vol = NULL,
                  spec_mass = 0.1,
                  spec_density = dens) # density of sw at these t,S,P

expect_equal(round(as.numeric(output),3),
             0.9)

## Same at 50% neutral buoyancy should = 0.95 vol at this t and S

dens <- spec_density(wet_mass = 0.1,
                     buoy_mass = 0.05,
                     t = 1,
                     S = 1,
                     P = 1.013253)

output <- eff_vol(resp_vol = 1,
                  spec_vol = NULL,
                  spec_mass = 0.1,
                  spec_density = dens)

expect_equal(round(as.numeric(output),3),
             0.95)


## Same at nearly 100% not buoyant should = approx x1 vol at this t and S

dens <- spec_density(wet_mass = 0.1,
                     buoy_mass = 0.099,
                     t = 1,
                     S = 1,
                     P = 1.013253)

output <- eff_vol(resp_vol = 1,
                  spec_vol = NULL,
                  spec_mass = 0.1,
                  spec_density = dens)

expect_equal(round(as.numeric(output),3),
             0.999)


