# library(testthat)

output <- spec_density(wet_mass = 1,
                       buoy_mass = 0,
                       t = 10,
                       S = 35,
                       P = 1.013253)

# test output value
expect_equal(round(as.numeric(output), 3),
             1026.826)

# test class
expect_is(output,
          "numeric")


# test messages
expect_error(spec_density(NULL, 1, 0, 1, 1),
             "wet_mass is required")
expect_error(spec_density(1, NULL, 0, 1, 1),
             "buoy_mass is required")
expect_error(spec_density(1, 1, NULL, 1, 1),
             "Temperature is required")
expect_error(spec_density(1, 1, 1, NULL, 1),
             "Salinity is required")
expect_error(spec_density(1, 1, 1, 1, NULL),
             "Atm. Pressure is required")
expect_message(spec_density(1, 1, 1, 1, 1),
             "NOTE: Non-default P value being used")


expect_error(eff_vol(1, NULL, NULL, 1, 1, 1, 1))
expect_error(eff_vol(1, 1, 1, 1, 1, 1, 1),
             "Only one of spec_mass or spec_vol should be entered.")
expect_message(eff_vol(1, NULL, 1, 1, 1, 1, 1),
               "NOTE: spec_density used for calculations. t and S inputs IGNORED.")
expect_error(eff_vol(1, NULL, 1, NULL, NULL, 1, 1),
             "A spec_mass input requires either a density, or t and S inputs with which to calculate water density.")
expect_message(eff_vol(1, 1, NULL, 1, 1, 1, 1),
               "Calculating Effective Volume as resp_vol minus spec_vol. \n All other inputs IGNORED. ")
