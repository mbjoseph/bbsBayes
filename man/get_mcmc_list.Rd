% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get-mcmc-list.R
\name{get_mcmc_list}
\alias{get_mcmc_list}
\title{Obtain MCMC list from jagsUI object}
\usage{
get_mcmc_list(jags_mod = NULL)
}
\arguments{
\item{jags_mod}{JAGS object returned by \code{run_model}}
}
\value{
List containing:
\item{mcmc_list}{MCMC samples produced by rjags}
\item{sims_list}{Vectorized posterior samples produced by jagsUI}
}
\description{
\code{get_mcmc_list} will return both the \code{mcmc.list} object
  and the \code{sims.list} object from jagsUI. \code{mcmc.list}
  is a list of the MCMC samples generated by the rjags library,
  and \code{sims.list} is a vectorized version of \code{mcmc.list}
  produced by the jagsUI library.
}
\examples{

\dontrun{
# Run a JAGS model analysis on a species
stratified_data <- stratify(bbs_data = fetch_bbs_data(), stratify_by = "bcr")
prepped_data <- prepare_jags_data(strat_data = stratified_data,
                                  species_to_run = "Wood Thrush",
                                  model = "slope")
mod <- run_model(jags_data = prepped_data)

# Get the posterior samples from that model
samples <- get_mcmc_list(jags_mod = mod)
}

}
