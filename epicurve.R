#!/usr/bin/Rscript

#install.packages('data.table') # if needed

# setup environment
rm(list=ls())
require(data.table)
fig_dir = './fig/'
dir.create(fig_dir)

# load data and convert date field
d = fread('./data/processed/owid-rsa.csv')
d$date = as.Date(d$date)

# multi-panel cfr plotter (with different lags)
plot_lagged_cfr = function(data, lag, max_lag) {
    xaxt = ifelse(lag==max_lag,'s','n')
    xlim = c(data$date[max_lag+1], tail(data$date,1))
    cfr_lagged = tail(data$new_deaths_smoothed_per_million, -lag)/head(data$new_cases_smoothed_per_million, -lag)
    plot(data$date[-c(1:lag)], cfr_lagged,
         type='l',
         xlab='Case report date',
         ylab=paste0('CFR (lag = ',lag,')'),
         ylim=c(0.0, 0.4),
         xaxt=xaxt,
         xlim=xlim,
         cex.axis=1.5,
         cex.lab=1.5
    )
}

# Figure with case, death, and non-lagged CFR panels
png(paste0(fig_dir,'cases_deaths_cfr.png'), width=2400, height=1600, res=240)
par(mfrow=c(3,1), mar=c(2,4,1,1))
plot(d$date, d$new_cases_per_million, type='l', xlab='Date', ylab='Reported cases')
lines(d$date, d$new_cases_smoothed_per_million, type='l', col='red')

plot(d$date, d$new_deaths_per_million, type='l', xlab='Date', ylab='Reported deaths')
lines(d$date, d$new_deaths_smoothed_per_million, type='l', col='red')

crude_cfr = d$new_deaths_smoothed_per_million/d$new_cases_smoothed_per_million
plot(d$date, crude_cfr, type='l', xlab='Date', ylab='CFR')
dev.off()

# Multi-panel CFR figure with changing death lag
lag_range = seq(1,25,6)
max_lag = max(lag_range)

png(paste0(fig_dir,'cases_deaths_cfr_range.png'), width=2400, height=2400, res=240)
par(mfrow=c(length(lag_range),1), mar=c(0.1,4.5,1,1), oma=c(3,0,0,0),las=1)
for (lag in lag_range) {
    plot_lagged_cfr(d, lag, max_lag)
}
dev.off()
