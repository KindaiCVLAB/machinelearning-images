FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
LABEL maintainer="CvlabKubernetesService:iwai"

ENV USER_NAME user
ENV UID 1000
RUN useradd -m -u ${UID} ${USER_NAME}

ENV HOME /home/${USER_NAME}
WORKDIR ${HOME}
ENV PYENV_ROOT ${HOME}/.pyenv
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
 && pyenv install anaconda3-2019.07 \
 && pyenv global anaconda3-2019.07 \
 && pyenv rehash \
 && pip install --upgrade pip \
 && pip install opencv-python==4.2.0.34 \
 && pip install tensorflow-gpu==2.2.0 --ignore-installed --user keras==2.3.1 \
 && pip install torch==1.5.0 torchvision==0.6.0 torchsummary==1.5.1 \
 && pip install tqdm addict progressbar \
 && pip install jupyterlab==2.0.0 \
 && jupyter labextension install @lckr/jupyterlab_variableinspector \
 && pip install jupyterlab-nvdashboard \
 && chown -R ${USER_NAME}: /home/${USER_NAME}/

USER ${UID}
RUN jupyter labextension install jupyterlab-nvdashboard \
 && jupyter labextension install @lckr/jupyterlab_variableinspector

EXPOSE 8888
CMD [ "jupyter-lab", "--port=8888", "--ip=0.0.0.0", "--no-browser", "--NotebookApp.token=''"]