FROM nvcr.io/nvidia/cuda:11.1-cudnn8-devel-ubuntu18.04
LABEL maintainer="CvlabKubernetesService:iwai"

ENV USER_NAME user
ENV UID 1000
RUN useradd -m -u ${UID} ${USER_NAME}

ENV HOME /home/${USER_NAME}
WORKDIR ${HOME}
ENV PYENV_ROOT ${HOME}/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

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
 && git clone https://github.com/pyenv/pyenv.git .pyenv \
 && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && pyenv install anaconda3-2020.07 \
 && pyenv global anaconda3-2020.07 \
 && pyenv rehash \
 && pip install --upgrade pip \
 && pip install opencv-python==4.4.0.44 \
 && pip install tensorflow-gpu==2.3.1 --ignore-installed --user keras==2.4.3 \
 && pip install torch==1.6.0 \
                torchvision==0.7.0 \
                torchsummary==1.5.1 \
 && pip install tqdm \
                addict \
                progressbar \
                pycocotools \
                requests \
                cmake \
                scikit-build \
                cupy-cuda110 \
 && pip install jupyterlab==2.2.8 \
                jupyterlab-nvdashboard \
                ipywidgets \
 && chown -R ${USER_NAME}: /home/${USER_NAME}/

USER ${UID}
RUN jupyter labextension install jupyterlab-nvdashboard \
 && jupyter labextension install @lckr/jupyterlab_variableinspector \
 && jupyter nbextension enable --py widgetsnbextension

