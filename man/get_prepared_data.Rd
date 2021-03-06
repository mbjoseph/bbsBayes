% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get-prepared-data.R
\name{get_prepared_data}
\alias{get_prepared_data}
\title{Get the prepared species dataset used for JAGS}
\usage{
get_prepared_data(jags_data = NULL)
}
\arguments{
\item{jags_data}{List of JAGS input data produced by
\code{prepare_jags_data}}
}
\value{
Data frame of 9 variables:
  \item{count}{Number of species observed for this route run}
  \item{strat}{Numerical factors of the stratum}
  \item{obser}{Numerical factor of the observer}
  \item{year}{Numerical factor of the year}
  \item{firstyr}{1 if this was the observer's first year, 0 otherwise}
  \item{strat_name}{Name of the stratum}
  \item{route}{Route that this count was taken on}
  \item{rYear}{Year this count was conducted}
  \item{yearscale}{Scaled year}
}
\description{
\code{get_prepared_data} returns a data frame of the data that
  was used for JAGS. This is the subsetted data based on the
  selected species to model, with zero counts filled in
  and any other route/strata filter applied.
}
\examples{
  \dontrun{

    # Prepare the data for a given species
    jags_prep <- prepare_jags_data(strat_data = stratified_data,
                                   species_to_run = "Wood Thrush",
                                   model = "gam")

    # Obtain the reassembled data frame for the data sent to JAGS
    prepped_data <- get_prepared_data(jags_data = jags_prep)
  }

}
