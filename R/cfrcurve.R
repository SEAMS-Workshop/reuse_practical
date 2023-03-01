
#' Compute requested lagged CFRs
#'
#' @param dt a [data.table::as.data.table()] coerceable object. Should result in
#' columns `date`, `cases`, `deaths` and possibly others. The other columns will
#' be used as grouping variables.
#'
#' @param lags a positive integer vector; the lags to compute
#'
#' @return a [data.table::data.table()], with columns `date`, `lag`, `cfr`, and
#' any other columns coerced (other than `cases` and `deaths`) from the original
#' `dt`.
#'
#' @export
#' @importFrom data.table as.data.table
#' @examples
#'
lagged_cfr <- function(
  dt, lags
) {
  dt <- as.data.table(dt)
  bycols <- setdiff(names(dt), c("date", "cases", "deaths"))
# cfr_lagged = tail(new_deaths_smoothed_per_million, -lag)/head(new_cases_smoothed_per_million, -lag)
  return(dt[, .SD[order(date), .(date, lag = 0, cfr = deaths/cases)], by=bycols])
}
