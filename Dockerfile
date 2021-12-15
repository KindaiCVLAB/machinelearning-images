ARG BASE_IMG_CUDA_VERSION
ARG BASE_IMG_OS_VERSION
FROM nvidia/cuda:${BASE_IMG_CUDA_VERSION}-devel-${BASE_IMG_OS_VERSION}
LABEL maintainer="KindaiCVLAB"
LABEL org.opencontainers.image.source="https://github.com/kindaicvlab/machinelearning-images"

ENV USER_NAME user
ENV UID 1000
ENV HOME /home/${USER_NAME}
ENV PATH ${HOME}/.local/bin:$PATH
RUN useradd -m -u ${UID} ${USER_NAME}

WORKDIR ${HOME}
ENV PYENV_ROOT ${HOME}/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
ENV DEBIAN_FRONTEND=noninteractive

ARG IMAGE_STATUS
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
ARG OPTUNA_VERSION
ARG PYENV_RELEASE_VERSION
ENV CUPY_CUDA_WHEEL https://github.com/cupy/cupy/releases/v${CUPY_CUDA_VERSION}

# package version for tools
ARG NODEJS_VERSION
ARG CODE_SERVER_VERSION
ARG RCLONE_VERSION

SHELL ["/bin/bash", "-c"]

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
    libxrender1 \
## setup nodejs
 && curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
# install code-server
 && curl -fOL https://github.com/cdr/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb \
 && dpkg -i code-server_${CODE_SERVER_VERSION}_amd64.deb \
 && rm -rf code-server_${CODE_SERVER_VERSION}_amd64.deb \
# install rclone
 && curl -fOL https://github.com/rclone/rclone/releases/download/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-amd64.deb \
 && dpkg -i rclone-v${RCLONE_VERSION}-linux-amd64.deb \
 && rm -rf rclone-v${RCLONE_VERSION}-linux-amd64.deb \
# clean apt cache
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# change user to 1000
USER ${UID}

# install pyenv and prepare python environment.
RUN pyenv_get_status=$(curl -I https://github.com/pyenv/pyenv/releases/tag/v${PYENV_RELEASE_VERSION} -o /dev/null -w '%{http_code}\n' -s) \
 && if [ "$pyenv_get_status" = "200" ];then \
        PYENV_DOWNLOAD_VERSION=v${PYENV_RELEASE_VERSION}; \
    else \
        PYENV_DOWNLOAD_VERSION=${PYENV_RELEASE_VERSION}; \
    fi \
 && curl -OL https://github.com/pyenv/pyenv/archive/${PYENV_DOWNLOAD_VERSION}.tar.gz \
 && tar -xzf ${PYENV_DOWNLOAD_VERSION}.tar.gz \
 && rm -rf ${PYENV_DOWNLOAD_VERSION}.tar.gz \
 && mv pyenv-${PYENV_RELEASE_VERSION} .pyenv \
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
 && if [[ "${BASE_IMG_CUDA_VERSION}" =~ ^11.1 ]];then \
        ln -s /usr/local/cuda-11.1/targets/x86_64-linux/lib/libcusolver.so.11 ${target_libcusolver_path}/libcusolver.so.10; \
    fi \
# install pytorch
 && if [ -z "${TORCH_FILE}" ]; then \
        if [ "${IMAGE_STATUS}" = "feature" ]; then \
            pip install --pre torch==${TORCH_VERSION}; \
        else \
            pip install torch==${TORCH_VERSION}; \
        fi \
    else \
        if [ "${IMAGE_STATUS}" = "feature" ]; then \
            pip install --pre torch==${TORCH_VERSION} -f ${TORCH_FILE}; \
        else \
            pip install torch==${TORCH_VERSION} -f ${TORCH_FILE}; \
        fi \
    fi \
# install torchvision
 && if [ -z "${TORCH_VISION_FILE}" ]; then \
        if [ "${IMAGE_STATUS}" = "feature" ]; then \
            pip install --pre torchvision==${TORCH_VISION_VERSION}; \
        else \
            pip install torchvision==${TORCH_VISION_VERSION}; \
        fi \
    else \
        if [ "${IMAGE_STATUS}" = "feature" ]; then \
            pip install --pre torchvision==${TORCH_VISION_VERSION} -f ${TORCH_VISION_FILE}; \
        else \
            pip install torchvision==${TORCH_VISION_VERSION} -f ${TORCH_VISION_FILE}; \
        fi \
    fi \
 && pip install torchsummary==${TORCH_SUMMARY_VERSION} \
 && pip install optuna==${OPTUNA_VERSION} \
 && pip install tqdm \
                addict \
                progressbar \
                pycocotools \
                requests \
                cmake \
                scikit-build \
                tabulate \
                tensorflow_model_optimization \
                Keras-Applications \
 && pip install cupy-cuda${CUDA_VERSION_FOR_CUPY}==${CUPY_CUDA_VERSION} -f ${CUPY_CUDA_WHEEL} \
# how to install cupy-cuda for old cuda driver
#  && if [ "${CUDA_VERSION_FOR_CUPY}" = "113" ]; then \
#         pip install cupy-cuda112==${CUPY_CUDA_VERSION} -f ${CUPY_CUDA_WHEEL}; \
#     else \
#         pip install cupy-cuda${CUDA_VERSION_FOR_CUPY}==${CUPY_CUDA_VERSION} -f ${CUPY_CUDA_WHEEL}; \
#     fi \
# prepre jupyter
 && conda uninstall jupyterlab --force -y \
 && pip install jupyterlab==${JUPYTER_VERSION} \
                ipywidgets \
                jupyterlab-nvdashboard \
                lckr-jupyterlab-variableinspector \
 && rm -rf .cache/pip

# setup rclone
RUN mkdir -p .config/rclone \
 && echo -e "\n#completion for rclone" >> ~/.bashrc \
 && echo -e "\nsource <(rclone completion bash)\n" >> ~/.bashrc

# set alias for git
COPY configs/git/sub_cmd_alias .git_sub_cmd_alias
RUN echo -e "\n#git alias" >> ~/.bashrc \
 && echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc \
 && echo "alias g=\"git\"" >> ~/.bashrc \
 && echo "__git_complete g __git_main" >> ~/.bashrc \
 && echo -e "source ~/.git_sub_cmd_alias\n" >> ~/.bashrc \
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
COPY --chown=${UID} configs/vscode .local/share/code-server/User/cvcloud

WORKDIR ${HOME}/.local/share/code-server/User/cvcloud
RUN sed -i "s/@@ANACONDA_VERSION@@/${ANACONDA_VERSION}/" container-building.json \
 && jq -s add base.json container-building.json > ../settings.json \
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
