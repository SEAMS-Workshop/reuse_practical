
# fetch the arguments from the command line, other than the script name
.args <- commandArgs(trailingOnly = TRUE)

d <- readRDS(.args[1])
tarfile <- tail(.args, 1)

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

# Multi-panel CFR figure with changing death lag
lag_range = seq(1,25,6)
max_lag = max(lag_range)

png(tarfile, width=2400, height=2400, res=240)
par(mfrow=c(length(lag_range),1), mar=c(0.1,4.5,1,1), oma=c(3,0,0,0),las=1)
for (lag in lag_range) {
    plot_lagged_cfr(d, lag, max_lag)
}
dev.off()
