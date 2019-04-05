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
          "wm_to_vol")

# test prints
expect_output(print(output))
