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
          "spec_density")

# test prints
expect_output(print(output))
