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