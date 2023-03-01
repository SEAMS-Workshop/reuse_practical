
# fetch the arguments from the command line, other than the script name
.args <- commandArgs(trailingOnly = TRUE)

d <- readRDS(.args[1])
tarfile <- tail(.args, 1)

lags <- d[lag != 0, unique(lag)]
xlim <- d[lag != 0][!is.na(cfr), range(date)]

# multi-panel cfr plotter (with different lags)
plot_lagged_cfr = function(data, lag, xlim, show.xat = FALSE) with(data, {
    plot(date, cfr,
         type = 'l',
         xlab = 'Case report date',
         ylab = paste0('CFR (lag = ',lag,')'),
         ylim = c(0.0, 0.4),
         xaxt = if (show.axt) 's' else 'n',
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
for (lag in head(lags, -1)) {
    plot_lagged_cfr(d, lag, xlim)
}
plot_lagged_cfr(d, tail(lags, 1), xlim, TRUE)
dev.off()
