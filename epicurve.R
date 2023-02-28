rm(list=ls())
require(data.table)

d = fread('owid-rsa.csv')
#owid_rsa = d[iso_code=='ZAF',]

png('Rplot.png', width=2400, height=1600, res=240)
par(mfrow=c(3,1), mar=c(2,4,1,1))
plot(d$date, d$new_cases_per_million, type='l', xlab='Date', ylab='Reported cases')
lines(d$date, d$new_cases_smoothed_per_million, type='l', col='red')

plot(d$date, d$new_deaths_per_million, type='l', xlab='Date', ylab='Reported deaths')
lines(d$date, d$new_deaths_smoothed_per_million, type='l', col='red')

#plot(d$date, d$new_deaths_smoothed_per_million/d$new_cases_smoothed_per_million, type='l', xlab='Date', ylab='CFR')
d$cfr = d$new_deaths_smoothed_per_million/d$new_cases_smoothed_per_million
plot(d$date, d$cfr, type='l', xlab='Date', ylab='CFR')
dev.off()

d$date = as.Date(d$date) # plotting won't work unless dates are cast as dates
death_lag = 15
d$cfr_lagged = NA
d$cfr_lagged[-c(1:death_lag)] = tail(d$new_deaths_smoothed_per_million, -death_lag)/head(d$new_cases_smoothed_per_million, -death_lag)

png('Rplot1.png', width=2400, height=500, res=150)
plot(d$date, d$cfr_lagged, type='l', xlab='Date', ylab='CFR with lag')
dev.off()

plot_lagged_cfr = function(data, lag, max_lag) {
    xaxt = ifelse(lag==max_lag,'s','n')
    xlim=c(data$date[max_lag+1], tail(data$date,1))
    cfr_lagged = tail(data$new_deaths_smoothed_per_million, -lag)/head(data$new_cases_smoothed_per_million, -lag)
    print(xlim)
    print(data$date[lag+1])
    plot(data$date[-c(1:lag)], cfr_lagged, type='l', xlab='Case report date', ylab=paste0('CFR (lag = ',lag,')'), ylim=c(0.0, 0.4), xaxt=xaxt, xlim=xlim, cex.axis=1.5, cex.lab=1.5)
}

lag_range = seq(1,25,6)
max_lag = max(lag_range)
png('Rplot2.png', width=2400, height=2400, res=240)
par(mfrow=c(length(lag_range),1), mar=c(0.1,4.5,1,1), oma=c(3,0,0,0),las=1)
for (lag in lag_range) {
    plot_lagged_cfr(d, lag, max_lag)
    print(lag)
}
dev.off()