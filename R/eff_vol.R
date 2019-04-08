#' @title Calculate the effective volume of a respirometer
#'
#' @description Calculate the effective volume of a respirometer.
#'
#' @details Adjusts the known water volume of an aquatic respirometer (or
#'   respirometer loop) for the volume of the specimen. This can be entered
#'   either as a straight displacement volume of the specimen for simple
#'   subtraction (`spec_vol`), or as a mass (`spec_mass`), in which case the
#'   `spec_density` is required to calculate the displacement volume. The
#'   `spec_density` can be entered as a value in kg/m^3. Alternatively, it can
#'   be assumed the specimen is the same density as the water (this is the case
#'   if it is neutrally buoyant). This can be entered as the `spec_density`
#'   value, for example typical seawater density is around 1026 kg/m^3.
#'   Alternatively it can be calculated internally, in which case temperature
#'   (`t`) and salinity (`S`) are required, along with atmospheric pressure
#'   (`P`). Note, that since `P` has a negligible effect on water density within
#'   the typical ranges experienced at sea level, the default of 1.013253 bar is
#'   used unless otherwise specified.
#'
#' @section Inputs: Inputs must be in SI units:
#'
#'   - `resp_vol` and `spec_vol` in `L`
#'   - `spec_mass` in `kg`
#'   - `spec_density` in `kg/m^3`
#'   - `t` in °C
#'   - `S` in ppt
#'   - `P` in bar (Defaults to 1.013253)
#'
#' @section Output: Output is a single numeric value for the effective volume in
#'   L.
#'
#' @usage eff_vol(resp_vol = NULL, spec_vol = NULL, spec_mass = NULL,
#'   spec_density = NULL, t = NULL, S = NULL, P = 1.013253)
#'
#' @param resp_vol numeric (L). Volume of the respirometer or loop.
#' @param spec_vol numeric (L). Displacement volume of the specimen. Enter
#'   either this or `spec_mass`.
#' @param spec_mass numeric (kg). Mass of the specimen. Enter either this or
#'   `spec_vol`.
#' @param spec_density numeric (kg/m^3). Density of the specimen. Optional. Used to convert `spec_mass` to a volume.
#' @param t numeric (°C). Water temperature. Optional. Used to calculate density if
#'   `spec_density` is left NULL.
#' @param S numeric (ppt). Water salinity. Optional. Used to calculate density if
#'   `spec_density` is left NULL.
#' @param P numeric (bar). Atmospheric pressure. Optional. Used to calculate density if
#'   `spec_density` is left NULL. Defaults to 1.013253.
#'
#' @examples
#' ## Simple displacement volume subtraction.
#' eff_vol(resp_vol = 1, spec_vol = 0.1)
#'
#' ## Mass & density to volume subtraction.
#' eff_vol(resp_vol = 1, spec_mass = 0.2, spec_density = 1026)
#'
#' ## Mass, with t, S used to calculate water density
#' eff_vol(resp_vol = 1, spec_mass = 0.2, t = 10, S = 35)
#'
#' @author Nicholas Carey - \email{nicholascarey@gmail.com}
#'
#' @importFrom marelac sw_dens
#'
#' @seealso spec_density
#'
#' @export

eff_vol <- function(resp_vol = NULL,
                    spec_vol = NULL,
                    spec_mass = NULL,
                    spec_density = NULL,
                    t = NULL,
                    S = NULL,
                    P = 1.013253){

  if(!is.numeric(resp_vol))
    stop("Enter a respirometer volume - resp_vol")
  if(!is.numeric(spec_vol) && !is.numeric(spec_mass))
    stop("Either a spec_mass or spec_vol must be entered (but not both)")
  if(is.numeric(spec_vol) && is.numeric(spec_mass))
    stop("Only one of spec_mass or spec_vol should be entered.")
  if(is.numeric(spec_mass)){
    if(is.numeric(spec_density) && (is.numeric(t) || is.numeric(S)))
      message("NOTE: spec_density used for calculations. t and S inputs IGNORED.")
    if(!is.numeric(spec_density) && (!is.numeric(t) || !is.numeric(S)))
      stop("A spec_mass input requires either a density, or t and S inputs with which to calculate water density.")
    }

  ## simple volume diff
  if(is.numeric(spec_vol)){
    message("Calculating Effective Volume as resp_vol minus spec_vol. \n All other inputs IGNORED. ")
    effect_vol <- resp_vol - spec_vol}

  ## using density
  if(!is.numeric(spec_vol)){

    if(is.null(spec_density))
      spec_density <- marelac::sw_dens(t = t, S = S, P = P)

    effect_vol <- resp_vol - (spec_mass * (spec_density/1000))
    }

  ## set class
  class(effect_vol) <- "eff_vol"

  ## return
  return(effect_vol)

  }


