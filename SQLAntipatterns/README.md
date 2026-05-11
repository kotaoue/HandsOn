# SQLアンチパターン 第2版

[SQLアンチパターン 第2版](https://www.oreilly.co.jp/books/9784814400744/)
ISBN: 978-4-8144-0074-4

- [追加情報](https://pragprog.com/titles/bksap1/sql-antipatterns-volume-1/)

## テスト環境

<!-- cspell:ignore -proot -->
```sh
colima start
docker-compose up -d
docker-compose exec mysql mysql -u root -proot practice
docker-compose down
# docker-compose down -v
colima stop
```

```sh
docker-compose exec -T mysql mysql -u root -proot practice < 1-3.sql
```

```sh
source /sql/1-3.sql;
```

### 環境設定

| 項目 | 値 |
| ------ | ----- |
| ホスト | `localhost:3306` |
| ユーザー | `root` |
| パスワード | `root` |
| データベース | `practice` |

### ER図

```mermaid
erDiagram
 Accounts {
  SERIAL account_id PK
  VARCHAR account_name
  VARCHAR first_name
  VARCHAR last_name
  VARCHAR email
  CHAR password_hash
  BLOB portrait_image
  NUMERIC hourly_rate
 }

 BugStatus {
  VARCHAR status PK
 }

 Bugs {
  SERIAL bug_id PK
  DATE data_reported
  VARCHAR summary
  VARCHAR description
  VARCHAR resolution
  BIGINT reported_by FK
  BIGINT assigned_to FK
  BIGINT verified_by FK
  VARCHAR status FK
  VARCHAR priority
  NUMERIC hours
 }

 Comments {
  SERIAL comment_id PK
  BIGINT bug_id FK
  BIGINT author FK
  DATE comment_data
  TEXT comment
 }

 Screenshots {
  BIGINT bug_id PK,FK
  BIGINT image_id PK
  BLOB screenshot_image
  VARCHAR caption
 }

 Tags {
  BIGINT bug_id PK,FK
  VARCHAR tag PK
 }

 Products {
  SERIAL product_id PK
  VARCHAR product_name
 }

 BugProducts {
  BIGINT bug_id PK,FK
  BIGINT product_id PK,FK
 }

 Accounts ||--o{ Bugs : reported_by
 Accounts ||--o{ Bugs : assigned_to
 Accounts ||--o{ Bugs : verified_by
 BugStatus ||--o{ Bugs : status
 Bugs ||--o{ Comments : has
 Accounts ||--o{ Comments : author
 Bugs ||--o{ Screenshots : has
 Bugs ||--o{ Tags : has
 Bugs ||--o{ BugProducts : maps
 Products ||--o{ BugProducts : maps
```
