#' Stratify raw Breeding Bird Survey data
#'
#' Assigns each bird count data point and each route a strata
#'   based on its geographic location and the stratification
#'   as specified by the user.
#'
#' @param by String argument of stratification type.
#'   Options are "state", "bcr", "latlong", "bbs_cws", "bbs_usgs"
#' @param sample_data Should just sample data (just Wood Thrush) be used?
#'   Defaults to FALSE
#' @param quiet Should progress bars be suppressed?
#' @param bbs_data Raw BBS data saved as a list of 3 data frames.
#'   Not necessary if you have already run \code{fetch_bbs_data}
#' @param stratify_by Deprecated in favour of 'by'
#'
#' @return Large list (3 elements) consisting of:
#'   \item{bird_strat}{Dataframe of stratified bird data}
#'   \item{route_strat}{Dataframe of stratified route data}
#'   \item{species_strat}{Dataframe of stratified species data}
#'   \item{by}{Argument used for stratification}
#'
#' @examples
#'
#' \dontrun{
#'
#' # Download BBS data and stratify by USGS BBS stratifications.
#' fetch_bbs_data()
#' data_strat <- stratify(by = "bbs_usgs")
#'
#' # Stratify by Bird Conservation Regions only
#' data_strat <- stratify(by = "bcr")
#'
#' # Stratify by CWS BBS stratifications
#' data_strat <- stratify(by = "bbs_cws")
#'
#' # Stratify by State/Province/Territory only
#' data_strat <- stratify(by = "state")
#'
#' # Stratify by blocks of 1 degree of latitude X 1 degree of longitude
#' data_strat <- stratify(by = "latlong")

#' }

#' @importFrom progress progress_bar
#' @importFrom rappdirs app_dir
#' @export
#'

stratify <- function(by = NULL,
                     sample_data = FALSE,
                     bbs_data = NULL,
                     quiet = FALSE,
                     stratify_by = NULL)
{
  if (isFALSE(is.null(stratify_by)))
  {
    message("Argument \"stratify_by\" has been deprecated in favour of \"by\"")
    by <- stratify_by
  }

  if(isFALSE(is.element(by, c("state", "bcr", "latlong", "bbs_cws", "bbs_usgs"))))
  {
    stop("Invalid stratification specified"); return(NULL)
  }

  bbs_dir <- app_dir(appname = "bbsBayes")

  if (isTRUE(sample_data))
  {
    bbs_data <- load_sample_data()
  } else if (is.null(bbs_data))
  {
    if(isFALSE(file.exists(paste0(bbs_dir$data(), "/bbs_raw_data.RData"))))
    {
      stop("No BBS data downloaded. Please use fetch_bbs_data() first.")
    }
  }

  if (!isTRUE(quiet))
  {
    pb <- progress::progress_bar$new(
      format = "Stratifying data   [:bar] :percent eta: :eta",
      clear = FALSE,
      total = 8,
      width = 80)
    pb$tick(0)
  }

  if (isFALSE(sample_data) & is.null(bbs_data))
  {
    load(file = paste0(bbs_dir$data(), "/bbs_raw_data.RData"))
  }
  if (!isTRUE(quiet)){pb$tick()}

  bird <- bbs_data$bird; if (!isTRUE(quiet)){pb$tick()}
  route <- bbs_data$route; if (!isTRUE(quiet)){pb$tick()}

  if (by == "bbs_usgs")
  {
    route[,"strat_name"] <- paste(route[,"Country"],
                                  route[,"St_Abrev"],
                                  route[,"BCR"],
                                  sep = "-")
  }else if (by == "state")
  {
    route[,"strat_name"] <- paste(route[,"St_Abrev"],
                                  sep = "")
  }else if (by == "bcr")
  {
    route[,"strat_name"] <- paste("BCR",
                                  route[,"BCR"],
                                  sep = "")
  }else if (by == "latlong")
  {
    route[,"strat_name"] <- paste(trunc(route[,"Latitude"]),
                                  trunc(route[,"Longitude"]),
                                  sep = "_")
  }else if (by == "bbs_cws")
  {
    # Combine all BCR 7
    route[which(route$BCR == 7),"St_Abrev"] <- "BCR7"
    route[which(route$BCR == 7), "Route"] <- 7
    bird[which(bird$BCR == 7), "Route"] <- 7
    route[which(route$BCR == 7), "statenum"] <- 777
    bird[which(bird$BCR == 7), "statenum"] <- 777

    # Combine NS and PEI
    route[which(route$State == "Nova Scotia"), "State"] <- "Nova Scotia Prince Edward Island"
    route[which(route$State == "Prince Edward Island"), "State"] <- "Nova Scotia Prince Edward Island"
    route[which(route$State == "Nova Scotia Prince Edward Island"), "St_Abrev"] <- "NSPE"
    route[which(route$St_Abrev == "NSPE"), "statenum"] <- 765
    bird[which(bird$statenum == 65), "statenum"] <- 765
    bird[which(bird$statenum == 75), "statenum"] <- 765

    route[,"strat_name"] <- paste(route[,"Country"],
                                  route[,"St_Abrev"],
                                  route[,"BCR"],
                                  sep = "-")

  }; if (!isTRUE(quiet)){pb$tick()}

  route[,"rt.uni"] <- paste(route[,"statenum"],route[,"Route"],sep = "-"); if (!isTRUE(quiet)){pb$tick()} # regenerates the rt.uni value with newly defined combined states
  bird[,"rt.uni"] <- paste(bird[,"statenum"],bird[,"Route"],sep = "-"); if (!isTRUE(quiet)){pb$tick()}

  route[,"rt.uni.y"] <- paste(route[,"statenum"],route[,"Route"],route[,"Year"],sep = "-"); if (!isTRUE(quiet)){pb$tick()}  # regenerates the rt.uni.y value with newly defined combined states
  bird[,"rt.uni.y"] <- paste(bird[,"statenum"],bird[,"Route"],bird[,"Year"],sep = "-"); if (!isTRUE(quiet)){pb$tick()}


  return(list(bird_strat = bird,
              route_strat = route,
              species_strat = bbs_data$species,
              stratify_by = by))
}
