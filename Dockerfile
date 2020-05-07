# Docker file for DSCI522_Group_301
# Authors: Fanli Zhou

#use rocker/tidyverse as the base image
FROM rocker/tidyverse
RUN apt-get update
RUN apt-get install r-base r-base-dev -y

# Install R Packages
RUN Rscript -e "install.packages('testthat')" 
RUN Rscript -e "install.packages('WGCNA')"
RUN Rscript -e "install.packages('gplots')"
RUN Rscript -e "install.packages('docopt')"

CMD ["/bin/bash"]
