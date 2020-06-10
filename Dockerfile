FROM alerta/alerta-web:latest

ARG ROOT_PASSWORD

# Set maintainer field
LABEL maintainer="Frekel - antispam@vanderstad.nl"

# Switch to root for plugin installation
USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    vim && \
    apt-get -y clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install the given plugins
COPY install-webhooks.sh /app/install-webhooks.sh
COPY webhooks.txt /app/webhooks.txt
RUN /app/install-webhooks.sh

# Set root password
RUN echo "root:${ROOT_PASSWORD}" | chpasswd

RUN usermod -d /home/alerta -aG sudo -m alerta

# Switch to alerta for plugin installation
USER 1001
