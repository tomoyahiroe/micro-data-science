# 授業ミクロデータサイエンスのリポジトリ

## 目的

R 言語でのデータ分析もその他の言語での開発と同じように、他人に環境ごと共有できたりすると便利かなと思い便利な renv と formatR を導入しました。

renv はパッケージ管理ツールのようです。formatR はインデントなどを整えてくれるライブラリです。

## 使用方法

- git clone https://github.com/tomoyahiroe/micro-data-science.git

- Rstudio で、micro-data-science ディレクトリをワーキングディレクトリに設定してください

- コンソールで、renv::restore()を実行することで必要なパッケージを丸っとインストールできます

- 課題に使用したソースコードや Rmd ファイルは、src/assignment{number}/　にあります
