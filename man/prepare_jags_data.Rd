% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prepare-jags-data.R
\name{prepare_jags_data}
\alias{prepare_jags_data}
\title{Wrangle data to use for JAGS input}
\usage{
prepare_jags_data(strat_data = NULL, species_to_run = NULL,
  model = NULL, n_knots = NULL, min_year = NULL, max_year = NULL,
  min_n_routes = 3, min_max_route_years = 3,
  min_mean_route_years = 1, strata_rem = NULL, quiet = FALSE, ...)
}
\arguments{
\item{strat_data}{Large list of stratified data returned by \code{stratify()}}

\item{species_to_run}{Character string of the English name of the species to run}

\item{model}{Character string of model to be used.
Options are "slope", "firstdiff", "gam", "gamye.}

\item{n_knots}{Number of knots to be used in GAM function}

\item{min_year}{Minimum year to keep in analysis}

\item{max_year}{Maximum year to keep in analysis}

\item{min_n_routes}{Minimum routes per strata where species has been observed.
Defaults to 3}

\item{min_max_route_years}{Minimum number of years with non-zero observations
of species on at least 1 route. Defaults to 3}

\item{min_mean_route_years}{Minimum average of years per route with the
species observed. Defaults to 1.}

\item{strata_rem}{Strata to remove from analysis. Defaults to NULL}

\item{quiet}{Should progress bars be suppressed?}

\item{...}{Additional arguments}
}
\value{
List of data to be used in JAGS, including:
  \item{model}{The model to be used in JAGS}
  \item{ncounts}{The number of counts containing useful data for the species}
  \item{nstrata}{The number of strata used in the analysis}
  \item{ymin}{Minimum year used}
  \item{ymax}{Maximum year used}
  \item{nonzeroweight}{Proportion of routes in each strata with species obervation}
  \item{count}{Vector of counts for the species}
  \item{strat}{Vector of strata to be used in the analysis}
  \item{osber}{Vector of observers}
  \item{year}{Vector of years for each count}
  \item{firstyr}{Vector of indicator variables as to whether an observer was a first year}
  \item{nobservers}{Total number of observers}
  \item{fixedyear}{Median of all years, included only with slope model}
  \item{nknots}{Number of knots to use for smooting functions, included only with GAM}
  \item{X.basis}{Basis function for n smoothing functions, included only with GAM}
}
\description{
\code{prepare_jags_data} subsets raw BBS data by selected species and
   and wrangles stratified data for use as input to run JAGS models.
}
\examples{

\dontrun{
# Download BBS data and stratify it
bbs_data <- fetch_bbs_data()
stratified_data <- stratify(bbs_data, stratify_by = "bbs_usgs")

# Prepare the stratified data for use in a JAGS model.
# This particular instance prepares for the Slope BBS model.
data_jags_slope <- prepare_jags_data(strat_data = stratified_data,
                               species_to_run = "Spruce Grouse",
                               model = "slope")

# Prepare data for use the First Difference BBS model.
data_jags_firstdiff <- prepare_jags_data(strat_data = stratified_data,
                               species_to_run = "Mallard",
                               model = "firstdiff")

# You can also specify the GAM model, with an optional number of
# knots to use for the GAM basis.
# By default, the number of knots will be equal to the floor
# of the total unique years for the species / 5
data_jags <- prepare_jags_data(strat_data = stratified_data,
                               species_to_run = "Wood Thrush",
                               model = "gam",
                               n_knots = 9)

# For users that may want to use their own model, you can choose not
# to specify a model, and prepare_jags_model will just prepare the
# minimum amount of data
data_jags <- prepare_jags_data(strat_data = stratified_data,
                               species_to_run = "Wood Thrush"

# Capitalization and punctuation matter (for now)
# This code will produce an error.
data_jags <- prepare_jags_data(strat_data = stratified_data,
                               species_to_run = "Eastern whippoorwill"
                               model = "slope")
# But this code will be fine
data_jags <- prepare_jags_data(strat_data = stratified_data,
                               species_to_run = "Eastern Whip-poor-will"
                               model = "slope")
}

}
