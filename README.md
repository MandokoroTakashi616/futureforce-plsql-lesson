# FutureForce PL/SQLレッスン 学習環境

FutureForce の PL/SQLレッスンで使う、Oracle Database の学習用環境です。
Docker で Oracle Database Free を起動し、EC（商品・注文・在庫）のサンプルデータを投入します。

## 前提

- Docker Desktop（Mac / Windows）
- Docker に割り当てるメモリ 2GB 以上
- Git（Windows は [Git for Windows](https://gitforwindows.org/) に含まれる **Git Bash** を使う）
- [Oracle SQL Developer](https://www.oracle.com/database/sqldeveloper/)

> **SQL Developer を触ったことがない人は、先に [SQL Developer はじめてガイド](docs/sql-developer-guide.md) を読んでください。** インストール・接続の作り方・実行ボタンの使い分け・困ったときの対処をまとめています。

## セットアップ

ターミナル（Mac: ターミナル／Windows: Git Bash）で実行します。

```bash
git clone https://github.com/MandokoroTakashi616/futureforce-plsql-lesson.git
cd futureforce-plsql-lesson
docker compose up -d
docker compose ps
```

`STATUS` が `healthy` になるまで待ちます（初回はイメージのダウンロードを含めて数分かかります）。

## SQL Developer の接続情報

左側の「接続」を右クリック →「新規接続」で、次の内容の接続を作ります（手順の詳細は[ガイドの4章](docs/sql-developer-guide.md#4-接続を作る)）。

| 項目 | 値 |
|------|-----|
| 名前 | futureforce-plsql（任意） |
| ユーザー名 | `learner` |
| パスワード | `learner` |
| 接続タイプ | 基本（Basic） |
| ホスト名 | `localhost` |
| ポート | `1521` |
| サービス名 | `FREEPDB1`（**「SID」ではなく「サービス名」**を選ぶ） |

接続できたら、ワークシートで `SELECT COUNT(*) FROM products;` を実行し、結果が `10` なら準備完了です。

## PL/SQL を実行するときの注意

ワークシートに `SET SERVEROUTPUT ON` と PL/SQL ブロックを書き、**スクリプトの実行（F5）** で実行します。結果は「スクリプト出力」タブに表示されます。

```sql
SET SERVEROUTPUT ON

BEGIN
  DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL');
END;
/
```

**文の実行（Ctrl+Enter）** では `SET SERVEROUTPUT ON` が効かず、出力が表示されません（[ガイドの6章](docs/sql-developer-guide.md#6-plsql-を実行して出力を見るスクリプトの実行)）。

## データを初期状態に戻す

テーブルとデータが初期状態に戻り、レッスンで作ったプロシージャ・ファンクション・パッケージ・トリガーも削除されます。

SQL Developer で `sql/99_reset.sql` を開き、スクリプトの実行（F5）で実行します（[ガイドの7章](docs/sql-developer-guide.md#7-ファイルを開いて実行するデータのリセット)）。

ターミナルから行う場合:

```bash
docker compose exec oracle sqlplus learner/learner@//localhost/FREEPDB1 @/opt/plsql/sql/99_reset.sql
```

## 困ったとき

| 状況 | 対処 |
|------|------|
| 環境を丸ごと作り直したい | `docker compose down -v` の後 `docker compose up -d` |
| 終了したい | `docker compose stop`（再開は `docker compose start`） |
| ポート1521が使用中 | `docker-compose.yml` の `127.0.0.1:1521:1521` の左側を `1522` などに変え、SQL Developer のポートも合わせる |
| `healthy` にならない | `docker compose logs -f oracle` で起動ログを確認。`DATABASE IS READY TO USE!` が出れば起動完了 |
| SQL Developer で接続できない | エラー番号（`ORA-12505` など）ごとの対処を[ガイドの「困ったとき」](docs/sql-developer-guide.md#困ったとき)にまとめています |
| SQL Developer がない環境 | `docker compose exec oracle sqlplus learner/learner@//localhost/FREEPDB1` でコンテナ内の sqlplus を使う。接続後に `SET SERVEROUTPUT ON` を実行する |

## Windows（Git Bash）での注意

- `*.sh` / `*.sql` は `.gitattributes` で改行コードを LF に固定しているため、Git の `core.autocrlf` の設定に関係なくそのまま動きます
- コンテナ内の sqlplus を使うコマンドで `the input device is not a TTY` と表示された場合は、先頭に `winpty` を付けます
- `/opt/...` のようなパスを渡すコマンドは、Git Bash がパスを Windows 形式に書き換えてしまうことがあるため、先頭に `MSYS_NO_PATHCONV=1` を付けます

```bash
# sqlplus で接続する
winpty docker compose exec oracle sqlplus learner/learner@//localhost/FREEPDB1

# ターミナルからデータを初期状態に戻す
MSYS_NO_PATHCONV=1 winpty docker compose exec oracle sqlplus learner/learner@//localhost/FREEPDB1 @/opt/plsql/sql/99_reset.sql
```

## 構成

```
docker-compose.yml   Oracle Database Free（gvenzl/oracle-free:23-slim）
init/01_setup.sh     初回起動時に schema と seed を投入
sql/00_drop.sql      レッスンで作ったプロシージャ・パッケージ・トリガーとテーブルの削除
sql/01_schema.sql    テーブル定義
sql/02_seed.sql      基本データ（教材の期待出力が依存するため変更しない）
sql/99_reset.sql     初期状態に戻す
sql/bulk/            大量データ（準備中）
docs/sql-developer-guide.md  SQL Developer はじめてガイド
```
