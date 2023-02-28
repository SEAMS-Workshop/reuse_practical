# SEAMS Participants Note

This version of the analysis leans into some additional workspace tools and organization that you may wish to consider.

Most scientific work entails a series of steps, where steps depend on the output of previous stages (and the code that executes them), and when some inputs change, we wish to re-run the downstream analyses.

There are many tools designed to address that general problem. In this branch, we demonstrate using a tool that has been around a long time: gnu[make](https://www.gnu.org/software/make/manual/make.html).

It's also common to have multiple branches of an overall analysis, and to want to have intermediate outputs in addition to final results figures (e.g. for tables or as data products in a publication). To do that approach, it's useful to break up scripts to have essentially a 1-script, 1-output mapping.

It's also common to want to perform the same analysis, but on different input data and stored to a different output location. To enable that approach, you generally want scripts to take arguments (e.g. for the input files they use, for the output file they create).

While not strictly necessary for this example work, the revisions in this branch show how to use the base R tools to accomplish this. Other languages have similar libraries or idioms for capturing arguments and acting on them.

Overall, these changes makes the approach more flexible (you can do the analysis for most any ISO3n country code) and makes it a bit more portable (your collaborators can locally define where they want to put things).

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
