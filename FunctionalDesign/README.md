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

## SOLID原則

❌️ SOLIDはOOの原則
⭕️ SOLIDはソフトウェア設計の一般原則

- OCP は 道徳心
- SRP は 原動力
- LSP と ISP は 不注意の警告サイン
- DIP は 基盤

- 単一責任の原則 = SRP = single Responsibility Principle
  - 🔺 モジュールは1つの機能に責任を持つ
  - ⭕️ モジュールは1つのアクターに対して責任を持つ
    - アクター = モジュールを変更する要因となる源 = 人々 = 個人やグループ
      - 同じ理由で同じ時期に変更されるものはまとめる。違う理由で違う時期に変更されるものは分離しておく
  - だから、関数型言語でもSRP違反の設計はできてしまう
- オープン・クローズの原則 = OCP = Open-Closed Principle
  - 拡張にはオープンで、修正にはクローズ
    - モジュールの振る舞いを拡張または変更するときには、既存コードを修正する必要がないようにする
  - 上位レベルの方針を、下位レベルの詳細から分離することができる
    - ただし、上位レベルの方針は、抽象化レイヤーを経由して下位レベルの詳細にアクセスする
- リスコフの置換原則 = LSP = Liskov Substitution Principle
  - ベースタイプを使用する場合、ベースタイプとサブタイプは置換可能でなければならない
    - ダックタイピング
  - LSPは潜在的なOCP違反
- インターフェイス分離の原則 = ISP = Interface Segregation Principle
  - ❌️ 分離する
  - ⭕️ 一緒に使用されるものはまとめる。別々に使用されるものは分ける。必要のないものに依存しない
    - ❌️ プログラミング用語のインターフェイス
    - ⭕️ 一般的な意味でのインターフェイス
- 依存関係逆転の原則 = DIP = Dependency Inversion Principle
  - ❌️ ソースコードと実行時の依存関係が並列
  - 🔺 ソースコードの依存は内側に向け、制御の流れは外側に向ける
  - ⭕️ ソースコードの依存関係を可能な限り抽象に向ける

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

## Links

- <https://github.com/unclebob/spacewar>
- <https://github.com/unclebob/wator>
