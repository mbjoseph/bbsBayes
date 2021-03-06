% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/load-bbs-data.R
\name{load_bbs_data}
\alias{load_bbs_data}
\title{Load Breeding Bird Survey dataset into R Session}
\usage{
load_bbs_data()
}
\value{
Large list (3 elements) consisting of:
\item{bird}{Data frame of sample bird point count data per route, per year}
\item{route}{Data frame of sample yearly route data}
\item{species}{Sample list of North American bird species}
}
\description{
\code{load_bbs_data} loads the raw, unstratified BBS data into the current R session.
The data must have been previously fetched using the \code{fetch_bbs_data} function.
Note that this function is not necessary to run a Bayesian analysis of BBS data;
calling \code{stratify} will return stratifed BBS data in a list of data frames.
}
