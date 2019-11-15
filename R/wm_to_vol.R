#' @title Convert a mass of water to a volume
#'
#' @description \code{wm_to_vol} converts a water mass to a water volume.
#'   Requires temperature, salinity and atmospheric pressure. These are used to
#'   calculate the density, which is then used to convert the mass to volume.
#'
#' @section Inputs: Inputs must be in SI units:
#'
#'   - `mass` in `kg`
#'
#'   - `t` in °C
#'
#'   - `S` in ppt
#'
#'   - `P` in bar (Defaults to 1.013253)
#'
#' @section Output: Output is a single numeric value for the water volume in L.
#'
#' @usage wm_to_vol(mass, t, S, P)
#'
#' @param mass numeric (kg). Water mass to convert to volume
#' @param t numeric (°C). Temperature
#' @param S numeric (ppt). Salinity
#' @param P numeric (bar). Atmospheric pressure. Defaults to 1.013253
#'
#' @examples
#' ## Should return 0.9767414
#' wm_to_vol(mass = 1, t = 23, S = 35)
#'
#' @author Nicholas Carey - \email{nicholascarey@gmail.com}
#'
#' @importFrom marelac sw_dens
#'
#' @export

wm_to_vol <- function(mass = NULL, t = NULL, S = NULL, P = 1.013253) {

  ## checks
  if (is.null(mass))
    stop("Mass is required")
  if (is.null(t))
    stop("Temperature is required")
  if (is.null(S))
    stop("Salinity is required")
  if (is.null(P))
    stop("Atm. Pressure is required")
  if (P != 1.013253)
    message("NOTE: Non-default P value being used")

  ## Get water density
  dens <- marelac::sw_dens(t = t, S = S, P = P)/1000

  ## Convert mass to volume
  vol <- mass / dens

  ## Return
  return(vol)
}
