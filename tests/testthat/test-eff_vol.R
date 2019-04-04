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
          "eff_vol")

# test prints
expect_output(print(output))
