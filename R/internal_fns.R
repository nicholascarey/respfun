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

  cat("\n")
  cat("Rate Division Complete: \n \n")
  cat(glue("Intercept (a, calculated) :                    ",
                 {x$a}))
  cat("\n")
  cat(glue("Metabolic Scaling Exponent (b, user entered):  ",
                 {x$b}))
  cat("\n")
  cat(glue("Total Group Rate (tR, user entered):           ",
                 {x$tR}))
  cat("\n")
  if(length(rates) <= 5){
    cat("Masses (masses, user entered): \n")
    print(masses)
  } else {
    cat("Masses (masses, user entered): \n")
    cat("(only first five shown) \n")
    print(head(masses,5))
    }
    cat("\n")

  if(length(rates) <= 5){
    cat("Individual Rates Calculated: \n")
    print(rates)
    } else {
    cat("Individual Rates (calculated, only first five shown): \n")
    print(head(rates,5))
    cat(glue("  ", {length(rates) - 5},
      " Additional rates calculated... \n"))
    cat("\n")
    }
    cat("\n")
    cat(glue("Rate units: ", {x$units}))
    cat("\n")
    cat("\n")
}



