# Lagged Case Fatality Ratio (CFR) Computation  

## Installation

Use `remotes::install_github('SEAMS-Workshop/reuse_practical')` to install the package. This package depends on `data.table`, which will be installed if not already available.

## Functionality

The core functionality is in `lagged_cfr()`. Briefly, it receives a data for cases and deaths by date, the desired lags, and then computes $CFR = deaths(t+lag)/cases(t)$ returning a `data.table` of the results. Use `?lagged_cfr` to see the full details.

## Analysis

This package also includes the analysis associated with XYZ. You can make a copy of this analysis with the following commands:

```
fpath <- system.file("analysis", package = "seamsCFR")
npath <- "mynewdir"
dir.create(npath, recursive = TRUE)
file.copy(list.files(fpath, full.names = TRUE), npath, recursive = TRUE)
```

Then you can run that analysis by navigating to that directory and invoking `$ make` at the command prompt. Note: this will download the Our World in Data snapshot, which is roughly 70 Mb.
