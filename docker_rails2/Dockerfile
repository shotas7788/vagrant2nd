FROM sample/rails

# rbenv のパスを通す
ENV PATH $PATH:/usr/local/rbenv/shims     

# 作業用ディレクトリとしてmyappを作成
RUN mkdir /myapp          

# myapp に移動
WORKDIR /myapp 

# Gemfile, Gemfile.lock をコンテナ内にコピー                           
COPY Gemfile /app/Gemfile                 
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# ホストOS上で作成したアプリケーション実行用のファイルをコンテナ内にコピー
COPY . /myapp                             