
require(data.table)

# fetch the arguments from the command line, other than the script name
.args <- commandArgs(trailingOnly = TRUE)

d <- readRDS(.args[1])
tarfile <- tail(.args, 1)

lags <- d[lag != 0, unique(lag)]
xlim <- d[lag != 0][!is.na(cfr), range(date)]

# multi-panel cfr plotter (with different lags)
plot_lagged_cfr = function(data, tarlag, xlim, show.xaxt = FALSE) with(data, {
    plot(date, cfr,
         type = 'l',
         xlab = 'Case report date',
         ylab = paste0('CFR (lag = ',tarlag,')'),
         ylim = c(0.0, 0.4),
         xaxt = if (show.xaxt) 's' else 'n',
         xlim = xlim,
         cex.axis = 1.5,
         cex.lab = 1.5
    )
})

png(tarfile, width=2400, height=2400, res=240)
par(
  mfrow = c(length(lags), 1),
  mar = c(0.1, 4.5, 1, 1),
  oma = c(3, 0, 0, 0), las = 1
)
for (tarlag in head(lags, -1)) {
    plot_lagged_cfr(d[lag == tarlag], tarlag, xlim)
}
plot_lagged_cfr(d[lag == tail(lags, 1)], tail(lags, 1), xlim, TRUE)
dev.off()
