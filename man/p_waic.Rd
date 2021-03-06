% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/p-waic.R
\name{p_waic}
\alias{p_waic}
\title{Calculate effective number of parameters}
\usage{
p_waic(jags_data = NULL, jags_mod = NULL, pointwise = FALSE)
}
\arguments{
\item{jags_data}{Data prepared by \code{prepare_jags_data}, used
for input to the JAGS model}

\item{jags_mod}{JAGS list generated by \code{run_model}}

\item{pointwise}{If set to \code{TRUE}, a data frame is returned
that contains the pointwise LPPD for each count. Defaults
to \code{FALSE}}
}
\value{
Data frame of pointwise pWAIC by count if \code{pointwise}
  is set to \code{TRUE}. Double precision numerical value of pWAIC if
  \code{pointwise} is set to \code{FALSE}.
}
\description{
\code{p_waic} calculates effective number of parameters. This is
  used as a bias adjustment factor in the calculation of WAIC
  in the function \code{waic}.
}
\details{
NOTE: in order to calculated pWAIC, the model MUST track the parameter
  "lambda". In species that are data-rich, such as Wood Thrush,
  this produces extremely large JAGS objects, and takes up a considerable
  amount of memory when simulating with \code{run_model}
}
\examples{
\dontrun{
# Run a JAGS model analysis on a species
stratified_data <- stratify(bbs_data = fetch_bbs_data(), stratify_by = "bcr")
prepped_data <- prepare_jags_data(strat_data = stratified_data,
                                  species_to_run = "Wood Thrush",
                                  model = "slope")
mod <- run_model(jags_data = prepped_data)

  # Output the pWAIC value
  p_waic(jags_data = prepped_data,
         jags_mod = mod)
}

}
