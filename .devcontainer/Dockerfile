FROM multi-arch-2204 as stage1

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
export HOST_IP=$(ip route | awk "/default/ { print \$3 }") \
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

# Add some tools
ADD psinode/scripts /usr/local/bin/
RUN chmod -R 0700 /usr/local/bin/

# Add configuration files
RUN mkdir -p $PSINODE_PATH/psinode_db
COPY psinode/configs/$DEFAULT_PSINODE_CONFIG $PSINODE_PATH/psinode_db/config

# Update path
ENV PATH=/root/psibase/build/psidk/bin:$PATH
