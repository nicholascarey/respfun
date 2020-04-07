# library(testthat)


simple_output <- split_rate(masses = c(2, 3, 4, 5, 6, 7),
                            tR = 500,
                     b = 0.75)

expect_output(str(simple_output),
              "List of 7")

expect_is(simple_output,
              "split_rate")

# test prints ok
expect_output(print(simple_output))
# test prints with 5 or less masses
expect_output(print(split_rate(masses = c(2, 3, 4, 5),
                               tR = 500,
                               b = 0.75)))



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

# test prints with respR object
expect_output(print(split_rate(masses = c(2, 3, 4, 5, 6, 7),
                               tR = urch_rate,
                               b = 0.75)))

# Accepts convert_rate objects
expect_equal(split_rate(masses = c(2, 3, 4, 5, 6, 7),
                          tR = urch_rate,
                          b = 0.75)$input,
               "convert_rate")

# units correctly extracted
expect_equal(respr_output_no_mass$units,
             urch_rate$output.unit)

# rate correctly extracted
expect_equal(respr_output_no_mass$tR,
             urch_rate$output.rate)

# units correctly ignored
expect_message(split_rate(masses = c(2, 3, 4, 5, 6, 7),
                          tR = urch_rate,
                          b = 0.75,
                          units = "mg/l"),
               "'units' input ignored. Rate units extracted from convert_rate object.")


# Test split rate totals group rate ---------------------------------------

expect_equal(sum(respr_output_no_mass$indiv.rates[[1]]),
             respr_output_no_mass$tR)

expect_equal(sum(simple_output$indiv.rates[[1]]),
             simple_output$tR)


# Test works with multiple rates ------------------------------------------


mult_output <- split_rate(masses = c(2, 3, 4, 5, 6, 7),
                            tR = c(500,600,700),
                            b = 0.75)

expect_equal(sum(mult_output$indiv.rates[[1]]),
             mult_output$tR[1])

expect_equal(sum(mult_output$indiv.rates[[2]]),
             mult_output$tR[2])

expect_equal(length(mult_output$indiv.rates),
             length(mult_output$tR))

expect_equal(length(mult_output$indiv.rates),
             length(mult_output$a))
