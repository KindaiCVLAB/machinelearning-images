FROM nvcr.io/nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
LABEL maintainer="Cvlab.Kubernetes Service:iwai"

ENV USER_NAME user
ENV UID 1000
RUN useradd -m -u ${UID} ${USER_NAME}

ENV HOME /home/${USER_NAME}
WORKDIR ${HOME}
ENV PYENV_ROOT ${HOME}/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    curl \
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
    make \
    build-essential \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncurses5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxrender1\
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
 && git clone https://github.com/pyenv/pyenv.git .pyenv \
 && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && pyenv install anaconda3-2019.07 \
 && pyenv global anaconda3-2019.07 \
 && pyenv rehash \
 && pip install --upgrade pip \
 && pip install opencv-python==3.4.7.28 \
 && pip install tensorflow-gpu==1.13.1 --ignore-installed --user keras==2.3.1 \
 && pip install torch==1.2.0 \
                torchvision==0.4.0 \
                torchsummary==1.5.1 \
 && pip install progressbar \
                tqdm \
                addict \
                pycocotools \
                requests \
                cmake \
                scikit-build \
                tabulate \
                cupy-cuda100==8.1.0 \ 
 && pip install jupyterlab==2.0.0 \
                jupyterlab-nvdashboard \
                ipywidgets \
 && chown -R ${USER_NAME}: /home/${USER_NAME}/

USER ${UID}
RUN jupyter labextension install jupyterlab-nvdashboard \
 && jupyter labextension install @lckr/jupyterlab_variableinspector \
 && jupyter nbextension enable --py widgetsnbextension

EXPOSE 8888
ENTRYPOINT [ "jupyter-lab", "--port=8888", "--ip=0.0.0.0", "--no-browser", "--NotebookApp.token=''"]