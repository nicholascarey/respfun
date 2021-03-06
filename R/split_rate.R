#' @title Divide a metabolic rate amongst a group
#'
#' @description Divide a metabolic rate amongst a group of individuals.
#'
#' @details Divides a group metabolic rate amongst individuals in the group,
#'   given body masses of each and a scaling exponent.
#'
#'   Take care to enter the correct scaling exponent (`b`). This should be the
#'   scaling exponent of absolute metabolic rates, not mass-specific, and is
#'   usually (with exceptions) a positive value between 0.66 and 1. If your `b`
#'   value is less than this, especially if it is less than 0.33, and
#'   *especially* if it is negative, then it is likely a *mass-specific* scaling
#'   exponent. In which case, the correct scaling exponent is the positive
#'   difference of this value from 1. For example, an absolute scaling exponent
#'   of 0.75 has a mass-specific scaling exponent of -0.25.
#'
#'   If, for whatever reason, you want to do a simple per-capita division of the
#'   rate regardless of the body masses, enter `b = 0`. Or just divide it by the
#'   number of individuals.
#'
#'   Multiple rates can be entered, either as a vector or as part of a
#'   `respR::convert_rate` input for `tR`, but these should be separate
#'   measurements of rate of the same group. The output will contain separate
#'   individual rate vectors for each group rate, and the intercept (`a`) for
#'   each.
#'
#'   Units can be entered, e.g. `units = "mg/h"`, if the user wants to save
#'   these in the output for reference, however they do not affect calculations
#'   in any way. If a `respR::convert_rate` object is used for the rate (see
#'   below), the units are extracted from this and any other `units` input
#'   ignored.
#'
#' @section Sign of the rate: NOTE: both negative and positive rates can be
#'   entered. In respirometry experiments, rates are typically reported as
#'   positive values. These can be entered as is. In the case of
#'   `respR::convert_rate` objects, extracted rates will typically be
#'   *negative*, and these are left unchanged in the `split_rate` function. In
#'   `respR`, to be mathematically consistent (since they represent oxygen
#'   depletion), respiration rates are represented by negative slopes, and
#'   therefore rates returned as negative. You can enter the rate as the usually
#'   reported postive value, or as a negative: the function will work with
#'   either. Returned rates and intercept `a` will be identical in value, except
#'   for the sign. In effect, if you enter a negative rate you can simply ignore
#'   the signs for `a` and individual rates in the output.
#'
#' @section `respR` integration: For total rate (`tR`) the function accepts
#'   objects saved from the \code{respR}
#'   (\url{https://github.com/januarharianto/respR}) `convert_rate` function. In
#'   this case, the rate(s) and units are automatically extracted. However, if
#'   it contains a mass-specific rate (i.e. the rate has been adjusted in
#'   `respR::convert_rate` to a specific mass), **no conversion is done** and a
#'   warning is returned. Only absolute, that is non-mass specific, respiration
#'   rates should be divided in this way.
#'
#' @section Output: Output is a `list` object containing 7 elements:
#'
#'   `$a` = `a`, the intercept(s) in the mass~rate power equation. Determined by
#'   the function.
#'
#'   `$b` = `b`, the exponent in the mass~rate power equation. User entered.
#'
#'   `$tR` = total group rate. User entered.
#'
#'   `$masses` = specimen masses. User entered.
#'
#'   `$units` = units of the rate. User entered or extracted from `convert_rate`
#'   object. For information only, does not affect any calculations.
#'
#'   `$indiv.rates` = Primary output of interest, the group rate divided between
#'   individuals. This is a `list` object with each element a vector of
#'   individual rates associated with the `tR` at the same position. The sum of
#'   each vector should equal the associated `tR`. Extract via
#'   `$indiv.rates[[1]]` etc.
#'
#'   `$input` = origin of `tR` and `units`. Either `manual` entry or
#'   `convert_rate` object
#'
#' @usage split_rate(tR = NULL, masses, b = 0.75, units = NULL)
#'
#' @param tR numeric. Total group metabolic rate. Single value or vector of
#'   multiple measurements of rate of same group.
#' @param masses numeric. A vector of body masses of all individuals in group.
#' @param b numeric. Metabolic scaling exponent.
#' @param units string. Units of the rate. Extracted from `convert_rate` object
#'   or can be entered by the user. For information only, does not affect any
#'   calculations.
#'
#' @examples
#' # Single group rate
#' split_rate(tR = 500, masses = c(2, 3, 4, 5, 6), b = 0.75)
#'
#' # Multiple group rate
#' split_rate(tR = c(500,550,600), masses = c(2, 3, 4, 5, 6), b = 0.75)
#'
#' @author Nicholas Carey - \email{nicholascarey@gmail.com}
#'
#' @export

split_rate <- function(tR = NULL, masses, b = 0.75, units = NULL) {

  ## entry checks
  if (is.null(tR)) {
    stop("Enter tR - Total Group Rate")
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
    warning("Value of b is NEGATIVE. Typical b values are positive, between 0.66 and 1.
  Check this value is not the MASS-SPECIFIC scaling exponent.
  Result has been returned regardless.")
  }


# respR convert_rate object input -----------------------------------------

  if(class(tR) == "convert_rate"){
    input <- "convert_rate"


    if(!is.null(units))
      message("'units' input ignored. Rate units extracted from convert_rate object.")

    rate <- tR$output
    units <- tR$output.unit
    pattern <- c("*/ug", "*/mg", "*/g", "*/kg")

    if(any(sapply(pattern, function(x) grepl(x, units))))
      stop("Mass-specific units detected in convert_rate object.
  Cannot split rate by mass if rate is already corrected for mass!")
  }


# Numeric rate input ------------------------------------------------------

  if(is.numeric(tR))
    rate <- tR

  if(is.numeric(tR))
    input <- "manual"

  if(is.null(units))
    units <- "Undefined"

  ## calculate a
  a <- rate / (sum(masses^b))

  ## return scaled rates
  ## lapply in case multiple rates
  indiv_rates <- lapply(a, function(x) x * (masses^b))

  ## assemble output
  output <- list(
    a = numeric(0), b = numeric(0), tR = numeric(0),
    masses = vector(), units = character(), indiv.rates = vector(),
    input = character()
  )

  output[[1]] <- a
  output[[2]] <- b
  output[[3]] <- rate
  output[[4]] <- masses
  output[[5]] <- units
  output[[6]] <- indiv_rates
  output[[7]] <- input

  ## Assign class
  class(output) <- "split_rate"

  return(output)
}


