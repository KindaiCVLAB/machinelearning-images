FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
LABEL maintainer="CvlabKubernetesService:iwai"

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
    jq \
    dumb-init \
 && git clone https://github.com/pyenv/pyenv.git .pyenv \
 && curl -sL https://deb.nodesource.com/setup_15.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && pyenv install anaconda3-2020.07 \
 && pyenv global anaconda3-2020.07 \
 && pyenv rehash \
 && pip install --upgrade pip \
 && pip install opencv-python==4.4.0.46 \
 && pip install tensorflow-gpu==2.4.0 --ignore-installed --user keras==2.4.3 \
 && pip install torch==1.7.1 \
                torchvision==0.8.2 \
                torchsummary==1.5.1 \
 && pip install tqdm \
                addict \
                progressbar \
                pycocotools \
                requests cmake \
                scikit-build \
                tabulate \
                cmake \
                cupy-cuda102==8.2.0 \
 && pip install jupyterlab==2.2.9 \
                jupyterlab-nvdashboard \
                ipywidgets \
 && curl -fOL https://github.com/cdr/code-server/releases/download/v3.8.0/code-server_3.8.0_amd64.deb \
 && dpkg -i code-server_3.8.0_amd64.deb \
 && rm -rf code-server_3.8.0_amd64.deb \
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

EXPOSE 8888
ENTRYPOINT [ "jupyter-lab", "--port=8888", "--ip=0.0.0.0", "--no-browser", "--NotebookApp.token=''"]
