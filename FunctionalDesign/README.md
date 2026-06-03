# DockerHandsOn

[関数型 デザイン 原則、パターン、実践](https://www.kadokawa.co.jp/product/302404003071/) ISBN: 9784048931151

## Build and Run C Code

```sh
make crun main.c
```

## Build and Run Java Code

```sh
javac ch02−1.java && java Sieve

# 引数付き
javac ch02−1.java && java Sieve 100
```

## Notes

- 関数型プログラミング is 何
  - 🔺 関数を使用したプログラミング
  - 🔺 関数が「第一級」の要素であるプログラミング
  - 🔺 参照透過性を備えたプログラミング
  - 🔺 ラムダ計算に基づいたプログラミングスタイル
  - ⭕️ 「代入文の無いプログラミング」by アンクル・ボブ

## Glossary

- 参照透過性
  - 「ある式」を「その評価結果の値」に置き換えても、プログラム全体の振る舞いが一切変わらない性質
