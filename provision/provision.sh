#!/bin/sh

sudo su -

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

cp /usr/share/zoneinfo/Japan /etc/localtime
date

echo "nameserver 9.9.9.9" >> /etc/resolv.cof

# インストール済みのパッケージをアップデート
yum -y update

# よく使うコマンドをインストール
yum -y install wget unzip yum-utils mlocate
updatedb

# epel, remi リポジトリを追加して有効化
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum-config-manager --enable epel remi
yum repolist all
yum -y install epel-release

# dockerインストール
# 古いバージョンのDockerをアンインストール
yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine

# 必要なパッケージをインストール
yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# 安定版が含まれるリポジトリを設定
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# 最新バージョンのDocker CEをインストール
yum install -y docker-ce docker-ce-cli containerd.io

# Docker を起動して、hello-world イメージを実行
systemctl start docker
systemctl enable docker
docker run hello-world

# dockerバージョン確認
docker --version

# 現行ユーザをdockerグループに所属させる
# （dockerがインストールされた時点でdockerグループは作られる）
gpasswd -a vagrant docker

# dockerデーモンを再起動する (CentOS7の場合)
systemctl restart docker

# docker-compose
# docker-composeをインストールする
curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

# docker-composeコマンド実行権限の付与
chmod +x /usr/local/bin/docker-compose

# gitのインストール
yum install -y git

# gitの初期設定
git config --global core.filemode false
git config --global core.ignorecase false
git config --global color.ui true
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global core.quotepath false
git config --global core.precomposeunicode true