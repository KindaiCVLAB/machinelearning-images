# CVLAB Original Container Images for Deeplearning

本リポジトリは CVLAB メンバー用に作成した DeepLearning 用コンテナイメージを保管するリポジトリです． 主に CKS で利用されることを想定して作成されています．

# 概要

- 全てのコンテナイメージは権限設定を行っており， UID 1000 で起動した場合のみ正常に動作します．そのためコンテナ起動後の pip や conda を用いたライブラリの追加は可能ですが，apt 経由でのパッケージの追加はできません．

- apt を使ったパッケージ類でサポートして欲しい物がある場合，以下 2種類の方法で依頼することができます．(希望に答えられない場合もあります．) 
- pip や conda のライブラリのデフォルト追加依頼も下記で可能です．
    1. Issue を立てて機能リクエストを作成する
    2. 入れて欲しいパッケージやライブリを含んだ Dockerfile を作成して MergeRequest を出す．
    - __Slack での依頼は受け付けておりません．__

# 動作状況

- 全てのイメージを全ての環境でテストすることはできないので以下の動作状況は参考程度にしてください．
- チェックマークがついているものは確認したものですが，ついていない物は未確認のため動かないという意味ではないです．

- [x] cuda10.0
- [x] cuda10.0-docker
- [x] cuda10.0-fukushima
- [x] cuda10.2-cudnn7
- [x] cuda10.2-cudnn7-docker
- [ ] cuda10.2-cudnn8
- [ ] cuda11.0-cudnn8

# コンテナイメージ の詳細

- ベースイメージは全て [NGC](https://ngc.nvidia.com/catalog/containers) の cuda-cudnn を使用しています．Dockerhub の pull 制限につき今後は [NGC](https://ngc.nvidia.com/catalog/containers) をメインで使用していきます．

## 各イメージ共通ライブラリ & パッケージ

- 各イメージで共通で使用されている物一覧です．
- バージョンはコンテナイメージがビルドされた時点での最新のものになっています．
- ビルド日は container registry の以下のような項目を確認してください．
    - ```Published to the kindaicvlab/deeplearning image repository at 06:19 GMT+0900 on 2020-10-20```

- 共通イメージを最新に保つため一定期間毎にコンテナイメージは再ビルドされます．


- ライブラリ & パッケージ一覧
    - curl
    - wget
    - git
    - unzip
    - imagemagick
    - bzip2
    - vim
    - libsm6
    - libgl1-mesa-dev
    - build-essential
    - libssl-dev
    - pyenv
    - requests
    - cmake
    - scikit-build
    - jupyterlab-nvdashboard
    - ipywidgets
    - progressbar
    - tqdm
    - addict

## cuda10.0 

- cuda10.0 & cuda10.0-docker イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|10.0|
|cudnn|7.x|
|nodejs|12.x|
|anaconda3|2019.07|
|opencv-python|3.4.7.28|
|tensorflow-gpu|1.13.1|
|keras|2.3.1|
|torch|1.2.0|
|torchvision|0.4.0|
|torchsummary|1.5.1|
|jupyterlab|2.0.0|
|cupy-cuda|100|

## cuda10.0-fukushima

- cuda10.0-fukushima イメージのみに含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|10.0|
|cudnn|7.x|
|nodejs|12.x|
|anaconda3|2019.07|
|opencv-python|3.4.7.28|
|tensorflow-gpu|1.13.1|
|keras|2.3.1|
|torch|1.2.0|
|torchvision|0.4.0|
|torchsummary|1.5.1|
|jupyterlab|2.0.0|
|cupy-cuda|100|
|yacs|0.1.6|
|pretrainedmodels|0.7.4|
|imgaug|0.2.9|

## cuda10.2

- cuda10.2-cudnn7 & cuda10.2-cudnn8 & cuda10.2-cudnn7-docker イメージにのみ含まれる物を示しています．

