# FutureForce PL/SQLレッスン 学習環境

FutureForce の PL/SQLレッスンで使う、Oracle Database の学習用環境です。
Docker で Oracle Database Free を起動し、EC（商品・注文・在庫）のサンプルデータを投入します。

## 前提

- Docker Desktop（Mac / Windows）または Docker Engine（Linux / WSL2）
- Docker に割り当てるメモリ 2GB 以上
- Git
- [Oracle SQL Developer](https://www.oracle.com/database/sqldeveloper/)

## セットアップ

```bash
git clone https://github.com/capital-investment-of-next-stage/futureforce-plsql-lesson.git
cd futureforce-plsql-lesson
docker compose up -d
docker compose ps
```

`STATUS` が `healthy` になるまで待ちます（初回はイメージのダウンロードを含めて数分かかります）。

## SQL Developer で接続する

「新規接続」から次の内容で接続を作成します。

| 項目 | 値 |
|------|-----|
| 名前 | futureforce-plsql（任意） |
| ユーザー名 | `learner` |
| パスワード | `learner` |
| ホスト名 | `localhost` |
| ポート | `1521` |
| サービス名 | `FREEPDB1`（「SID」ではなく「サービス名」を選ぶ） |

接続できたら、ワークシートで次を実行し、結果が `10` なら準備完了です。

```sql
SELECT COUNT(*) FROM products;
```

## PL/SQL を実行するときの注意

`DBMS_OUTPUT.PUT_LINE` の結果を表示するには、ワークシートに次のように書いて **スクリプトの実行（F5）** で実行します。

```sql
SET SERVEROUTPUT ON

BEGIN
  DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL');
END;
/
```

- 結果は「スクリプト出力」タブに表示されます
- **文の実行（Ctrl+Enter / Cmd+Enter）** では `SET SERVEROUTPUT ON` が効かず、出力が表示されません。その場合は「表示」メニュー →「DBMS出力」を開き、接続を選んで出力を有効にします

## データを初期状態に戻す

SQL Developer で `sql/99_reset.sql` を開き、スクリプトの実行（F5）で実行します。

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
| SQL Developer で接続できない | 「SID」ではなく「サービス名」に `FREEPDB1` を入れているか確認 |
| SQL Developer がない環境 | `docker compose exec oracle sqlplus learner/learner@//localhost/FREEPDB1` でコンテナ内の sqlplus を使う。接続後に `SET SERVEROUTPUT ON` を実行する |

## 構成

```
docker-compose.yml   Oracle Database Free（gvenzl/oracle-free:23-slim）
init/01_setup.sh     初回起動時に schema と seed を投入
sql/00_drop.sql      テーブル削除
sql/01_schema.sql    テーブル定義
sql/02_seed.sql      基本データ（教材の期待出力が依存するため変更しない）
sql/99_reset.sql     初期状態に戻す
sql/bulk/            大量データ（準備中）
```
