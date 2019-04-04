# Internal Functions ------------------------------------------------------

#' Print split_rate result
#'
#' @keywords internal
#' @importFrom glue glue
#' @importFrom utils head
#' @export
print.split_rate <- function(x, ...) {

  rates <- x$indiv.rates
  masses <- x$masses
  cat("\n# split_rate # -------------------------\n")
  cat("Rate Division Complete: \n")

  if(x$input == "convert_rate"){
    cat("--- respR::convert_rate object detected ---\n")
  }
  cat("\n")

  cat(glue("Intercept (a, calculated) :               ",
                 {x$a}))
  cat("\n")
  cat(glue("Metabolic Scaling Exponent (b, entered):  ",
                 {x$b}))
  cat("\n")
  cat(glue("Total Group Rate (tR, entered):           ",
                 {x$tR}))
  cat("\n")
    cat("Masses (masses, entered): \n")
    print(masses)
    cat("\n")

    cat("Individual rates (indiv.rates, calculated): \n")
    print(rates)

    cat("\n")
    cat(glue("Rate units: ", {x$units}))
    cat("\n")
    cat("\n")
}



# Internal Functions ------------------------------------------------------

#' Print eff_vol result
#'
#' @keywords internal
#' @importFrom glue glue
#' @importFrom utils head
#' @export
print.eff_vol <- function(x, ...) {

  cat("\n# eff_vol # ----------------------------\n")
  cat(glue("Effective Volume (L):                     ",
           {x}))
  cat("\n")
}



