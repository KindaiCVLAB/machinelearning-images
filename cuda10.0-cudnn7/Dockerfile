FROM nvcr.io/nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
LABEL maintainer="CvlabKubernetesService:iwai"

ENV USER_NAME user
ENV UID 1000
RUN useradd -m -u ${UID} ${USER_NAME}

ENV HOME /home/${USER_NAME}
WORKDIR ${HOME}
ENV PYENV_ROOT ${HOME}/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
ENV DEBIAN_FRONTEND=noninteractive

ARG ANACONDA_VERSION
ARG OPENCV_VERSION
ARG TF_GPU_VERSION
ARG KERAS_VERSION
ARG TORCH_VERSION
ARG TORCH_VISION_VERSION
ARG TORCH_SUMMARY_VERSION
ARG CUPY_CUDA_VERSION
ARG JUPYTER_VERSION
ARG CODE_SERVER_VERSION
ARG NODEJS_VERSION
ARG CUDA_VERSION_FOR_CUPY
ARG TORCH_FILE
ARG TORCH_VISION_FILE
ARG TF_TYPE

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
    jq \
    dumb-init \    
 && git clone https://github.com/pyenv/pyenv.git .pyenv \
 && curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && pyenv install anaconda3-${ANACONDA_VERSION} \
 && pyenv global anaconda3-${ANACONDA_VERSION} \
 && pyenv rehash \
 && pip install --upgrade pip \
 && pip install opencv-python==${OPENCV_VERSION} \
 && pip install ${TF_TYPE}-gpu==${TF_GPU_VERSION} --ignore-installed --user keras==${KERAS_VERSION} \
 && pip install torch==${TORCH_VERSION} \
                torchvision==${TORCH_VISION_VERSION} \
                torchsummary==${TORCH_SUMMARY_VERSION} \
 && pip install progressbar \
                tqdm \
                addict \
                pycocotools \
                requests \
                cmake \
                scikit-build \
                tabulate \
                cupy-cuda${CUDA_VERSION_FOR_CUPY}==${CUPY_CUDA_VERSION} \
 && pip install jupyterlab==${JUPYTER_VERSION} \
                jupyterlab-nvdashboard \
                ipywidgets \
 && curl -fOL https://github.com/cdr/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb \
 && dpkg -i code-server_${CODE_SERVER_VERSION}_amd64.deb \
 && rm -rf code-server_${CODE_SERVER_VERSION}_amd64.deb \
 && chown -R ${USER_NAME}: /home/${USER_NAME}/

RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER ${UID}

#  install jupyter extensions
RUN jupyter labextension install jupyterlab-nvdashboard \
 && jupyter labextension install @lckr/jupyterlab_variableinspector \
 && jupyter nbextension enable --py widgetsnbextension

# install code-server extensions
RUN mkdir -p /home/user/.local/share/code-server/User \
 && echo "{\n  \"terminal.integrated.shell.linux\": \"/bin/bash\",\n  \"workbench.colorTheme\": \"Visual Studio Dark\",\n  \"extensions.autoCheckUpdates\": false,\n  \"extensions.autoUpdate\": false\n}" \
 > /home/user/.local/share/code-server/User/settings.json \           
 && wget https://github.com/microsoft/vscode-python/releases/download/2020.10.332292344/ms-python-release.vsix \
 && dumb-init /usr/bin/code-server \
   --install-extension ./ms-python-release.vsix \
   --install-extension magicstack.magicpython \
   --install-extension coenraads.bracket-pair-colorizer-2 \
   --install-extension streetsidesoftware.code-spell-checker \
   --install-extension redhat.vscode-yaml \
   --install-extension pkief.material-icon-theme || true \
 && rm -rf ./ms-python-release.vsix
