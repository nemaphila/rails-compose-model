# Rails Compose Model

Ruby on Rails の開発環境を Docker で構築する。各技術スタックは、2021年3月2日現在の最新バージョンに対応している。

## 技術スタックとバージョン

- Alpine Linux 3.13.1
- Ruby: 3.0.0
- PostgreSQL: 13.2
- Ruby on Rails: 6.1.3

### 参照: 最新バージョンの確認

- [Ruby](https://hub.docker.com/_/ruby/)
- [PostgreSQL](https://hub.docker.com/_/postgres/)
- [Ruby on Rails](https://github.com/rails/rails/releases)

## インストールからアプリケーションの起動まで

ディレクトリ名を任意のアプリケーション名に変更する。

```shell
mv rails-compose-model 任意のアプリケーション名
cd 任意のアプリケーション名
```

コンテナを起動し、web コンテナにログインする。

```shell
./setup.sh
docker-compose exec web bash
```

web コンテナにログイン後、任意のアプリケーション名で Rails アプリケーションを作成する。

```shell
rails new 任意のアプリケーション名 -d postgresql
cd 任意のアプリケーション名
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
+  username: postgres
+  password: password
```

データベースを作成し、アプリケーションを起動する。

```shell
rails db:create
rails s -b 0.0.0.0
```

[localhost:3000](http://localhost:3000/) で問題なく動作することを確認する。