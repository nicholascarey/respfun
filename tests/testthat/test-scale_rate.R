# library(testthat)

# test class
expect_is(scale_rate(0.1784, mass = 0.0847, new.mass = 1, b = 0.72),
          "numeric")

# test output value
expect_equal(scale_rate(0.1784, mass = 0.0847, new.mass = 1, b = 0.72),
              1.0552, tolerance = 0.0001)

# test absolute and mass-specific scaling returns equal result
expect_equal(scale_rate(0.1784, mass = 0.0847, new.mass = 1, b = 0.72),
             scale_rate(2.1062, mass = 0.0847, new.mass = 1, b = -0.28),
             tolerance = 0.0001)

# test scaling to same mass is equal
rate <- 32.55
expect_equal(scale_rate(rate, mass = 1, new.mass = 1, b = 0.75),
             rate)

# test isometric scaling (simple multiplication/division)
rate <- 5
expect_equal(scale_rate(rate, mass = 0.5, new.mass = 1, b = 1),
             rate*2)
rate <- 20
expect_equal(scale_rate(rate, mass = 2, new.mass = 1, b = 1),
             rate/2)

# test messages
expect_error(scale_rate(),
             "All four inputs are required.")


# respR integration
library(respR)
suppressWarnings(
  urch_rate <- urchins.rd %>%
    inspect(1, 15, plot = F) %>%
    calc_rate(from = 4, to = 29, by = "time", plot = F) %>%
    convert_rate(o2.unit = "mgl-1", time.unit = "m",
                 output.unit = "mg/h/g", volume = 1.09,
                 mass = 10))

expect_message(
  scale_rate(urch_rate,
             mass = 2,
             new.mass = 1,
             b = 0.75),
  "--- respR::convert_rate object detected ---\n"
  )

expect_equal(
  scale_rate(urch_rate,
             mass = 2,
             new.mass = 1,
             b = 0.75),
  -0.00008468003
  )

