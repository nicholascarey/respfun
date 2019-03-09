# library(testthat)


simple_output <- split_rate(c(2, 3, 4, 5, 6, 7),
                     500,
                     0.75)

expect_output(str(simple_output),
              "List of 6")

expect_is(simple_output,
              "split_rate")


# Test STOPS with respR object with mass-specific rate --------------------
skip_on_travis()

library(respR)
suppressWarnings(
  urch_rate <- urchins.rd %>%
    inspect(1, 15, plot = F) %>%
    calc_rate(from = 4, to = 29, by = "time", plot = F) %>%
    convert_rate(o2.unit = "mgl-1", time.unit = "m",
                 output.unit = "mg/h/g", volume = 1.09,
                 mass = 10))

expect_error(split_rate(c(2, 3, 4, 5, 6, 7),
                        urch_rate,
                        0.75), "Mass-specific units detected in convert_rate object.")

# Test works with respR object --------------------------------------------

suppressWarnings(
  urch_rate <- urchins.rd %>%
  inspect(1, 15, plot = F) %>%
  calc_rate(from = 4, to = 29, by = "time", plot = F) %>%
  convert_rate(o2.unit = "mgl-1", time.unit = "m",
               output.unit = "mg/h", volume = 1.09))

respr_output_no_mass <- split_rate(c(2, 3, 4, 5, 6, 7),
                                   urch_rate,
                                   0.75)

expect_is(respr_output_no_mass,
          "split_rate")

# Accepts convert_rate objects
expect_message(split_rate(c(2, 3, 4, 5, 6, 7),
                          urch_rate,
                          0.75),
               "respR convert_rate object detected...")

# units correctly extracted
expect_equal(respr_output_no_mass$units,
             urch_rate$output.unit)

# rate correctly extracted
expect_equal(respr_output_no_mass$tR,
             urch_rate$output)




# Test split rate totals group rate ---------------------------------------

expect_equal(sum(respr_output_no_mass$indiv.rates),
             respr_output_no_mass$tR)

expect_equal(sum(simple_output$indiv.rates),
             simple_output$tR)


