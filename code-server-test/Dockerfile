FROM nvcr.io/nvidia/cuda:10.2-cudnn8-devel-ubuntu18.04
LABEL maintainer="CvlabKubernetesService:iwai"

ENV USER_NAME user
ENV UID 1000
RUN useradd -m -u ${UID} ${USER_NAME}

ENV HOME /home/${USER_NAME}
WORKDIR ${HOME}
ENV PYENV_ROOT ${HOME}/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN chsh -s /bin/bash
ENV SHELL=/bin/bash

RUN apt-get update -y \
 && apt-get install -y curl \
    wget \
    git \
    unzip \
    imagemagick \
    bzip2 \
    vim \
    libsm6 \
    libgl1-mesa-dev \
    build-essential \
    libssl-dev \
    dumb-init \
 && rm -rf /var/lib/apt/lists/* \
 && git clone https://github.com/pyenv/pyenv.git .pyenv \
 && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && pyenv install anaconda3-2020.02 \
 && pyenv global anaconda3-2020.02 \
 && pyenv rehash


RUN curl -fOL https://github.com/cdr/code-server/releases/download/v3.6.1/code-server_3.6.1_amd64.deb \
 && dpkg -i code-server_3.6.1_amd64.deb \
 && chown -R ${USER_NAME}: /home/${USER_NAME}/

USER ${UID}
EXPOSE 8888
ENTRYPOINT ["dumb-init", "/usr/bin/code-server", "--bind-addr", "0.0.0.0:8888", "--auth", "password", "--password", "aiueo", "--cert", "false", "."]
