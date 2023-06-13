FROM ghcr.io/gofractally/psibase-builder-ubuntu-2004:b70111acc20bdc6990e756a855fdbf428112c059 as stage1

# Install deps
RUN export DEBIAN_FRONTEND=noninteractive   \
    && apt-get update                       \
    && apt-get install -yq                  \
        apt-transport-https                 \
        curl                                \
        gdb                                 \
        gnupg2                              \
        iproute2                            \
        unzip                               \
        wget                                \
        xz-utils                            \
    && apt-get clean -yq                    \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
# Prometheus:
RUN useradd --no-create-home --shell /bin/false prome
RUN useradd --no-create-home --shell /bin/false node_exporter
COPY prometheus/prometheus.yml /etc/prometheus/prometheus.yml
ARG PROMVERSION=prometheus-2.43.0+stringlabels.linux-amd64
RUN mkdir -p /var/lib/prometheus    \
    && cd /var/lib/prometheus       \
    && wget https://github.com/prometheus/prometheus/releases/download/v2.43.0%2Bstringlabels/${PROMVERSION}.tar.gz \
    && tar xf ${PROMVERSION}.tar.gz          \
    && rm ${PROMVERSION}.tar.gz              \
    && cp ${PROMVERSION}/prometheus /usr/local/bin/ \
    && cp ${PROMVERSION}/promtool /usr/local/bin/ \
    && chown prome:prome /usr/local/bin/prometheus \
    && chown prome:prome /usr/local/bin/promtool \
    && cp -r ${PROMVERSION}/consoles /etc/prometheus \
    && cp -r ${PROMVERSION}/console_libraries /etc/prometheus \
    && chown -R prome:prome /etc/prometheus/consoles \
    && chown -R prome:prome /etc/prometheus/console_libraries

# Tools (websocat & grok) to help export data to prometheus

ARG WSC_VERSION=websocat.x86_64-unknown-linux-musl

RUN cd /root \
 && wget https://github.com/fstab/grok_exporter/releases/download/v1.0.0.RC5/grok_exporter-1.0.0.RC5.linux-amd64.zip \
 && unzip grok_exporter-*.zip \
 && rm grok_exporter-*.zip \
 && ln -s /root/grok_exporter-1.0.0.RC5.linux-amd64/grok_exporter /usr/local/bin/grok_exporter \
 && wget https://github.com/vi/websocat/releases/download/v1.11.0/${WSC_VERSION} \
 && mv ${WSC_VERSION} /usr/local/bin/websocat \
 && chmod a+x /usr/local/bin/websocat


# Grafana:
RUN wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key
RUN echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | tee -a /etc/apt/sources.list.d/grafana.list
RUN export DEBIAN_FRONTEND=noninteractive   \
    && apt-get update                       \
    && apt-get install -yq                  \
        grafana                             \
    && apt-get clean -yq                    \
    && rm -rf /var/lib/apt/lists/*

# Use bash shell
ENV SHELL /bin/bash

# Need bash shell for ansi quotes
SHELL ["/bin/bash", "-c"]

# Some nice-to-haves when using git inside the container
# (prettify terminal, git completion)
RUN echo $'\n\
parse_git_branch() {\n\
  git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \\(.*\\)/ (\\1)/"\n\
} \n\
export PS1="\u@\h \W\[\\033[32m\\]\\$(parse_git_branch)\\[\\033[00m\\] $ "\n\
if [ -f ~/.git-completion.bash ]; then\n\
  . ~/.git-completion.bash\n\
fi\n\
 \n\
alias ll="ls -alF"\n\
alias ls="ls --color=auto"\n\
export GATEWAY_IP=$(ip route | awk "/default/ { print \$3 }") \
' >> /root/.bashrc

# Install psibase
RUN mkdir -p /root/psibase
WORKDIR /root/psibase
RUN git clone https://github.com/gofractally/psibase.git . && \
    git submodule update --init --recursive

ARG DEFAULT_PSINODE_CONFIG=dev.config
# Set env variables
ENV PSINODE_PATH=/root/psibase

# Expose ports
## Psinode
EXPOSE 8080
## Prometheus
EXPOSE 9090
## Grafana
EXPOSE 3000

# Add some tools
ADD psinode/scripts /usr/local/bin/
COPY run-admin-dashboards.sh /usr/local/bin/
RUN chmod -R 0700 /usr/local/bin/

# Add configuration files
RUN mkdir -p $PSINODE_PATH/psinode_db
COPY psinode/configs/$DEFAULT_PSINODE_CONFIG $PSINODE_PATH/psinode_db/config
ADD grok_exporter/patterns /etc/grok_exporter/
COPY grok_exporter/grok-exporter.yml /root/grok-exporter.yml

COPY grafana/psinode-datasources.yaml /usr/share/grafana/conf/provisioning/datasources/psinode-datasources.yaml
COPY grafana/psinode-dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/psinode-dashboard.yaml
RUN chmod 644 /usr/share/grafana/conf/provisioning/datasources/psinode-datasources.yaml && \
    chmod 644 /usr/share/grafana/conf/provisioning/dashboards/psinode-dashboard.yaml && \
    chown -R grafana:grafana /usr/share/grafana/conf/provisioning/datasources/psinode-datasources.yaml && \
    chown -R grafana:grafana /usr/share/grafana/conf/provisioning/dashboards/psinode-dashboard.yaml
ADD grafana/dashboards /var/lib/grafana/dashboards
COPY grafana/grafana-psinode.ini /etc/grafana/grafana-psinode.ini

# Update path
ENV PATH=/root/psibase/build/psidk/bin:$PATH
