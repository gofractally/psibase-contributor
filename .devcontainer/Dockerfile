FROM ghcr.io/gofractally/psibase-ubuntu-2004-builder:latest

# Install psibase
WORKDIR /root
RUN mkdir psibase
WORKDIR /root/psibase

# Clone the specified github repo
RUN git clone https://github.com/gofractally/psibase.git .

# Make the build folder
RUN mkdir build \
    && git submodule update --init --recursive

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
' >> /root/.bashrc
