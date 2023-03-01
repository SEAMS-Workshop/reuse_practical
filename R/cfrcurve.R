
.inner_cfr <- function(lag, sub.dt) {
  if (lag == 0) {
    tmp <- sub.dt[,
      .(date, lag = 0, cfr = deaths/cases),
    ]
  } else {
    tmp <- sub.dt[
      order(date),
      .(date = head(date, -lag), lag = lag, cfr = tail(deaths, -lag)/head(cases, -lag))
    ]
  }
  return(merge(tmp, sub.dt, by="date", all = TRUE)[!is.na(lag)])
}

#' Compute requested lagged CFRs
#'
#' @param dt a [data.table::as.data.table()] coerceable object. Should result in
#' columns `date`, `cases`, `deaths` and possibly others. The other columns will
#' be used as grouping variables, except those matching the pattern
#' `date|cases|deaths`.
#'
#' @param lags a positive integer vector; the lags to compute
#'
#' @return a [data.table::data.table()], with columns `date`, `lag`, `cfr`, and
#' any other columns coerced (other than `cases` and `deaths`) from the original
#' `dt`.
#'
#' @export
#' @importFrom data.table as.data.table rbindlist
#' @examples
#' require(seamsCFR)
#' require(data.table)
#' dt <- data.table(date = 1:100, cases = runif(100))
#' dt[, deaths := cases * (runif(.N)*.1 + .1)]
#' df <- lagged_cfr(dt, c(0, 10))
lagged_cfr <- function(
  dt, lags
) {
  dt <- as.data.table(dt)
  bycols <- names(dt)[!data.table::like(names(dt), c("date|cases|deaths"))]
  return(dt[, rbindlist(lapply(lags, .inner_cfr, sub.dt = .SD)), by = bycols])
}
