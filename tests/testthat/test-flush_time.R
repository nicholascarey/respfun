# library(testthat)

expect_error(flush_time(volume = 10,
                     flow = 0.15,
                     tolerance = 0),
             "`tolerance` cannot be equal to 0.")

expect_error(flush_time(volume = 10,
                     flow = 0.15,
                     tolerance = 1),
             "`tolerance` cannot be equal to 1.")

expect_error(flush_time(volume = 10,
                     flow = 0.15,
                     tolerance = 1.1),
             "`tolerance` must be between 1 and 0.")

expect_equal(flush_time(volume = 10,
                        flow = 0.15,
                        tolerance = 0.99),
             305)

expect_output(flush_time(volume = 10,
                        flow = 0.15,
                        tolerance = 0.99),
             "Time to flush 99% of 10L at 0.15 L/s is: 305 seconds.")


