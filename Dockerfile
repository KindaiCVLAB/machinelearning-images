FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

#preparation
RUN apt-get update && apt-get install -y curl git unzip imagemagick bzip2 vim && \
    git clone https://github.com/pyenv/pyenv.git .pyenv

WORKDIR /
ENV HOME  /
ENV PYENV_ROOT /.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN pyenv install anaconda3-4.4.0
RUN pyenv global anaconda3-4.4.0
RUN pyenv rehash

RUN apt-get update && apt-get install -y libsm6 && \
    pip install opencv-python==3.4.7.28 && pip install tensorflow-gpu==1.13.1 --ignore-installed --user && \
    pip install keras && pip install torch torchvision && apt-get install -y libgl1-mesa-dev && \
    pip install tqdm && pip install torchsummary && pip install progressbar && pip install jupyterlab