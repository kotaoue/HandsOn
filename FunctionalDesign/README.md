# FunctionalDesign

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

## Build and Run Clojure Code

```sh
clj -M ch03-1.clj
```

### Lisp のチュートリアル by アンクル・ボブ

1. C での関数呼び出し = f(x)
1. Lisp での関数呼び出し = (f x)
1. ↑でLispが理解できたのでチュートリアル終了

#### Clojure の補足

1. defn = 関数定義
1. cond = cond関数 = 値を戻すSwitch文
     - condの引数 = ペアのセット。最初の要素は述語で、2番目の要素はその述語がtrueだった場合にcondが戻す値。condはtrueの述語が見つかるまでペアをたどる
1. 述語 = 単なる関数呼び出し
    - (< n 1) は <関数を n と 1 で呼び出す
    - (= n 1) は =関数を n と 1 で呼び出す

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
