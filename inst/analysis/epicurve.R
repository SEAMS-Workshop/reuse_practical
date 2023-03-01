
require(data.table)

# fetch the arguments from the command line, other than the script name
.args <- commandArgs(trailingOnly = TRUE)

# which are source data and target output figure
d <- readRDS(.args[1])
tarfile <- tail(.args, 1)

# Figure with case, death, and non-lagged CFR panels
with(subset(d, lag == 0), {
    png(tarfile, width=2400, height=1600, res=240)
    par(mfrow=c(3,1), mar=c(2,4,1,1))

    plot(date, cases_raw, type='l', xlab='Date', ylab='Reported cases')
    lines(date, cases, type='l', col='red')

    plot(date, deaths_raw, type='l', xlab='Date', ylab='Reported deaths')
    lines(date, deaths, type='l', col='red')

    plot(date, cfr, type='l', xlab='Date', ylab='CFR')

    dev.off()
})
