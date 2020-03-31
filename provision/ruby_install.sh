#! /bin/sh

# ruby 2.6.3, rails 5.4

sudo yum update
sudo yum install -y git
sudo yum install -y bzip2 gcc openssl-devel readline-devel zlib-devel

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo -e '# rbenv \n
export PATH="$HOME/.rbenv/bin:$PATH" \n
eval "$(rbenv init -)"' >> ~/.bashrc

source ~/.bashrc

rbenv -v

rbenv install --list


rbenv install 2.6.3

rbenv global 2.6.3

ruby -v

gem install bundler

gem query -ra -n  "^rails$"




