rm(list=ls())
require(data.table)

d = fread('owid-rsa.csv')
#owid_rsa = d[iso_code=='ZAF',]

par(mfrow=c(3,1), mar=c(2,4,1,1))
plot(d$date, d$new_cases_per_million, type='l', xlab='Date', ylab='Reported cases')
lines(d$date, d$new_cases_smoothed_per_million, type='l', col='red')

plot(d$date, d$new_deaths_per_million, type='l', xlab='Date', ylab='Reported deaths')
lines(d$date, d$new_deaths_smoothed_per_million, type='l', col='red')

#plot(d$date, d$new_deaths_smoothed_per_million/d$new_cases_smoothed_per_million, type='l', xlab='Date', ylab='CFR')
d$cfr = d$new_deaths_smoothed_per_million/d$new_cases_smoothed_per_million
plot(d$date, d$cfr, type='l', xlab='Date', ylab='CFR')

d$date = as.Date(d$date) # plotting won't work unless dates are cast as dates
death_lag = 15
d$cfr_lagged = NA
d$cfr_lagged[-c(1:death_lag)] = tail(d$new_deaths_smoothed_per_million, -death_lag)/head(d$new_cases_smoothed_per_million, -death_lag)

plot(d$date, d$cfr_lagged, type='l', xlab='Date', ylab='CFR with lag')

death_lag = 7
d$cfr_lagged = NA
d$cfr_lagged[-c(1:death_lag)] = tail(d$new_deaths_smoothed_per_million, -death_lag)/head(d$new_cases_smoothed_per_million, -death_lag)

plot(d$date, d$cfr_lagged, type='l', xlab='Date', ylab='CFR with lag')

death_lag = 30
d$cfr_lagged = NA
d$cfr_lagged[-c(1:death_lag)] = tail(d$new_deaths_smoothed_per_million, -death_lag)/head(d$new_cases_smoothed_per_million, -death_lag)

plot(d$date, d$cfr_lagged, type='l', xlab='Date', ylab='CFR with lag')
