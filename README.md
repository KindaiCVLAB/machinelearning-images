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
- イメージ名の後の括弧内はステータスを表しています．ステータスについては下表を参照してください．

|  STATUS  |Descriptioin|
|:--------:|:----------:|
|  closed  |セキュリティパッチや深刻なエラー修正も提供されないので，直ちに使用を停止してください．|
|deprecated|セキュリティパッチや深刻なエラー修正のみが提供されます．各ライブラリが最新版に更新されることはありません．|
|  stable  |安定板です．全てのライブラリが最新版に保たれています．|
|  latest  |最新安定板です．全てのライブラリが最新版に保たれており，サーバでの動作は確認していますが，一部動作しない環境があります．|
|  feature |新機能追加中のため特定の環境でしか動作しません．|
|   alpha  |一部 alpha バージョンのパッケージがインストールされていることを示します.|

- [ ] cuda10.0-docker(closed)
- [ ] cuda10.0-fukushima(closed)
- [ ] cuda10.2-cudnn7-docker(closed)
- [x] cuda10.0-cudnn7(deprecated)
- [x] cuda10.1-cudnn7(deprecated)
- [x] cuda10.1-cudnn8(deprecated)
- [x] cuda10.2-cudnn7(deprecated)
- [x] cuda10.2-cudnn8(deprecated)
- [x] cuda11.0-cudnn8(stable)
- [x] cuda11.0.3-cudnn8(latest, alpha)
- [ ] cuda11.1-cudnn8(feature, alpha)
- [ ] cuda11.1.1-cudnn8(feature, alpha)
- [ ] cuda11.2.0-cudnn8(feature, alpha)

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
    - make 
    - build-essential
    - zlib1g-dev
    - libbz2-dev
    - libreadline-dev
    - libsqlite3-dev
    - llvm
    - libncurses5-dev
    - xz-utils
    - tk-dev
    - libxml2-dev
    - libxrender1
    - libxmlsec1-dev
    - libffi-dev
    - liblzma-dev
    - dumb-init  
    - jq  
    - pyenv
    - requests
    - cmake
    - scikit-build
    - jupyterlab-nvdashboard
    - ipywidgets
    - progressbar
    - tqdm
    - addict
    - pycocotools

## cuda10.0 

- cuda10.0-cudnn7 & cuda10.0-docker イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|10.0|
|cudnn|7.x|
|pyenv|1.2.22|
|nodejs|12.x|
|anaconda3|2019.07|
|opencv-python|3.4.7.28|
|tensorflow-gpu|1.13.1|
|keras|2.3.1|
|torch|1.2.0|
|torchvision|0.4.0|
|torchsummary|1.5.1|
|jupyterlab|2.0.0|
|cupy-cuda100|8.1.0|
|code-server|3.8.0|

## cuda10.0-fukushima

- cuda10.0-fukushima イメージのみに含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|10.0|
|cudnn|7.x|
|pyenv|1.2.22|
|nodejs|12.x|
|anaconda3|2019.07|
|opencv-python|3.4.7.28|
|tensorflow-gpu|1.13.1|
|keras|2.3.1|
|torch|1.2.0|
|torchvision|0.4.0|
|torchsummary|1.5.1|
|jupyterlab|2.0.0|
|cupy-cuda100|8.1.0|
|yacs|0.1.6|
|pretrainedmodels|0.7.4|
|imgaug|0.2.9|
|code-server|3.8.0|

## cuda10.1

- cuda10.1-cudnn7 & cuda10.1-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|10.1|
|cudnn|7.x or 8.x|
|pyenv|1.2.22|
|nodejs|12.x|
|anaconda3|2019.07|
|opencv-python|4.2.0.34|
|tensorflow-gpu|2.2.0|
|keras|2.3.1|
|torch|1.5.0|
|torchvision|0.6.0|
|torchsummary|1.5.1|
|jupyterlab|2.0.0|
|cupy-cuda101|8.2.0|
|code-server|3.8.0|


## cuda10.2

