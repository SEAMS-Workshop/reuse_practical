
# fetch the arguments from the command line, other than the script name
.args <- commandArgs(trailingOnly = TRUE)

# which are source data and target output figure
d <- readRDS(.args[1])
tarfile <- tail(.args, 1)

# Figure with case, death, and non-lagged CFR panels
with(d, {
    png(tarfile, width=2400, height=1600, res=240)
    par(mfrow=c(3,1), mar=c(2,4,1,1))
    
    plot(date, new_cases_per_million, type='l', xlab='Date', ylab='Reported cases')
    lines(date, new_cases_smoothed_per_million, type='l', col='red')

    plot(date, new_deaths_per_million, type='l', xlab='Date', ylab='Reported deaths')
    lines(date, new_deaths_smoothed_per_million, type='l', col='red')
    
    plot(date, crude_cfr, type='l', xlab='Date', ylab='CFR')

    dev.off()
})