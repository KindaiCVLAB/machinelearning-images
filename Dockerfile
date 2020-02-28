FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

WORKDIR /
#preparation
RUN apt-get update && apt-get install -y curl git unzip imagemagick bzip2 vim libsm6 libgl1-mesa-dev build-essential libssl-dev && \
    git clone https://github.com/pyenv/pyenv.git .pyenv && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.2/install.sh | bash && source ~/.nvm/nvm.sh && nvm install v13.5.0

ENV HOME  /
ENV PYENV_ROOT /.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN pyenv install anaconda3-4.4.0 && pyenv global anaconda3-4.4.0 && pyenv rehash

RUN pip install opencv-python==3.4.7.28 && pip install tensorflow-gpu==1.13.1 --ignore-installed --user && \
    pip install keras && pip install torch torchvision && \
    pip install tqdm && pip install torchsummary && pip install progressbar && \
    jupyter labextension install @lckr/jupyterlab_variableinspector && \
    jupyter labextension install @jupyterlab/toc && pip install tensorboard && pip install jupyter-tensorboard && \
    jupyter labextension install jupyterlab_tensorboard && jupyter serverextension enable --py jupyterlab_tensorboard && \
    pip install jupyterlab-nvdashboard && jupyter labextension install jupyterlab-nvdashboard && \\
    jupyter labextension install @krassowski/jupyterlab-lsp && pip install 'python-language-server[all]' && \
    pip install --pre jupyter-lsp && mkdir .lsp_symlink

CMD mkdir .lsp_symlink && cd .lsp_symlink && ln -s /home home