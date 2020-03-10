FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
LABEL maintainer="CvlabKubernetesService:iwai"

ENV USER_NAME iwai
ENV USER_NAME_UID 1000
RUN useradd -m -u ${USER_NAME_UID} ${USER_NAME}

ENV HOME  /home/${USER_NAME}
ENV PYENV_ROOT /.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN apt-get update \
 && apt-get install -y curl \
    git \
    unzip \
    imagemagick \
    bzip2 \
    vim \
    libsm6 \
    libgl1-mesa-dev \
    build-essential \
    libssl-dev \
 && git clone https://github.com/pyenv/pyenv.git .pyenv \
 && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && pyenv install anaconda3-4.4.0 \
 && pyenv global anaconda3-4.4.0 \
 && pyenv rehash \
 && pip install --upgrade pip \
 && pip install opencv-python==3.4.7.28 \
 && pip install tensorflow-gpu==1.13.1 --ignore-installed --user \
 && pip install addict \
 && pip install keras \
 && pip install torch torchvision \
 && pip install tqdm \
 && pip install torchsummary \
 && pip install progressbar \
 && pip install jupyterlab==2.0.0 \
 && jupyter labextension install @lckr/jupyterlab_variableinspector