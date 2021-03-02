# Rails Compose Model

Ruby on Rails の開発環境を Docker で構築する。各技術スタックは、2021年3月2日現在の最新バージョンに対応している。

## 技術スタック

- Alpine Linux 3.13.1
- Ruby: 3.0.0
- PostgreSQL: 13.2
- Ruby on Rails: 6.1.3

### 参照: 最新バージョンの確認

- [Ruby](https://hub.docker.com/_/ruby/)
- [PostgreSQL](https://hub.docker.com/_/postgres/)
- [Ruby on Rails](https://github.com/rails/rails/releases)

## インストールからアプリケーションの起動まで

Rails Compose Model のリポジトリを取得する。

```shell
git clone https://github.com/nemaphila/rails-compose-model
```

ディレクトリ名を任意のアプリケーション名に変更する。

```shell
mv rails-compose-model 任意のアプリケーション名
cd 任意のアプリケーション名
```

.env ファイルを作成する。

```shell
cp .env.sample .env
```

.env を開き、任意のアプリケーション名、データベースのユーザー名とパスワードを追記する。

```
APPLICATION_NAME = 任意のアプリケーション名

DB_USER = 任意のデータベースのユーザー名
DB_PASSWORD = 任意のデータベースのパスワード
```

コンテナを起動し、web コンテナにログインする。

```shell
./setup.sh
docker-compose exec web bash
```

web コンテナにログイン後、Rails アプリケーションを作成する。

```shell
cd 任意のアプリケーション名
rails new . -f -d postgresql
```
.env ファイルを Git 管理対象外とする。
```shell
echo .env >> .gitignore
```
Gemfile を開き、次のように追記する。
```diff
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
+ gem 'dotenv-rails', '~> 2.7.6'

group :development, :test do
```
config/database.yml を開き、次のように追記する。
```diff
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
+  host: db
+  username: <%= ENV['DB_USER'] %>
+  password: <%= ENV['DB_PASSWORD'] %>
```

Gem パッケージをインストールし、データベースを作成する。

```shell
bundle
rails db:create
```

アプリケーションを起動し、[localhost:3000](http://localhost:3000/) で動作することを確認する。

```shell
rails s -b 0.0.0.0
```
