
# Gene Clustering and Network Visualization

The purpose of this project is to analyzes gene expression data from
microarray samples and identify clusters of highly correlated genes to
visualize gene networks. The results are used to guide downstream
experiments. The project follows the Weighted correlation network
analysis
[WGCNA](https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/index.html)
(B and S 2005; Langfelder P 2008).

Data and results are not included in this repo.

## Usage

To replicate the analysis, clone this GitHub repository, install the
[dependencies](#dependencies) listed below, and run the following
commands at the command line/terminal from the root directory of this
project:

    make all

To reset the repo to a clean state, with no intermediate or results
files, run the following command at the command line/terminal from the
root directory of this project:

    make clean

## Dependencies

  - R 3.6.1 and R packages:
      - knitr==1.27.2
      - gplots==3.0.1
      - readr==1.3.1  
      - dplyr==0.8.3
      - WGCNA==1.69

# References

<div id="refs" class="references">

<div id="ref-Zhang">

B, Zhang, and Horvath S. 2005. “A General Framework for Weighted Gene
Co-Expression Network Analysis.” *Statistical Applications in Genetics
and Molecular Biology* 4 (17).

</div>

<div id="ref-Langfelder">

Langfelder P, Horvath S. 2008. “WGCNA: An R Package for Weighted
Correlation Network Analysis.” *BMC Bioinformatics*.
<https://doi.org/9:559>.

</div>

</div>
