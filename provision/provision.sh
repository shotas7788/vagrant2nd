#!/bin/sh

echo -------------------------------
echo
echo historyフォーマット設定
echo
echo -------------------------------

HISTTIMEFORMAT='%y/%m/%d %H:%M:%S ';

echo -------------------------------
echo
echo タイムゾーン設定
echo
echo -------------------------------

sudo cp /usr/share/zoneinfo/Japan /etc/localtime
date

# インストール済みのパッケージをアップデート
sudo yum -y update

# よく使うコマンドをインストール
sudo yum -y install wget unzip yum-utils mlocate
sudo updatedb

# epel, remi リポジトリを追加して有効化
sudo yum -y install epel-release
sudo rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sudo yum-config-manager --enable epel remi
sudo yum repolist all

# dockerインストール
# 古いバージョンのDockerをアンインストール
sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine

# 必要なパッケージをインストール
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# 安定版が含まれるリポジトリを設定
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# 最新バージョンのDocker CEをインストール
sudo yum install -y docker-ce docker-ce-cli containerd.io

# Docker を起動して、hello-world イメージを実行
sudo systemctl start docker
sudo systemctl enable docker
sudo docker run hello-world

# dockerバージョン確認
docker --version

# 現行ユーザをdockerグループに所属させる
# （dockerがインストールされた時点でdockerグループは作られる）
sudo gpasswd -a $USER docker

# dockerデーモンを再起動する (CentOS7の場合)
sudo systemctl restart docker

# docker-compose
# docker-composeをインストールする
sudo curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

# docker-composeコマンド実行権限の付与
sudo chmod +x /usr/local/bin/docker-compose