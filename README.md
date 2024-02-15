# Cost effectiveness analysis for an AMR point-of-care test

## Background

## Repository structure

* `dashboard/`: a simple [dashboard](https://athowes.github.io/amr-poct/dashboard/) built using `shiny`.
* `docs/`: the HTML output files which are rendered to a GitHub pages [website](https://athowes.github.io/amr-poct/).
* `notebooks/`: an `rmarkdown` [notebook](https://athowes.github.io/amr-poct/model) describing the model.
* `build.R`: contains functions used to generate the notebook and dashboard (generated into the `docs/` folder).

## Quick start

### System requirements

1. The [R programming language](https://www.r-project.org/) (use of the [RStudio IDE](https://posit.co/products/open-source/rstudio/) is recommended).
2. The following R packages, which may be installed via:

```r
package_names <- c("shiny", "shinylive", "rmarkdown", "purrr", "dplyr", "tidyr", "ggplot2", "colorspace")
install.packages(package_names)
```

### Reproducing and changing the analysis

To reproduce the analysis, take the following steps:

1. Clone the GitHub repository to a directory of your choice using

```sh
gh repo clone athowes/amr-poct
```

2. Run `build.R` to generate the notebook and dashboard. 

The RMarkdown file for the notebook `notebooks/model.Rmd` can be edited as desired.
The dashboard can be edited by altering the files `dashboard/app.R` and `dashboard/functions.R`.

### Session information

The session information used to develop this code is as follows:

```
R version 4.3.2 (2023-10-31)
Platform: aarch64-apple-darwin20 (64-bit)
Running under: macOS Sonoma 14.2.1

Matrix products: default
BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib 
LAPACK: /Library/Frameworks/R.framework/Versions/4.3-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.11.0

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

time zone: Europe/London
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] colorspace_2.1-0 ggplot2_3.4.4    tidyr_1.3.0      dplyr_1.1.4      purrr_1.0.2      rmarkdown_2.25   shinylive_0.1.1  shiny_1.8.0
```