- cuda10.2-cudnn7 & cuda10.2-cudnn8 & cuda10.2-cudnn7-docker イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|10.2|
|cudnn|7.x or 8.x|
|pyenv|1.2.22|
|nodejs|15.x|
|anaconda3|2020.11|
|opencv-python|4.5.1.48|
|tensorflow-gpu|2.4.0|
|keras|2.4.3|
|torch|1.7.1|
|torchvision|0.8.2|
|torchsummary|1.5.1|
|jupyterlab|2.2.9|
|cupy-cuda102|8.3.0|
|code-server|3.8.0|

## cuda11.0

- cuda11.0-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.0|
|cudnn|8.x|
|pyenv|1.2.22|
|nodejs|15.x|
|anaconda3|2020.11|
|opencv-python|4.5.1.48|
|tensorflow-gpu|2.4.0|
|keras|2.4.3|
|torch|1.7.1|
|torchvision|0.8.2|
|torchsummary|1.5.1|
|jupyterlab|2.2.9|
|cupy-cuda110|8.3.0|
|code-server|3.8.0|

## cuda11.0.3

- cuda11.0.3-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.0.3|
|cudnn|8.x|
|pyenv|1.2.22|
|nodejs|15.x|
|anaconda3|2020.11|
|opencv-python|4.5.1.48|
|tensorflow-gpu|2.4.0|
|keras|2.4.3|
|torch|1.8.0.dev20210110+cu110|
|torchvision|0.9.0.dev20210110+cu110|
|torchsummary|1.5.1|
|jupyterlab|2.2.9|
|cupy-cuda110|8.3.0|
|code-server|3.8.0|

## cuda11.1

- cuda11.1-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.1|
|cudnn|8.x|
|pyenv|1.2.22|
|nodejs|15.x|
|anaconda3|2020.11|
|opencv-python|4.5.1.48|
|tensorflow-gpu|2.5.0.dev20210110|
|keras|2.4.3|
|torch|1.8.0.dev20210110+cu110|
|torchvision|0.9.0.dev20210110+cu110|
|torchsummary|1.5.1|
|jupyterlab|2.2.9|
|cupy-cuda111|8.3.0|
|code-server|3.8.0|

## cuda11.1.1

- cuda11.1.1-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.1.1|
|cudnn|8.x|
|pyenv|1.2.22|
|nodejs|15.x|
|anaconda3|2020.11|
|opencv-python|4.5.1.48|
|tensorflow-gpu|2.5.0.dev20210110|
|keras|2.4.3|
|torch|1.8.0.dev20210110+cu110|
|torchvision|0.9.0.dev20210110+cu110|
|torchsummary|1.5.1|
|jupyterlab|2.2.9|
|cupy-cuda111|8.3.0|
|code-server|3.8.0|

## cuda11.2.0

- cuda11.2.0-cudnn8 イメージにのみ含まれる物を示しています．

|ライブラリ名 & パッケージ名|バージョン|
|:---:|:---:|
|CUDA|11.2.0|
|cudnn|8.x|
|pyenv|1.2.22|
|nodejs|15.x|
|anaconda3|2020.11|
|opencv-python|4.5.1.48|
|tensorflow-gpu|2.5.0.dev20210110|
|keras|2.4.3|
|torch|1.8.0.dev20210110+cu110|
|torchvision|0.9.0.dev20210110+cu110|
|torchsummary|1.5.1|
|jupyterlab|2.2.9|
|cupy-cuda111|8.3.0|
|code-server|3.8.0|

# 各種ツール類

## jupyterlab アドオン拡張ツール

|拡張ツール名|バージョン|
|:---:|:---:|
|jupyterlab-nvdashboard|latest|
|@lckr/jupyterlab_variableinspector|latest|
|widgetsnbextension|latest|


## code-server アドオン拡張ツール

|拡張ツール名|バージョン|
|:---:|:---:|
|ms-python|2020.10.332292344|
|magicstack.magicpython|latest|
|coenraads.bracket-pair-colorizer-2|latest|
|streetsidesoftware.code-spell-checker|latest|
|redhat.vscode-yaml|latest|
|pkief.material-icon-theme|latest|
|yzhang.markdown-all-in-one|latest|
