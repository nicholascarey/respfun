#' @title Divide a metabolic rate amongst a group
#'
#' @description Divide a metabolic rate amongst a group of individuals.
#'
#' @details Divides a group metabolic rate amongst individuals, given body
#'   masses of each and a scaling exponent.
#'
#'   Take care to enter the correct scaling exponent (`b`). This is usually
#'   (with exceptions) a positive value between 0.66 and 1. If your `b` value is
#'   less than this, especially if it is less than 0.33, and ESPECIALLY if it is
#'   negative, then it is likely a MASS-SPECIFIC scaling exponent. The correct
#'   scaling exponent is the positive difference of this value from 1. For
#'   example, for a scaling exponent of 0.75, the mass-specific scaling exponent
#'   would be -0.25.
#'
#'   If, for whatever reason, you want to do a simple per-capita division of the
#'   rate regardless of the body masses, enter `b = 0`. Or just divide it by the
#'   number of individuals.
#'
#' @usage split_rate(masses, tR = NULL, b = 0.75)
#'
#' @param masses numeric. A vector of body masses of all individuals in group
#' @param tR numeric. Total group metabolic rate
#' @param b numeric. Metabolic scaling exponent
#'
#' @return Output is a \code{list} object containing 5 numeric elements:
#'
#'   $a = \code{a} in the mass~rate power equation. Determined by the function.
#'
#'   $b = \code{b} in the mass~rate power equation. User entered.
#'
#'   $tR = total group rate. User entered.
#'
#'   $masses = specimen masses. User entered.
#'
#'   $indiv.rates = Primary output of interest. Group rate divided between
#'   individuals. Sum should therefore equal tR. Determined by the function
#'
#' @examples
#' split_rate(c(2, 3, 4, 5, 6), tR = 500, b = 0.75)
#'
#' @author Nicholas Carey - \email{nicholascarey@gmail.com}
#'
#' @export

## R = a*(M^b)
## R = NON-mass specific O₂ uptake rate
## a = intercept
## M = mass
## b = scaling exponent (typically 0.66/0.75/1)
## NOT the mass-specific one - should be the positive difference from 1
## i.e. MASS-SPECIFIC scaling expoenent of -0.25 means an actual scaling exponent of 0.75

## therefore, Total Group Rate (tR):
## tR = a*(M1^b) + a*(M2^b) + a*(M3^b) .....
## M1,M2 = masses of specimens 1, 2...
## a and b are the same for every specimen

## rearrange
## a = tR/(sum(M1^b + M2^b + M3^b.....))

## pick an appropriate b value

## then to get the scaled rate of each specimen put its mass into the equation
## R = a*(M^b)

## sum of scaled rates should equal tR

## x should be a vector of masses, tR is total group rate

split_rate <- function(masses, tR = NULL, b = 0.75) {

  ## entry checks
  if (is.null(tR)) {
    stop("Enter value for tR - Total Group Rate")
  }
  if (is.null(b)) {
    stop("Enter value for b - Metabolic Scaling Exponent")
  }

  ## check b is within fairly normal range - but don't stop function
  ## just a warning in case user enters MASS SPECIFIC scaling exponent
  if ((b < 0.66 && b > 0.33) || b > 1) {
    warning("Value of b is outside the typical range for a metabolic scaling exponent of 0.66 to 1.
  Check this value is correct, and not the MASS-SPECIFIC scaling exponent.
  Result has been returned regardless.")
  }

  if (b <= 0.33 && b >= 0) {
    warning("Value of b is less/equal to 0.33, which is WELL outside the typical range of 0.66 to 1.
  Check this value is correct, and not the MASS-SPECIFIC scaling exponent.
  Result has been returned regardless.")
  }

  if (b < 0) {
    warning("Value of b is less/equal to 0.33, which is WELL outside the typical range of 0.66 to 1.
  Check this value is correct, and not the MASS-SPECIFIC scaling exponent.
  Result has been returned regardless.")
  }


  ## in individuals
  ## R = a*(M^b)

  ## in groups
  ## tR = a*(M1^b) + a*(M2^b) + a*(M3^b)...

  ## calculate a
  a <- tR / (sum(masses^b))

  ## return scaled rates
  indiv_rates <- a * (masses^b)

  ## check result - sum of scaled rates shoudl equal tR

  # this check fails because of trailing decimal differences... fix later
  # if(sum(indiv_rates) != tR){
  #   warning("Something is wrong. Sum of scaled rates does not equal entered tR")
  #   return("NA")}

  ## new output structure
  output <- list(
    a = numeric(0), b = numeric(0), tR = numeric(0),
    masses = vector(), indiv.rates = vector()
  )

  output[[1]] <- a
  output[[2]] <- b
  output[[3]] <- tR
  output[[4]] <- masses # masses
  output[[5]] <- indiv_rates

  ## Assign class
  class(output) <- "split_rate"

  return(output)
}
