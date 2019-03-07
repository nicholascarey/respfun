# Internal Functions ------------------------------------------------------

#' Print split_rate result
#'
#' @keywords internal
#' @importFrom glue glue
#' @importFrom utils head
#' @export
print.split_rate <- function(x, ...) {
  cat("Split Complete: \n \n")
  cat(glue("Intercept (a, calculated) :                    ",
                 {round(x$a, 2)}))
  cat("\n")
  cat(glue("Metabolic Scaling Exponent (b, user entered):  ",
                 {x$b}))
  cat("\n")
  cat(glue("Total Group Rate (tR, user entered):           ",
                 {round(x$tR,2)}))
  cat("\n")
  cat("\n")
  # cat(glue("Individual Rates:",
  #                {x$indiv.rates}))

  rates <- round(x$indiv.rates,2)

  if(length(rates) <= 5){
    cat("Individual Rates Calculated: \n")
    print(rates)
    } else {
    cat("Individual Rates Calculated (only first five shown): \n")
    print(head(rates,5))
    cat("\n")
    cat(glue("  ", {length(rates) - 5},
      " Additional Rates Calculated... \n"))
    }
}



