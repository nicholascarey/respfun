# library(testthat)


output <- eff_vol(resp_vol = 0.25,
                  spec_vol = NULL,
                  spec_mass = 0.00186,
                  spec_density = 1000,
                  t = NULL,
                  S = NULL,
                  P = 1.013253)

# test output value
expect_equal(as.numeric(output),
              0.24814)

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

# test density calc
output <- eff_vol(resp_vol = 0.25,
                  spec_vol = NULL,
                  spec_mass = 0.1,
                  spec_density = NULL,
                  t = 1,
                  S = 1,
                  P = 1.013253)

expect_equal(round(as.numeric(output),6),
             0.149929)

