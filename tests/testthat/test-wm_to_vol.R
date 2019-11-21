# library(testthat)

output <- wm_to_vol(mass = 1,
                    t = 23,
                    S = 35,
                    P = 1.013253)


# test output value
expect_equal(round(as.numeric(output), 3),
             0.977)

# test class
expect_is(output,
          "numeric")

# test messages
expect_error(wm_to_vol(NULL, 1, 1, 1),
             "Mass is required")
expect_error(wm_to_vol(1, NULL, 1, 1),
             "Temperature is required")
expect_error(wm_to_vol(1, 1, NULL, 1),
             "Salinity is required")
expect_error(wm_to_vol(1, 1, 1, NULL),
             "Atm. Pressure is required")
expect_message(wm_to_vol(1, 1, 1, 1),
               "NOTE: Non-default P value being used")

