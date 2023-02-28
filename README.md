# Case Fatality Ratio (CFR) Analysis  
  
## Overview  
This project performs a basic CFR analysis for COVID-19 in South Africa. CFR during the pandemic was dynamic due to both changes in case detection, in medical care, and in existing immunity.  
  
Estimating CFR, however, is tricky for a number of reasons. We don't generally know which reported cases resulted in deaths, so instead we have to compare the two time series and apply an appropriate time lag (date of death is often much later than case report date).  
  
Here we use Our World in Data COVID-19 time series to visualize time-varying CFR estimates using a range of potential case-to-death time lags.  
  
NB: Although we focus on South Africa, the raw dataset includes all countries. Changing the locale can be done by editing the data.sh  
script.  
  
## Inputs  
Our World in Data COVID-19 time series in CSV format. As of 27 Feb 2023, about 70 MB.  
  
## Outputs  
Visualizations (two multi-panel png figures) showing
- Cases, deaths, and non-lagged CFR over time, and
- CFR over time for a range of lag values.  
  
## Code  
- **data<span>.sh</span>:** Fetch raw data, and prune it down to a much smaller ("processed") CSV containing only the data needed for the analysis.  
Usage: `./data.sh` or `bash data.sh`
- **epicurve.R:** Read in the processed CSV produced by data<span>.sh</span> and create visualizations in the fig directory.
Usage: `./epicurve.R` or `Rscript epicurve.R`

## License
GNU GPL v3.0 or later
