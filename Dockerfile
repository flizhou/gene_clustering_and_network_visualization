# Docker file for gene_clustering_and_network_visualization
# Authors: Fanli Zhou

#use rocker/tidyverse as the base image
FROM rocker/tidyverse
RUN apt-get update
RUN apt-get install r-base r-base-dev -y

# Install R Packages
RUN Rscript -e "install.packages('testthat')" 
RUN Rscript -e "install.packages('BiocManager')"
RUN Rscript -e "BiocManager::install('WGCNA')"
RUN Rscript -e "install.packages('gplots')"
RUN Rscript -e "install.packages('docopt')"

CMD ["/bin/bash"]
