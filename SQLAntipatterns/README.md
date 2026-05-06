# SQLアンチパターン 第2版

[SQLアンチパターン 第2版](https://www.oreilly.co.jp/books/9784814400744/)
ISBN: 978-4-8144-0074-4

- [追加情報](https://pragprog.com/titles/bksap1/sql-antipatterns-volume-1/)

## テスト環境

```bash
docker compose up -d
docker compose exec mysql mysql -u root -proot practice
docker compose down

# 完全削除
docker compose down -v
```

| 項目 | 値 |
| ------ | ----- |
| ホスト | `localhost:3306` |
| ユーザー | `root` |
| パスワード | `root` |
| データベース | `practice` |
