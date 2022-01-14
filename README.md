[![GitHub license](https://img.shields.io/github/license/KindaiCVLAB/machinelearning-images?color=blue)](https://github.com/KindaiCVLAB/machinelearning-images/blob/master/LICENSE)
[![Build and Push Container Images](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/build-push.yaml/badge.svg)](https://github.com/KindaiCVLAB/machinelearning-images/actions/workflows/build-push.yaml)

# Container Images for Machine Learning

本リポジトリはコンピュータビジョン向けの Machine Learning 用コンテナイメージを保管するリポジトリです．

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
- `ghcr.io/kindaicvlab/machinelearning-images:cuda11.4.3-cudnn8`
- `ghcr.io/kindaicvlab/machinelearning-images:cuda11.5.1-cudnn8`

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

|        Image        |       Status       |                          Libraries Version                          |
|:-------------------:|:------------------:|:-------------------------------------------------------------------:|
|  `cuda10.0-cudnn7`  |      `closed`      |                                 none                                |
|  `cuda10.1-cudnn7`  |      `closed`      |                                 none                                |
|  `cuda10.1-cudnn8`  |      `closed`      |                                 none                                |
|  `cuda11.0-cudnn8`  |      `closed`      |                                 none                                |
|  `cuda11.1-cudnn8`  |      `closed`      |                                 none                                |
|  `cuda10.2-cudnn7`  |     `deprecated`   |  [`requirements.txt`](./versions/cuda10.2-cudnn7/requirements.txt)  |
|  `cuda10.2-cudnn8`  |     `deprecated`   |  [`requirements.txt`](./versions/cuda10.2-cudnn8/requirements.txt)  |
| `cuda11.0.3-cudnn8` |     `deprecated`   | [`requirements.txt`](./versions/cuda11.0.3-cudnn8/requirements.txt) |
| `cuda11.1.1-cudnn8` |     `deprecated`   | [`requirements.txt`](./versions/cuda11.1.1-cudnn8/requirements.txt) |
| `cuda11.2.0-cudnn8` |     `deprecated`   | [`requirements.txt`](./versions/cuda11.2.0-cudnn8/requirements.txt) |
| `cuda11.2.1-cudnn8` |     `deprecated`   | [`requirements.txt`](./versions/cuda11.2.1-cudnn8/requirements.txt) |
| `cuda11.2.2-cudnn8` |`stable(tensorflow)`| [`requirements.txt`](./versions/cuda11.2.2-cudnn8/requirements.txt) |
| `cuda11.3.0-cudnn8` |      `deprecated`  | [`requirements.txt`](./versions/cuda11.3.0-cudnn8/requirements.txt) |
| `cuda11.3.1-cudnn8` |`stable(pytorch)`   | [`requirements.txt`](./versions/cuda11.3.1-cudnn8/requirements.txt) |
| `cuda11.4.0-cudnn8` |      `feature`     | [`requirements.txt`](./versions/cuda11.4.0-cudnn8/requirements.txt) |
| `cuda11.4.1-cudnn8` |      `feature`     | [`requirements.txt`](./versions/cuda11.4.1-cudnn8/requirements.txt) |
| `cuda11.4.2-cudnn8` |      `feature`     | [`requirements.txt`](./versions/cuda11.4.2-cudnn8/requirements.txt) |
| `cuda11.4.3-cudnn8` |      `feature`     | [`requirements.txt`](./versions/cuda11.4.3-cudnn8/requirements.txt) |
| `cuda11.5.1-cudnn8` |      `feature`     | [`requirements.txt`](./versions/cuda11.5.1-cudnn8/requirements.txt) |

## コンテナイメージ の詳細

ベースイメージは全て https://hub.docker.com/r/nvidia/cuda を使用しています．
また，ベースイメージの使用 OS バージョン以下の通りです．

- cuda10.2: ubuntu18.04
- cuda10.2 以外: ubuntu20.04

ビルド日は package registry の `Published about 20 hours ago · Digest` を確認してください．

Note: ベースイメージを最新に保つため一定期間毎にコンテナイメージは再ビルドされます．

### インストールされているツール類
注釈がない場合は最新バージョンがインストールされています．

#### ツール類

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

#### jupyterlab アドオン拡張ツール

- jupyterlab-nvdashboard
- @lckr/jupyterlab_variableinspector
- widgetsnbextension

#### code-server アドオン拡張ツール

- ms-python
- magicstack.magicpython
- coenraads.bracket-pair-colorizer-2
- streetsidesoftware.code-spell-checker
- redhat.vscode-yaml
- pkief.material-icon-theme
- yzhang.markdown-all-in-one


### Python ライブラリ
各イメージ共通でインストールされているライブラリと各イメージごとで異なるバージョンがインストールされているライブラリがあります．

#### 共通ライブラリ
共通ライブラリのバージョンは[こちら](./versions/common/requirements.txt)を参照してください．

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

#### イメージ毎にバージョンが異なるライブラリ
各イメージにインストールされているバージョンはイメージのステータス一覧の表を参照してください．

- anaconda3
- opencv-python
- tensorflow-gpu
- keras
- torch
- torchvision
- torchinfo
- jupyterlab
- optuna
- cupy-cuda
