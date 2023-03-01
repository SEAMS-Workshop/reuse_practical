


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
#' @examples
#' # TODO
lagged_cfr <- function(
  dt, lags
) {


}

# multi-panel cfr plotter (with different lags)
plot_lagged_cfr = function(data, lag, max_lag) with(data, {
    xaxt = ifelse(lag==max_lag,'s','n')
    xlim = c(date[max_lag+1], tail(date,1))
    cfr_lagged = tail(new_deaths_smoothed_per_million, -lag)/head(new_cases_smoothed_per_million, -lag)
    plot(date[-c(1:lag)], cfr_lagged,
         type='l',
         xlab='Case report date',
         ylab=paste0('CFR (lag = ',lag,')'),
         ylim=c(0.0, 0.4),
         xaxt=xaxt,
         xlim=xlim,
         cex.axis=1.5,
         cex.lab=1.5
    )
})
