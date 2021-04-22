ARG BASE_IMG_CUDA_VERSION
FROM nvcr.io/nvidia/cuda:${BASE_IMG_CUDA_VERSION}-devel-ubuntu18.04
LABEL maintainer="CvlabKubernetesService"

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
ARG PYENV_RELEASE_VERSION

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
 && curl -OL https://github.com/pyenv/pyenv/archive/v${PYENV_RELEASE_VERSION}.tar.gz \
 && tar -xzf v${PYENV_RELEASE_VERSION}.tar.gz \
 && rm -rf v${PYENV_RELEASE_VERSION}.tar.gz \
 && mv pyenv-${PYENV_RELEASE_VERSION} .pyenv \
 && curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && pyenv install anaconda3-${ANACONDA_VERSION} \
 && pyenv global anaconda3-${ANACONDA_VERSION} \
 && pyenv rehash \
 && pip install --upgrade pip \
 && pip install opencv-python==${OPENCV_VERSION} \
 && pip install ${TF_TYPE}-gpu==${TF_GPU_VERSION} --ignore-installed --user keras==${KERAS_VERSION} \
 && if [ -z "${TORCH_FILE}" ]; then pip install torch==${TORCH_VERSION}; else pip install --pre torch -f ${TORCH_FILE}; fi \
 && if [ -z "${TORCH_VISION_FILE}" ]; then pip install torchvision==${TORCH_VISION_VERSION}; else pip install --pre torchvision -f ${TORCH_VISION_FILE}; fi \
 && pip install torchsummary==${TORCH_SUMMARY_VERSION} \
 && pip install tqdm \
                addict \
                progressbar \
                pycocotools \
                requests \
                cmake \
                scikit-build \
                tabulate \
                cupy-cuda${CUDA_VERSION_FOR_CUPY}==${CUPY_CUDA_VERSION} \
# how to install cupy-cuda for old cuda driver
#  && if [ "${CUDA_VERSION_FOR_CUPY}" = "112" ]; then pip install cupy-cuda111==${CUPY_CUDA_VERSION}; else pip install cupy-cuda${CUDA_VERSION_FOR_CUPY}==${CUPY_CUDA_VERSION}; fi \
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

# copy settings.json for code-server
RUN mkdir -p .local/share/code-server/User
COPY configs/vscode .local/share/code-server/User/cvcloud

WORKDIR ${HOME}/.local/share/code-server/User/cvcloud
RUN cat container-building.json | sed "s/@@ANACONDA_VERSION@@/${ANACONDA_VERSION}/" > addon.json \
 && jq -s add base.json addon.json > ../settings.json \
 && rm addon.json

# install code-server extensions

# install specify ms-python for codeserver(<= 3.9.0)
# RUN wget https://github.com/microsoft/vscode-python/releases/download/2020.10.332292344/ms-python-release.vsix \
#  && dumb-init /usr/bin/code-server \
#    --install-extension ./ms-python-release.vsix \
#  && rm -rf ./ms-python-release.vsix

RUN dumb-init /usr/bin/code-server \
   --install-extension ms-python.python \
   --install-extension magicstack.magicpython \
   --install-extension coenraads.bracket-pair-colorizer-2 \
   --install-extension streetsidesoftware.code-spell-checker \
   --install-extension redhat.vscode-yaml \
   --install-extension pkief.material-icon-theme \
   --install-extension yzhang.markdown-all-in-one || true

WORKDIR ${HOME}
