#' Generate continental plot of index trajectories.
#'
#' Generates the trajectory plot of continental indices.
#'
#' @param indices Dataframe of yearly indices produced by
#'   \code{generate_cont_indices}
#' @param min_year Minimum year to plot
#' @param max_year Maximum year to plot
#' @param species Species name to be added onto the plot
#' @param title_size Specify font size of plot title. Defaults to 20
#' @param axis_title_size Specify font size of axis titles. Defaults to 18
#' @param axis_text_size Specify font size of axis text. Defaults to 16
#'
#' @return ggplot of continental indices
#'
#' @importFrom ggplot2 ggplot theme element_blank element_line
#' labs geom_line geom_ribbon aes element_text
#'
#' @examples
#'
#' \dontrun{
#'
#' # Run a JAGS model analysis on a species
#' stratified_data <- stratify(bbs_data = fetch_bbs_data(), stratify_by = "bcr")
#' prepped_data <- prepare_jags_data(strat_data = stratified_data,
#'                                   species_to_run = "Wood Thrush",
#'                                   model = "slope")
#' mod <- run_model(jags_data = prepped_data)
#'
#' #Generate the continental indices weighted by each strata
#' cont_indices <- generate_cont_indices(jags_mod = mod)
#'
#'
#' # After generating continental indices, plot them
#' plot_cont_indices(indices = cont_indices, species = "Wood Thrush")
#'
#'
#' # You can specify to only plot a subset of years using min_year and max_year
#' # Plots indices from 1990 onward
#' c_plot <- plot_cont_indices(indices = cont_indices,
#'                             min_year = 1990,
#'                             species = "Wood Thrush")
#' #Plot up indicess up to the year 2000
#' c_plot <- plot_cont_indices(indices = cont_indices,
#'                             max_year = 2000,
#'                             species = "Wood Thrush")
#' #Plot indicess between 1970 and 2010
#' c_plot <- plot_cont_indices(indices = cont_indices,
#'                             min_year = 1970,
#'                             max_year = 2010,
#'                             species = "Wood Thrush")
#'
#' }
#'
#' @export
#'
plot_cont_indices <- function(indices = NULL,
                            min_year = NULL,
                            max_year = NULL,
                            species = "",
                            title_size = 20,
                            axis_title_size = 18,
                            axis_text_size = 16)
{
  Year <- NULL
  rm(Year)
  Index <- NULL
  rm(Index)
  Q25 <- NULL
  rm(Q25)
  Q975 <- NULL
  rm(Q975)

  if (!is.null(min_year))
  {
    indices <- indices[which(indices$Year >= min_year), ]
  }

  if(!is.null(max_year))
  {
    indices <- indices[which(indices$Year <= max_year), ]
  }

  p <- ggplot2::ggplot() +
    ggplot2::theme(panel.grid.major = ggplot2::element_blank(),
          panel.grid.minor = ggplot2::element_blank(),
          panel.background = ggplot2::element_blank(),
          axis.line = ggplot2::element_line(colour = "black"),
          plot.title = ggplot2::element_text(size = title_size),
          axis.title = ggplot2::element_text(size = axis_title_size),
          axis.text = ggplot2::element_text(size = axis_text_size)) +
    ggplot2::labs(title = paste(species, " Annual indices: Continental", sep = ""),
         x = "Year",
         y = "Index") +
    ggplot2::geom_line(data = indices, ggplot2::aes(x = Year, y = Index)) +
    ggplot2::geom_ribbon(data = indices, ggplot2::aes(x = Year, ymin = Q25, ymax = Q975), alpha = 0.12)

  return(p)
}
