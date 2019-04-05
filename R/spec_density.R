#' @title Calculate specimen density
#'
#' @description Given a wet mass (`wet_mass`) and buoyant mass (`buoy_mass`),
#'   this function calculates the density of the specimen. For species such as
#'   molluscs this can be used to determine the ratio of shell to tissue mass.
#'   It can also be used to calculate specimen volume for correcting the water
#'   volume of a respirometer (see \code{\link{eff_vol}}). The temperature
#'   (\code{t}) and salinity (\code{S}) at which the buoyant mass was determined
#'   are required (as is atmospheric pressure (`P`) which defaults to 1.013253
#'   bar, if not otherwise specified).
#'
#' @section Inputs: Inputs must be in SI units:
#'
#'   - `wet_mass` and `buoy_mass` in `kg`
#'
#'   - `t` in °C
#'
#'   - `S` in ppt
#'
#'   - `P` in bar (Defaults to 1.013253)
#'
#' @section Positively buoyant specimens: The function *should* work with
#'   positively buoyant specimens (i.e. less dense than water). Given a bouyant
#'   weight measured as buoyancy (i.e. lift force on a balance while in water),
#'   this can be entered as a negative value for `buoy_mass` and the function
#'   should return the correct density value. However, none of this has been
#'   tested.
#'
#' @usage spec_density(wet_mass = NULL, buoy_mass = NULL, t = NULL, S = NULL, P
#'   = 1.013253)
#'
#' @param wet_mass numeric (kg). Wet mass of specimen.
#' @param buoy_mass numeric (kg). Buoyant mass of specimen.
#' @param t numeric (°C). Water temperature at which `buoy_mass` was determined.
#' @param S numeric (ppt). Water salinity at which `buoy_mass` was determined.
#' @param P numeric (bar). Atmospheric pressure at which `buoy_mass` was
#'   determined. Defaults to 1.013253.
#'
#' @section Output: Output is a single numeric value for the density in kg/m^3.
#'
#' @author Nicholas Carey - \email{nicholascarey@gmail.com}
#'
#' @seealso eff_vol
#'
#' @importFrom marelac sw_dens
#'
#' @export

spec_density <- function(wet_mass = NULL,
                         buoy_mass = NULL,
                         t = NULL,
                         S = NULL,
                         P = 1.013253) {

  if (is.null(wet_mass))
    stop("wet_mass is required")
  if (is.null(buoy_mass))
    stop("buoy_mass is required")
  if (is.null(t))
    stop("Temperature is required")
  if (is.null(S))
    stop("Salinity is required")
  if (is.null(P))
    stop("Atm. Pressure is required")
  if (P != 1.013253)
    message("NOTE: Non-default P value being used")

    ## Calc density
    dens <- marelac::sw_dens(t = t, S = S, P = P) /
                          (1 - buoy_mass / wet_mass)

    ## Assign class
    class(dens) <- "spec_density"

    ## Return
    return(dens)
}

