FROM openanalytics/r-base

LABEL maintainer "Remi Julien <contact@dcid-consulting.fr>"

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.1

# basic shiny functionality
RUN R -e "install.packages(c('shiny', 'rmarkdown', 'magrittr'), repos='https://cloud.r-project.org/')"

# install dependencies of the app
RUN R -e "install.packages('leaflet', repos='https://cloud.r-project.org/')"

# copy the app to the image
RUN mkdir /root/leaflet-hello
COPY leaflet-hello /root/leaflet-hello

COPY Rprofile.site /usr/local/lib/R/etc/
#COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/leaflet-hello', host='0.0.0.0', port=3838)"]
