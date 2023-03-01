require(seamsCFR)

# fetch the arguments from the command line, other than the script name
.args <- if (interactive()) c(
  "data/raw/owid-covid-data.csv"
) else commandArgs(trailingOnly = TRUE)

# which are source data and target output figure
d <- data.table::fread(.args[1])[
  order(date), .(date,
    cases_raw = new_cases_per_million,
    cases = new_cases_smoothed_per_million,
    deaths_raw = new_deaths_per_million,
    deaths = new_deaths_smoothed_per_million
  ), by=iso_code
]
tarfile <- tail(.args, 1)
# we use `tail()` here, because we have adopted a pattern where the last
# argument is always the target file. now, if we add additional arguments,
# we don't have to change picking out the target file

# compute lagged CFRs
d <- seamsCFR::lagged_cfr(d, seq(0, 21, 7))

# save the data in the R native format
# plotting will happen in a different script
saveRDS(d, tarfile)
