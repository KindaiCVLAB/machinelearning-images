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

# library version for Python
ARG ANACONDA_VERSION
ARG OPENCV_VERSION
ARG TF_GPU_VERSION
ARG KERAS_VERSION
ARG TORCH_VERSION
ARG TORCH_VISION_VERSION
ARG TORCH_SUMMARY_VERSION
ARG CUPY_CUDA_VERSION
ARG JUPYTER_VERSION
ARG CUDA_VERSION_FOR_CUPY
ARG TORCH_FILE
ARG TORCH_VISION_FILE
ARG TF_TYPE
ARG PYENV_RELEASE_VERSION

# package version for tools
ARG NODEJS_VERSION
ARG CODE_SERVER_VERSION
ARG RCLONE_VERSION

# install tools by apt.
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    curl \
    wget \
    git \
    unzip \
    imagemagick \
    bzip2 \
    vim \
    make \
    jq \
    ssh \
    rsync \
    dumb-init \
# for opencv
    libsm6 \
    libgl1-mesa-dev \
    libxrender1

# install pyenv and prepare python environment.
RUN pyenv_get_status=$(curl -I https://github.com/pyenv/pyenv/releases/tag/v${PYENV_RELEASE_VERSION} -o /dev/null -w '%{http_code}\n' -s) \
 && if [ "$pyenv_get_status" = "200" ];then PYENV_DOWNLOAD_VERSION=v${PYENV_RELEASE_VERSION}; else PYENV_DOWNLOAD_VERSION=${PYENV_RELEASE_VERSION}; fi \
 && curl -OL https://github.com/pyenv/pyenv/archive/${PYENV_DOWNLOAD_VERSION}.tar.gz \
 && tar -xzf ${PYENV_DOWNLOAD_VERSION}.tar.gz \
 && rm -rf ${PYENV_DOWNLOAD_VERSION}.tar.gz \
 && mv pyenv-${PYENV_RELEASE_VERSION} .pyenv \
 && curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && pyenv install anaconda3-${ANACONDA_VERSION} \
 && pyenv global anaconda3-${ANACONDA_VERSION} \
 && pyenv rehash \
 && pip install --upgrade pip

# install libraries for machinelearning
RUN pip install opencv-python==${OPENCV_VERSION} \
 && pip install ${TF_TYPE}-gpu==${TF_GPU_VERSION} --ignore-installed --user keras==${KERAS_VERSION} \
# tensorflow do not support cuda11.1.x, so must create libcusolver.so.10
# REF: https://github.com/tensorflow/tensorflow/issues/43947
# REF: https://gitlab.com/kindaicvlab/cvcloud/machinelearning-images/-/issues/46
 && target_libcusolver_path=$(python -c "import tensorflow.python as x; print(x.__path__[0])") \
 && if [[ "${BASE_IMG_CUDA_VERSION}" =~ ^11.1 ]];then ln -s /usr/local/cuda-11.1/targets/x86_64-linux/lib/libcusolver.so.11 ${target_libcusolver_path}/libcusolver.so.10; fi \
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
 && conda uninstall jupyterlab --force -y \
 && pip install jupyterlab==${JUPYTER_VERSION} \
                jupyterlab-nvdashboard \
                ipywidgets \
# install code-server
 && curl -fOL https://github.com/cdr/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb \
 && dpkg -i code-server_${CODE_SERVER_VERSION}_amd64.deb \
 && rm -rf code-server_${CODE_SERVER_VERSION}_amd64.deb \
# install rclone
 && curl -fOL https://github.com/rclone/rclone/releases/download/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-amd64.deb \
 && dpkg -i rclone-v${RCLONE_VERSION}-linux-amd64.deb \
 && rm -rf rclone-v${RCLONE_VERSION}-linux-amd64.deb

# clean apt cache
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && chown -R ${USER_NAME}: /home/${USER_NAME}/ \
 && rm -rf /tmp/*

# change user to 1000
USER ${UID}

# install jupyter extensions
RUN jupyter labextension install jupyterlab-nvdashboard --no-build \
 && jupyter labextension install @lckr/jupyterlab_variableinspector --no-build \
 && jupyter nbextension enable --py widgetsnbextension \
 && jupyter-lab build

# create config directory for rclone
RUN mkdir -p .config/rclone

# set alias for git
COPY configs/git/sub_cmd_alias .git_sub_cmd_alias
RUN echo "\n#git alias" >> ~/.bashrc \
 && echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc \
 && echo "alias g=\"git\"" >> ~/.bashrc \
 && echo "__git_complete g __git_main" >> ~/.bashrc \
 && echo "source ~/.git_sub_cmd_alias\n" >> ~/.bashrc \
 && git config --global alias.cl clone \
 && git config --global alias.s status \
 && git config --global alias.ck checkout \
 && git config --global alias.b branch \
 && git config --global alias.ps push \
 && git config --global alias.c commit \
 && git config --global alias.a add \
 && git config --global alias.pl pull \
 && git config --global alias.rs reset \
 && git config --global alias.st stash \
 && git config --global alias.rb rebase \
 && git config --global alias.df diff \
 && git config --global alias.ft fetch \
 && git config --global alias.l log

# copy settings.json for code-server
RUN mkdir -p .local/share/code-server/User
COPY configs/vscode .local/share/code-server/User/cvcloud

WORKDIR ${HOME}/.local/share/code-server/User/cvcloud
RUN cat container-building.json | sed "s/@@ANACONDA_VERSION@@/${ANACONDA_VERSION}/" > addon.json \
 && jq -s add base.json addon.json > ../settings.json \
 && rm addon.json \
 && mv keybindings.json ../keybindings.json

# install specify ms-python for codeserver(<= 3.9.0)
# RUN wget https://github.com/microsoft/vscode-python/releases/download/2020.10.332292344/ms-python-release.vsix \
#  && dumb-init /usr/bin/code-server \
#    --install-extension ./ms-python-release.vsix \
#  && rm -rf ./ms-python-release.vsix

# install code-server extensions
RUN dumb-init /usr/bin/code-server \
   --install-extension ms-python.python \
   --install-extension magicstack.magicpython \
   --install-extension coenraads.bracket-pair-colorizer-2 \
   --install-extension streetsidesoftware.code-spell-checker \
   --install-extension redhat.vscode-yaml \
   --install-extension pkief.material-icon-theme \
   --install-extension yzhang.markdown-all-in-one || true \
 && rm -rf /tmp/*

WORKDIR ${HOME}
