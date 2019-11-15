#' @title Scale rate
#'
#' @description \code{scale_rate} - Scales a physiological rate (absolute or
#'   mass-specific) to a different mass, using a specified scaling exponent.
#'
#' @details Physiological rates typically scale allometrically with body mass.
#'   Therefore, it is usually not appropriate to directly compare rates between
#'   individuals of different size. Instead, if the scaling exponent of the rate
#'   (either absolute or mass-specific) is known, this can be used to scale
#'   rates to a common mass for comparison.
#'
#'   `scale_rate` scales an absolute (i.e. whole animal) or mass-specific
#'   physiological rate (e.g. metabolic, feeding) to a specified body mass,
#'   using a specified scaling exponent. **Important note**: the scaling
#'   exponent should be the correct one for the rate used. For example, in the
#'   case of metabolism, absolute (whole animal) rates typically scale at values
#'   between +0.67 to +1 (i.e. between two-thirds and one), and mass-specific
#'   rates between -0.33 to 0. Therefore, make sure you use the correct scaling
#'   exponent for the `rate` as entered, INCLUDING THE -/+ SIGN.
#'
#'   The scaled rate is calculated as `((new mass/actual mass) ^ b) * rate`.
#'
#' @usage scale_rate(rate, mass, new.mass, b)
#'
#' @param rate numeric. The physiological rate to be scaled.
#' @param mass numeric. Original mass of specimen.
#' @param new.mass numeric. The new mass the rate to scale the rate to.
#' @param b numeric. Scaling exponent. Must be the correct one for the rate -
#'   see Details.
#'
#' @return numeric. New mass-specific rate at chosen mass
#'
#' @examples
#' ## Scaling a whole animal metabolic rate. Here the rate is in mg/h, the
#' ## metabolic scaling exponent is 0.72, and we are scaling the rate to 1g.
#' ## Should result in new scaled rate of 1.055
#' scale_rate(0.1784, mass = 0.0847, new.mass = 1, b = 0.72)
#'
#' ## Here the exact same calculation is done using the mass-specific
#' ## metabolic rate (in mg/h/g of body mass), and the metabolic scaling
#' ## exponent is the mass-specific one (the negative difference from 1 of
#' ## the absolute scaling exponent).
#' scale_rate(2.1062, mass = 0.0847, new.mass = 1, b = -0.28)
#'
#' ## Obviously, scaling a rate to the same mass will give the same rate.
#' scale_rate(32.55, mass = 1, new.mass = 1, b = 0.75)
#'
#' ## And these demonstrate that isometric (i.e. purely linear) scaling of
#' ## a rate will do a simple multiplication/division.
#' scale_rate(5, mass = 0.5, new.mass = 1, b = 1)
#' scale_rate(20, mass = 2, new.mass = 1, b = 1)
#'
#' @author Nicholas Carey - \email{nicholascarey@gmail.com}
#'
#' @export

scale_rate <- function(rate = NULL, mass = NULL, new.mass = NULL, b = NULL) {

  if(length(c(rate, mass, new.mass, b)) != 4) stop("All four inputs are required.")

  new.rate <- ((new.mass / mass) ^ b) * rate

  return(new.rate)
}
