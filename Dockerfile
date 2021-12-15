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
ENV CUPY_CUDA_WHEEL https://github.com/cupy/cupy/releases/v${CUPY_CUDA_VERSION}

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
# for anaconda
    libgl1-mesa-glx \
    libegl1-mesa \
    libxrandr2 \
    libxss1 \
    libxcursor1 \
    libxcomposite1 \
    libasound2 \
    libxi6 \
    libxtst6 \
## setup nodejs
 && if [ "${IMAGE_STATUS}" = "feature" ]; then \
        curl -sSL https://deb.nodesource.com/setup_current.x | bash - ; \
    else \
        curl -sSL https://deb.nodesource.com/setup_lts.x | bash - ; \
    fi \
 && apt-get install -y --no-install-recommends nodejs \
# install the latest code-server
 && curl -sSL https://code-server.dev/install.sh | sh \
 && rm -rf ~/.cache/code-server \
 && chown ${UID}:${UID} ~/.cache \
# install the latest rclone
 && curl -sSL https://rclone.org/install.sh | bash \
 && rm -f rclone-current-linux-amd64.zip \
# clean apt cache
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/*

# change user to 1000
USER ${UID}

# install anaconda
ENV PATH=${HOME}/.anaconda3/bin:$PATH
RUN curl -sSL -o Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh https://repo.anaconda.com/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
 && bash Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh -b -p ${HOME}/.anaconda3 \
 && rm -f Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
 && conda init bash

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
COPY --chown=${UID}:${UID} configs/git/sub_cmd_alias .git_sub_cmd_alias
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
COPY --chown=${UID}:${UID} configs/vscode .local/share/code-server/User/cvcloud

WORKDIR ${HOME}/.local/share/code-server/User/cvcloud
RUN cp keybindings.json ../keybindings.json \
 && cp settings.json ../settings.json

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
