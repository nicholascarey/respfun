#' @title Scale rate
#'
#' @description \code{scale_rate} - Scales a physiological rate (absolute or
#'   mass-specific) to a different mass, using a specified scaling exponent.
#'
#' @details Physiological rates typically scale allometrically with body mass.
#'   Therefore, it is usually not appropriate to directly compare rates between
#'   individuals of different size. Instead, if the scaling exponent of the rate
#'   (either absolute or mass-specific) is known, this can be used to scale
#'   rates to a common mass for comparison or statistical testing.
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
#' @section `respR` integration: For the `rate` input the function accepts
#'   objects saved (or piped) from the \code{respR}
#'   (\url{https://github.com/januarharianto/respR}) `convert_rate` function. In
#'   this case, the rate (absolute or mass-specific) is automatically extracted.
#'
#' @section Sign of the `rate`: NOTE: both negative and positive rates can be
#'   entered. In respirometry experiments, rates are typically reported as
#'   positive values. These can be entered as is. In the case of
#'   `respR::convert_rate` objects, extracted rates will typically be
#'   *negative*, and these are left unchanged in the `split_rate` function. In
#'   `respR`, to be mathematically consistent (since they represent oxygen
#'   depletion), respiration rates are represented by negative slopes, and
#'   therefore rates returned as negative. You can enter the `rate`` as the
#'   usually reported postive value, or as a negative: the function will work
#'   with either.
#'
#' @section Calculation: The scaled rate is calculated as: `((new mass/actual
#'   mass) ^ b) * rate`.
#'
#' @usage scale_rate(rate, mass, new.mass, b)
#'
#' @param rate numeric. The physiological rate to be scaled. Also accepts
#'   `respR::convert_rate` objects.
#' @param mass numeric. Original mass at which the `rate` was determined.
#' @param new.mass numeric. The new mass the `rate` is being scaled to.
#' @param b numeric. Scaling exponent. Must be the correct one for the `rate`
#'   used. See Details.
#'
#' @examples
#' ## Scaling a whole animal metabolic rate.
#' ## Here the rate is in mg/h, the metabolic scaling exponent is 0.72, and
#' ## we are scaling the rate to 0.5g.
#' scale_rate(0.1784, mass = 0.0847, new.mass = 0.5, b = 0.72)
#'
#' ## Result = 0.6406 mg/h at 0.5g
#'
#' ## Here the exact same calculation is done using the mass-specific
#' ## metabolic rate (0.1784/0.0847 = 2.1063 mg/h/g), and the mass-specific
#' ## metabolic scaling exponent (the negative difference from 1 of the
#' ## absolute scaling exponent).
#' scale_rate(2.1063, mass = 0.0847, new.mass = 0.5, b = -0.28)
#'
#' ## Result = 1.2812 mg/h/g at 0.5g
#'
#' ## We can see this is the same result as in the first example if it is
#' ## expressed as a mass-specific rate at the mass it is scaled to (0.5g):
#' ## 0.6406/0.5 = 1.2812 mg/h/g
#'
#' ## Obviously, scaling a rate to the same mass will give the same rate.
#' scale_rate(32.55, mass = 1, new.mass = 1, b = 0.75)
#'
#' ## And these demonstrate that isometric (i.e. purely linear) scaling of
#' ## an absolute rate will do a simple multiplication/division.
#' scale_rate(5, mass = 0.5, new.mass = 1, b = 1)
#' scale_rate(20, mass = 2, new.mass = 1, b = 1)
#'
#' ## Isometric scaling when the rate is expressed as a mass-specific rate
#' ## is represented by a scaling exponent of zero. In this case the
#' ## mass-specific rate will be the same at any other body mass.
#' scale_rate(4.77, mass = 2.5, new.mass = 18.3, b = 0)
#'
#' @author Nicholas Carey - \email{nicholascarey@gmail.com}
#'
#' @export

scale_rate <- function(rate = NULL, mass = NULL, new.mass = NULL, b = NULL) {

  if(class(rate) == "convert_rate"){
    rate <- rate$output
    message("--- respR::convert_rate object detected ---\n")}

  #if(length(c(rate, mass, new.mass, b)) != 4) stop("All four inputs are required.")
  if(!any(c(methods::hasArg(rate),
            methods::hasArg(mass),
            methods::hasArg(new.mass),
            methods::hasArg(b))))
    stop("All four inputs are required.")

  new.rate <- ((new.mass / mass) ^ b) * rate

  return(new.rate)
}

rate = 1
mass = 2
new.mass = 3
b = 0.75
