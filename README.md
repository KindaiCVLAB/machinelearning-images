[![GitHub license](https://img.shields.io/github/license/KindaiCVLAB/machinelearning-images?color=blue)](https://github.com/KindaiCVLAB/machinelearning-images/blob/master/LICENSE)
[![cuda10.2-cudnn7](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda10.2-cudnn7.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda10.2-cudnn7.yaml)
[![cuda10.2-cudnn8](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda10.2-cudnn8.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda10.2-cudnn8.yaml)
[![cuda11.0.3-cudnn8](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.0.3-cudnn8.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.0.3-cudnn8.yaml)
[![cuda11.1.1-cudnn8](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.1.1-cudnn8.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.1.1-cudnn8.yaml)
[![cuda11.2.0-cudnn8](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.2.0-cudnn8.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.2.0-cudnn8.yaml)
[![cuda11.2.1-cudnn8](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.2.1-cudnn8.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.2.1-cudnn8.yaml)
[![cuda11.2.2-cudnn8](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.2.2-cudnn8.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.2.2-cudnn8.yaml)
[![cuda11.3.0-cudnn8](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.3.0-cudnn8.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.3.0-cudnn8.yaml)
[![cuda11.3.1-cudnn8](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.3.1-cudnn8.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.3.1-cudnn8.yaml)
[![cuda11.4.0-cudnn8](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.4.0-cudnn8.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.4.0-cudnn8.yaml)
[![cuda11.4.1-cudnn8](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.4.1-cudnn8.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.4.1-cudnn8.yaml)
[![cuda11.4.2-cudnn8](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.4.2-cudnn8.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/cuda11.4.2-cudnn8.yaml)


# Container Images for Machine Learning

本リポジトリは Machine Learning 用コンテナイメージを保管するリポジトリです．

## 概要

全てのコンテナイメージは，UID 1000 で起動した場合のみ正常に動作します．
そのためコンテナ起動後の pip や conda を用いたライブラリの追加は可能ですが，apt 経由でのパッケージの追加はできません．

## イメージ一覧

- `ghcr.io/kindaicvlab/machinelearning-images:cuda10.2-cudnn7`
- `ghcr.io/kindaicvlab/machinelearning-images:cuda10.2-cudnn8`
- `ghcr.io/kindaicvlab/machinelearning-images:cuda11.0.3-cudnn8`
- `ghcr.io/kindaicvlab/machinelearning-images:cuda11.1.1-cudnn8`
- `ghcr.io/kindaicvlab/machinelearning-images:cuda11.2.0-cudnn8`
- `ghcr.io/kindaicvlab/machinelearning-images:cuda11.2.1-cudnn8`
- `ghcr.io/kindaicvlab/machinelearning-images:cuda11.2.2-cudnn8`
- `ghcr.io/kindaicvlab/machinelearning-images:cuda11.3.0-cudnn8`
- `ghcr.io/kindaicvlab/machinelearning-images:cuda11.3.1-cudnn8`
- `ghcr.io/kindaicvlab/machinelearning-images:cuda11.4.0-cudnn8`
- `ghcr.io/kindaicvlab/machinelearning-images:cuda11.4.1-cudnn8`
- `ghcr.io/kindaicvlab/machinelearning-images:cuda11.4.2-cudnn8`

## 動作状況

全てのイメージを全ての環境でテストすることはできないので以下の動作状況は参考程度にしてください．

### イメージのステータスについて

|    STATUS    | Description |
|:------------:|:-----------:|
|   `closed`   | セキュリティパッチやバグ修正も提供されないので，直ちに使用を停止してください．|
| `deprecated` | セキュリティパッチやバグ修正のみが提供されます．各ライブラリが最新版に更新されることはありません．|
|   `stable`   | 安定版です．全てのライブラリが最新版に保たれています．|
|   `feature`  | 新機能追加中のため特定の環境でしか動作しません．|

### イメージのステータス一覧

|        Image        |       Status       |
|:-------------------:|:------------------:|
|  `cuda10.0-cudnn7`  |      `closed`      |
|  `cuda10.1-cudnn7`  |      `closed`      |
|  `cuda10.1-cudnn8`  |      `closed`      |
|  `cuda11.0-cudnn8`  |      `closed`      |
|  `cuda11.1-cudnn8`  |      `closed`      |
|  `cuda10.2-cudnn7`  |     `deprecated`   |
|  `cuda10.2-cudnn8`  |     `deprecated`   |
| `cuda11.0.3-cudnn8` |     `deprecated`   |
| `cuda11.1.1-cudnn8` |     `deprecated`   |
| `cuda11.2.0-cudnn8` |     `deprecated`   |
| `cuda11.2.1-cudnn8` |     `deprecated`   |
| `cuda11.2.2-cudnn8` |`stable(tensorflow)`|
| `cuda11.3.0-cudnn8` |      `deprecated`  |
| `cuda11.3.1-cudnn8` |`stable(pytorch)`   |
| `cuda11.4.0-cudnn8` |      `feature`     |
| `cuda11.4.1-cudnn8` |      `feature`     |
| `cuda11.4.2-cudnn8` |      `feature`     |

## コンテナイメージ の詳細

ベースイメージは全て https://hub.docker.com/r/nvidia/cuda を使用しています．
また，ベースイメージの使用 OS バージョン以下の通りです．

- cuda10.2: ubuntu18.04
- cuda10.2 以外: ubuntu20.04

### 各イメージ共通ライブラリ & パッケージ

- 各イメージで共通で使用されている物一覧です．
- バージョンはコンテナイメージがビルドされた時点での最新のものになっています．
- ビルド日は package registry の以下のような項目を確認してください．
  - `Published about 20 hours ago · Digest`

- 共通イメージを最新に保つため一定期間毎にコンテナイメージは再ビルドされます．

#### パッケージ

- curl
- wget
- git
- unzip
- imagemagick
- bzip2
- vim
- make
- dumb-init
- jq
- ssh
- rsync
- rclone
- nodejs
  - feature: Current
  - others: LTS
- code-server

##### For Anaconda

- libgl1-mesa-glx
- libegl1-mesa
- libxrandr2
- libxss1
- libxcursor1
- libxcomposite1
- libasound2
- libxi6
- libxtst6

##### For OpenCV

- libsm6
- libgl1-mesa-dev
- libxrender1

#### Python ライブラリ

- tqdm
- addict
- progressbar
- pycocotools
- requests
- cmake
- scikit-build
- tabulate
- ipywidgets
- jupyterlab-nvdashboard
- tensorflow_model_optimization
- Keras-Applications

### cuda10.2

- STATUS: Deprecated
- cuda10.2-cudnn7 & cuda10.2-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|10.2|
|cudnn|7.6.5.32-1 or 8.2.4.15-1|
|anaconda3|2020.11|
|opencv-python|4.5.1.48|
|tensorflow-gpu|2.4.4|
|keras|2.4.3|
|torch|1.7.1+cu102|
|torchvision|0.8.2+cu102|
|torchinfo|1.5.4|
|jupyterlab|2.2.9|
|optuna|2.10.0|
|cupy-cuda102|8.3.0|

### cuda11.0.3

- STATUS: Deprecated
- cuda11.0.3-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.0.3|
|cudnn|8.0.5.39|
|anaconda3|2020.11|
|opencv-python|4.5.1.48|
|tensorflow-gpu|2.4.4|
|keras|2.4.3|
|torch|1.8.1+cu111|
|torchvision|0.9.1+cu111|
|torchinfo|1.5.4|
|jupyterlab|2.2.9|
|optuna|2.10.0|
|cupy-cuda110|8.4.0|

### cuda11.1.1

- STATUS: Deprecated
- cuda11.1.1-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.1.1|
|cudnn|8.0.5.39|
|anaconda3|2021.05|
|opencv-python|4.5.3.56|
|tensorflow-gpu|2.6.1|
|keras|2.6.0|
|torch|1.9.1+cu111|
|torchvision|0.10.1+cu111|
|torchinfo|1.5.4|
|jupyterlab|3.1.18|
|optuna|2.10.0|
|cupy-cuda111|9.5.0|

### cuda11.2.0

- STATUS: Deprecated
- cuda11.2.0-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.2.0|
|cudnn|8.1.1.33|
|anaconda3|2021.05|
|opencv-python|4.5.2.54|
|tensorflow-gpu|2.5.2|
|keras|2.4.3|
|torch|1.9.0+cu111|
|torchvision|0.10.0+cu111|
|torchinfo|1.5.4|
|jupyterlab|3.0.16|
|optuna|2.10.0|
|cupy-cuda112|9.1.0|

### cuda11.2.1

- STATUS: Deprecated
- cuda11.2.1-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.2.1|
|cudnn|8.1.1.33|
|anaconda3|2021.05|
|opencv-python|4.5.2.54|
|tensorflow-gpu|2.5.2|
|keras|2.4.3|
|torch|1.9.0+cu111|
|torchvision|0.10.0+cu111|
|torchinfo|1.5.4|
|jupyterlab|3.0.16|
|optuna|2.10.0|
|cupy-cuda112|9.1.0|

### cuda11.2.2

- STATUS: Stable(Tensorflow)
- cuda11.2.2-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.2.2|
|cudnn|8.1.1.33|
|anaconda3|2021.05|
|opencv-python|4.5.4.60|
|tensorflow-gpu|2.7.0|
|keras|2.7.0|
|torch|1.10.0+cu113|
|torchvision|0.11.1+cu113|
|torchinfo|1.5.4|
|jupyterlab|3.2.4|
|optuna|2.10.0|
|cupy-cuda112|9.6.0|

### cuda11.3.0

- STATUS: Deprecated
- cuda11.3.0-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.3.0|
|cudnn|8.2.0.53|
|anaconda3|2021.05|
|opencv-python|4.5.3.56|
|tensorflow-gpu|2.6.1|
|keras|2.6.0|
|torch|1.10.0+cu113|
|torchvision|0.11.1+cu113|
|torchinfo|1.5.4|
|jupyterlab|3.1.18|
|optuna|2.10.0|
|cupy-cuda113|9.5.0|

### cuda11.3.1

- STATUS: Stable(Pytorch)
- cuda11.3.1-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.3.1|
|cudnn|8.2.0.53|
|anaconda3|2021.05|
|opencv-python|4.5.4.60|
|tensorflow-gpu|2.7.0|
|keras|2.7.0|
|torch|1.10.0+cu113|
|torchvision|0.11.1+cu113|
|torchinfo|1.5.4|
|jupyterlab|3.2.4|
|optuna|2.10.0|
|cupy-cuda113|9.6.0|

### cuda11.4.0

- STATUS: Feature
- cuda11.4.0-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.4.0|
|cudnn|8.2.4.15|
|anaconda3|2021.05|
|opencv-python|4.5.4.60|
|tensorflow-gpu|2.8.0.dev20211130|
|keras|2.7.0|
|torch|1.11.0.dev20211214+cu115|
|torchvision|0.12.0.dev20211214+cu115|
|torchinfo|1.5.4|
|jupyterlab|3.2.4|
|optuna|3.0.0a0|
|cupy-cuda113|10.0.0rc1|

### cuda11.4.1

- STATUS: Feature
- cuda11.4.1-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.4.1|
|cudnn|8.2.4.15|
|anaconda3|2021.05|
|opencv-python|4.5.4.60|
|tensorflow-gpu|2.8.0.dev20211130|
|keras|2.7.0|
|torch|1.11.0.dev20211214+cu115|
|torchvision|0.12.0.dev20211214+cu115|
|torchinfo|1.5.4|
|jupyterlab|3.2.4|
|optuna|3.0.0a0|
|cupy-cuda114|10.0.0rc1|

### cuda11.4.2

- STATUS: Feature
- cuda11.4.2-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.4.2|
|cudnn|8.2.4.15|
|anaconda3|2021.05|
|opencv-python|4.5.4.60|
|tensorflow-gpu|2.8.0.dev20211130|
|keras|2.7.0|
|torch|1.11.0.dev20211214+cu115|
|torchvision|0.12.0.dev20211214+cu115|
|torchinfo|1.5.4|
|jupyterlab|3.2.4|
|optuna|3.0.0a0|
|cupy-cuda114|10.0.0rc1|

## 各種ツール類

### jupyterlab アドオン拡張ツール

|拡張ツール名|バージョン|
|:---:|:---:|
|jupyterlab-nvdashboard|latest|
|@lckr/jupyterlab_variableinspector|latest|
|widgetsnbextension|latest|


### code-server アドオン拡張ツール

|拡張ツール名|バージョン|
|:---:|:---:|
|ms-python|latest|
|magicstack.magicpython|latest|
|coenraads.bracket-pair-colorizer-2|latest|
|streetsidesoftware.code-spell-checker|latest|
|redhat.vscode-yaml|latest|
|pkief.material-icon-theme|latest|
|yzhang.markdown-all-in-one|latest|
