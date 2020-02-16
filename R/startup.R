# Library load message
#' @importFrom utils packageDescription

.onAttach<- function (lib, pkg){
  if(interactive()){
    vers <- packageDescription("respfun", fields = "Version")
    start_msg <- paste("
======================================================================
respfun", vers, "
======================================================================

Please cite respfun using the following:

Nicholas Carey, 2020. respfun - Respirometry Utilities R package.
https://doi.org/10.5281/zenodo.3668903

Visit this site for help documentation:

    https://nicholascarey.github.io/respfun

======================================================================")

    packageStartupMessage(start_msg)
  }
}
