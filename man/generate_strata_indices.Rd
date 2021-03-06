% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate-strata-indices.R
\name{generate_strata_indices}
\alias{generate_strata_indices}
\title{Generate a dataframe of the stratum indices}
\usage{
generate_strata_indices(jags_mod = NULL)
}
\arguments{
\item{jags_mod}{JAGS list generated by \code{run_model}}
}
\value{
Data frame of 4 variables:
  \item{Year}{Year of particular index}
  \item{Index}{Strata-weighted count index}
  \item{Q25}{2.5\% quantile of strata-weighted indices}
  \item{Q975}{97.5\% quantile of strata-weighted indices}
  \item{Stratum}{Name of the stratum}
}
\description{
\code{generate_strata_indices} creates a data frame of indices by year,
  factored by each stratum. These indicies can be used to generate
  trajectory plots of the species for each strata.
}
\examples{

\dontrun{
# Run a JAGS model analysis on a species
stratified_data <- stratify(bbs_data = fetch_bbs_data(), stratify_by = "bcr")
prepped_data <- prepare_jags_data(strat_data = stratified_data,
                                  species_to_run = "Wood Thrush",
                                  model = "slope")
mod <- run_model(jags_data = prepped_data)

#Generate the indices for each strata
strata_index <- generate_strata_indices(jags_mod = mod)
}

}
