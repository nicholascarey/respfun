# Internal Functions ------------------------------------------------------

#' Print split_rate result
#'
#' @keywords internal
#' @export
#' @importFrom glue glue
#' @importFrom utils head
print.split_rate <- function(x, ...) {
  rates <- x$indiv.rates
  masses <- x$masses
  cat("\n# split_rate # -------------------------\n")
  cat("Rate Division Complete: \n")
  if(x$input == "convert_rate"){
    cat("--- respR::convert_rate object detected ---\n")
    cat("\n")
    cat("Total Group Rate(s) ($tR, entered via convert_rate input):\n")
    print(x$tR)
  }
  if(x$input == "manual"){
    cat("\n")
    cat("Total Group Rate(s) ($tR, entered):           \n")
    print(x$tR)}
  cat("\n")
  cat("Metabolic Scaling Exponent ($b, entered):  \n")
  print(x$b)
  cat("\n")
  cat("Masses ($masses, entered): \n")
  print(masses)
  cat("\n")
  cat("Intercept(s) ($a, calculated) :               \n")
  print(x$a)
  cat("\n")
  cat("Individual rates ($indiv.rates, calculated): \n")
  print(rates)
  cat(glue::glue("Rate units: ", {x$units}))
  cat("\n")
  cat("\n")
}



