#' @title Calculates the Q10 temperature relationship
#'
#' @description The `q_ten` function calculates any of the five parameters in
#'   the Q10 temperature relationship for physiological or chemical processes.
#'   Q10 describes the ratio by which a physiological or chemical rate changes
#'   with a 10°C increase in temperature.
#'
#' @details The function has five inputs, of which four should be entered and
#'   one left NULL. The NULL input is the parameter to be calculated. For
#'   example, two rates (`rate1`, `rate2`) determined at two temperatures (`t1`,
#'   `t2`) can be used to calculate the `q10`. Alternatively, a `q10` and a rate
#'   at a particular temperature can be used to predict a rate at a different
#'   temperature. See examples.
#'
#'   See also the function `Q10` in the
#'   [`respirometry`](https://cran.r-project.org/web/packages/respirometry/index.html)
#'    package by Matthew Birk, which has additional functionality.
#'
#' @param rate1 numeric. The rate at temperature 1 (`t1`).
#' @param rate2 numeric. The rate at temperature 2 (`t2`).
#' @param t1 numeric (°C). The *lower* temperature at which `rate1` was
#'   determined.
#' @param t2 numeric (°C). The *upper* temperature at which `rate2` was
#'   determined.
#' @param q10 numeric (°C). The Q10, the ratio by which a rate changes with a
#'   10°C increase in temperature.
#'
#' @examples
#' ## Determine Q10 from two rates at two known temperatures
#' q_ten(rate1 = 2, rate2 = 3, t1 = 10, t2 = 15, q10 = NULL)
#'
#' ## Predict a rate at a higher temperature using a known Q10
#' q_ten(rate1 = 2, rate2 = NULL, t1 = 10, t2 = 15, q10 = 2.25)
#'
#' ## Predict a rate at a lower temperature using a known Q10
#' q_ten(rate1 = NULL, rate2 = 3, t1 = 10, t2 = 15, q10 = 2.25)
#'
#' ## Predict the lower temperature at which rate1 will occur
#' ## using a known Q10
#' q_ten(rate1 = 2, rate2 = 3, t1 = NULL, t2 = 15, q10 = 2.25)
#'
#' ## Predict the upper temperature at which rate2 will occur
#' ## using a known Q10
#' q_ten(rate1 = 2, rate2 = 3, t1 = 10, t2 = NULL, q10 = 2.25)
#'
#' @author Nicholas Carey - \email{nicholascarey@gmail.com}
#'
#' @seealso respirometry::Q10
#'
#' @export

q_ten <- function(rate1 = NULL,
                  rate2 = NULL,
                  t1 = NULL,
                  t2 = NULL,
                  q10 = NULL){
  ## checks
  if(!is.null(rate1) && !is.null(rate2) && !is.null(t1) && !is.null(t2) && !is.null(q10)) stop("One input must be empty.")
  if(length(c(rate1, rate2, t1, t2, q10)) != 4) stop("Four inputs are required.")

  ## calc q10
  if(is.null(q10)) result <- (rate2/rate1)^(10/(t2 - t1))

  ## calc rate1
  if(is.null(rate1)) result <- rate2/(q10^((t2 - t1)/10))

  ## calc rate2
  if(is.null(rate2)) result <- (q10^((t2 - t1)/10))*rate1

  ## calc t1
  if(is.null(t1)) result <- -1 * (log(rate2/rate1, base = q10)*10 - t2)

  ## calc t2
  if(is.null(t2)) result <- log(rate2/rate1, base = q10)*10 + t1

  return(result)

}
