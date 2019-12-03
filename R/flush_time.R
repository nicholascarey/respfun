#' @title Flush time
#'
#' @description Calculates the time taken to flush a respirometer with new
#'   water.
#'
#' @details `flush_time` calculates the time taken to flush a respirometer with
#'   new water. It requires the volume of the respirometer (in L) and the flow
#'   rate (in L/s) of the input of new water.
#'
#'   The function calculates the time in seconds to exchange the proportion of
#'   water described by the `tolerance` input, which by default is `0.99`. That
#'   is, the function calculates the time taken to exchange 99% of the water.
#'   The `tolerance` is required because of *mixing* during the exchange.
#'   Because old and new water are always mixing, the exchange of water is
#'   asymptotic: you can never replace 100% of the old water; there will be an
#'   ever decreasing proportion of it remaining (down to the final molecule,
#'   assuming perfect mixing). For all practical purposes, a `tolerance` value
#'   of `0.99` is sufficient. It is also important to note that the function
#'   takes no account of any shared reservoir of water, that is when the 'old'
#'   water is flushed out into the source of the 'new' water.
#'
#' @usage flush_time(volume, flow, tolerance)
#'
#' @param volume numeric. Volume of the respirometer in L.
#' @param flow numeric. Flow rate of the input of new water in L/s.
#' @param tolerance numeric. Proportion of the `volume` to be exchanged. See
#'   Details.
#'
#' @return Time in seconds for the `tolerance` proportion of the `volume` to be
#'   exchanged.
#'
#' @examples
#' ## How long to exchange 99% of a 10L respirometer when the input pump has
#' ## a flow rate of 0.15 L/s
#' flush_time(volume = 10, flow = 0.15, tolerance = 0.99)
#'
#' @importFrom glue glue
#'
#' @author Nicholas Carey - \email{nicholascarey@gmail.com}
#'
#' @export

flush_time <- function(volume, flow, tolerance = 0.99) {

  ## proportion flushed per s
  if(tolerance == 1) stop("`tolerance` cannot be equal to 1.")
  if(tolerance == 0) stop("`tolerance` cannot be equal to 0.")
  if(tolerance < 0 || tolerance > 1) stop("`tolerance` must be between 1 and 0.")

  ## proportion flushed per s
  prop_flushed_per_s <- flow/volume

  ## proportion of original volume remaining every s
  prop_remaining <- c(1-prop_flushed_per_s)
  i <- 2
  while (prop_remaining[i-1] > (1-tolerance)) {
    prop_remaining[i] <- prop_remaining[i-1]*(1-prop_flushed_per_s)
    i <- i+1
  }

  ## calc time
  time <- length(prop_remaining)

  ## message
  cat(glue::glue("Time to flush {tolerance * 100}% of {volume}L at {flow} L/s is: {time} seconds."))

  ## return
  return(invisible(time))

}
