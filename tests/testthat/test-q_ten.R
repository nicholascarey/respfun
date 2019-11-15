# library(testthat)

# test output Q10
expect_equal(q_ten(rate1 = 2, rate2 = 5, t1 = 10, t2 = 20, q10 = NULL),
              2.5)
expect_equal(q_ten(rate1 = 2, rate2 = 3, t1 = 10, t2 = 15, q10 = NULL),
              2.25)
expect_equal(q_ten(rate1 = 2, rate2 = 3, t1 = 10, t2 = 15, q10 = NULL),
             respirometry::Q10(R1 = 2, R2 = 3, T1 = 10, T2 = 15))

# test output rate2
expect_equal(q_ten(rate1 = 2, rate2 = NULL, t1 = 10, t2 = 20, q10 = 2.5),
             5)
expect_equal(q_ten(rate1 = 2, rate2 = NULL, t1 = 10, t2 = 15, q10 = 2.25),
             3)
expect_equal(q_ten(rate1 = 2, rate2 = NULL, t1 = 10, t2 = 15, q10 = 2.25),
             respirometry::Q10(R1 = 2, T1 = 10, T2 = 15, Q10 = 2.25))

# test output rate1
expect_equal(q_ten(rate1 = NULL, rate2 = 3, t1 = 10, t2 = 15, q10 = 2.25),
             2)
expect_equal(q_ten(rate1 = NULL, rate2 = 5, t1 = 10, t2 = 20, q10 = 2.5),
             2)
expect_equal(q_ten(rate1 = NULL, rate2 = 3, t1 = 10, t2 = 15, q10 = 2.25),
             respirometry::Q10(R2 = 3, T1 = 10, T2 = 15, Q10 = 2.25))

# test output t1
expect_equal(q_ten(rate1 = 2, rate2 = 3, t1 = NULL, t2 = 15, q10 = 2.25),
             10)
expect_equal(q_ten(rate1 = 2, rate2 = 5, t1 = NULL, t2 = 20, q10 = 2.5),
             10)
expect_equal(q_ten(rate1 = 2, rate2 = 3, t1 = NULL, t2 = 15, q10 = 2.25),
             respirometry::Q10(R1 = 2, R2 = 3, T2 = 15, Q10 = 2.25))

# test output t2
expect_equal(q_ten(rate1 = 2, rate2 = 3, t1 = 10, t2 = NULL, q10 = 2.25),
             15)
expect_equal(q_ten(rate1 = 2, rate2 = 5, t1 = 10, t2 = NULL, q10 = 2.5),
             20)
expect_equal(q_ten(rate1 = 2, rate2 = 3, t1 = 10, t2 = NULL, q10 = 2.25),
             respirometry::Q10(R1 = 2, R2 = 3, T1 = 10, Q10 = 2.25))



# test messages
expect_error(q_ten(rate1 = 2, rate2 = 5, t1 = 10, t2 = 25, q10 = 2.5),
               "One input must be empty.")
expect_error(q_ten(rate1 = 2, rate2 = 5, t1 = NULL, t2 = NULL, q10 = 2.5),
               "Four inputs are required.")

