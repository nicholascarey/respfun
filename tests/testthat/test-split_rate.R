# library(testthat)


simple_output <- split_rate(masses = c(2, 3, 4, 5, 6, 7),
                            tR = 500,
                     b = 0.75)

expect_output(str(simple_output),
              "List of 6")

expect_is(simple_output,
              "split_rate")

# test prints ok
expect_output(print(simple_output))

## test stops with wrong inputs
expect_error(split_rate(masses = c(2, 3, 4, 5, 6, 7),
                        tR = NULL,
                        b = 0.75),
             "Enter tR - Total Group Rate")

expect_error(split_rate(masses = c(2, 3, 4, 5, 6, 7),
                        tR = 500,
                        b = NULL),
             "Enter value for b - Metabolic Scaling Exponent")

# test warnings for b values
expect_warning(split_rate(masses = c(2, 3, 4, 5, 6, 7),
                        tR = 500,
                        b = 0.4))
expect_warning(split_rate(masses = c(2, 3, 4, 5, 6, 7),
                        tR = 500,
                        b = 0.2))
expect_warning(split_rate(masses = c(2, 3, 4, 5, 6, 7),
                        tR = 500,
                        b = -0.25))

# Test STOPS with respR object with mass-specific rate --------------------

library(respR)
suppressWarnings(
  urch_rate <- urchins.rd %>%
    inspect(1, 15, plot = F) %>%
    calc_rate(from = 4, to = 29, by = "time", plot = F) %>%
    convert_rate(o2.unit = "mgl-1", time.unit = "m",
                 output.unit = "mg/h/g", volume = 1.09,
                 mass = 10))

expect_error(split_rate(masses = c(2, 3, 4, 5, 6, 7),
                        tR = urch_rate,
                        b = 0.75), "Mass-specific units detected in convert_rate object.")

# Test works with respR object --------------------------------------------

suppressWarnings(
  urch_rate <- urchins.rd %>%
  inspect(1, 15, plot = F) %>%
  calc_rate(from = 4, to = 29, by = "time", plot = F) %>%
  convert_rate(o2.unit = "mgl-1", time.unit = "m",
               output.unit = "mg/h", volume = 1.09))

respr_output_no_mass <- split_rate(masses = c(2, 3, 4, 5, 6, 7),
                                   tR = urch_rate,
                                   b = 0.75)

expect_is(respr_output_no_mass,
          "split_rate")

# Accepts convert_rate objects
expect_message(split_rate(masses = c(2, 3, 4, 5, 6, 7),
                          tR = urch_rate,
                          b = 0.75),
               "respR convert_rate object detected...")

# units correctly extracted
expect_equal(respr_output_no_mass$units,
             urch_rate$output.unit)

# rate correctly extracted
expect_equal(respr_output_no_mass$tR,
             urch_rate$output)

# units correctly ignored
expect_message(split_rate(masses = c(2, 3, 4, 5, 6, 7),
                          tR = urch_rate,
                          b = 0.75,
                          units = "mg/l"),
               "'units' input ignored. Rate units extracted from convert_rate object.")


# Test split rate totals group rate ---------------------------------------

expect_equal(sum(respr_output_no_mass$indiv.rates),
             respr_output_no_mass$tR)

expect_equal(sum(simple_output$indiv.rates),
             simple_output$tR)


