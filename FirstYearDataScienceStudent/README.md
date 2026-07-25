# FirstYearDataScienceStudent

[データサイエンス1年生](https://www.shoeisha.co.jp/book/detail/9784798176017) ISBN: 9784798176017

## Run sample code

```sh
cd FirstYearDataScienceStudent
uv sync
uv run python ch01-1.py
```

### Check Unused Imports

```sh
uvx ruff check . --select F401
uvx ruff check . --select F401 --fix
```
