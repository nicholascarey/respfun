#' @title Divide a metabolic rate amongst a group
#'
#' @description
#' Divide a metabolic rate amongst a group of individuals.
#'
#' @details
#' Divides a group metabolic rate amongst individuals, given body masses of
#' each and a scaling exponent.
#'
#' @usage
#' split_rate(x, tR = NULL, b = 0.75)
#'
#' @param x numeric. A vector of body masses of all individuals in group
#' @param tR numeric. Total group metabolic rate
#' @param b numeric. Metabolic scaling exponent
#'
#' @return Output is a \code{list} object containing 5 numeric elements:
#'
#' $a = \code{a} in the mass~rate power equation. Determined by the function.
#'
#' $b = \code{b} in the mass~rate power equation. User entered.
#'
#' $tR = total group rate. User entered.
#'
#' $masses = specimen masses. User entered.
#'
#' $indiv.rates = Primary output of interest. Group rate divided between
#' individuals. Sum should therefore equal tR. Determined by the function
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

split_rate <- function(x, tR = NULL, b = 0.75) {

  ## error checks
  ## check tR has been entered
  if (is.null(tR)) {
    warning("Enter value for tR - Total Group Rate")
    return("NA")
  }

  ## check b is within fairly normal range - but don't stop function
  ## just a warning in case user enters MASS SPECIFIC scaling exponent
  if ((b < 0.66 && b > 0.33) || b > 1) {
    warning("b is outside typical range of values for a metabolic scaling exponent.
            Check this value is correct, and not the MASS-SPECIFIC scaling exponent.
            Result has been returned regardless.")
  }

  if (b <= 0.33) {
    warning("b value is less/equal to 0.33, which is well outside the typical range of 0.66 to 1.
            Make sure this is not the MASS-SPECIFIC scaling exponent.
            Result has been returned regardless.")
  }

  ## in individuals
  ## R = a*(M^b)

  ## in groups
  ## tR = a*(M1^b) + a*(M2^b) + a*(M3^b)...

  ## calculate a
  a <- tR / (sum(x^b))

  ## return scaled rates
  indiv_rates <- a * (x^b)

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
  output[[4]] <- x # masses
  output[[5]] <- indiv_rates

  ## Assign class
  class(output) <- "split_rate"

  return(output)
}
