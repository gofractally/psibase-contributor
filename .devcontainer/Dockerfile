FROM ghcr.io/gofractally/psibase-ubuntu-2004-builder:latest

# Use bash shell, prettify terminal, git completion
ENV SHELL /bin/bash
SHELL ["/bin/bash", "-c"]
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

# Install psibase
RUN mkdir /root/psibase
WORKDIR /root/psibase
RUN git clone https://github.com/gofractally/psibase.git . && \
    git submodule update --init --recursive
