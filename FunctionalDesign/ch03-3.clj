; === TCO (末尾呼び出し最適化) について ===
;
; TCO (Tail Call Optimization) とは、関数の「末尾」にある再帰呼び出しを
; スタックを積まずにループに変換する最適化のこと。
;
; 通常の再帰はスタックフレームを呼び出しのたびに積むため、深い再帰では
; StackOverflowError が発生する。TCO を適用するとスタックが増えない。
;
; Clojure の TCO: recur
; ---------------------------------------------------
; JVM は言語レベルで TCO をサポートしていないため、Clojure では
; `recur` という特殊フォームで明示的に末尾再帰を表現する。
;
; `recur` の制約:
;   - 必ず「末尾位置 (tail position)」に書く必要がある
;   - 現在の関数 (defn) またはループ (loop) の先頭へジャンプする
;   - 新しいスタックフレームを生成しない → StackOverflow にならない
;
; 下記の fibs-work は (recur ...) が if の else 末尾にあるため TCO が有効。

(defn fibs-work [n i fs]
  (if (= i n)
    fs
    (recur n (inc i) (conj fs (apply + (take-last 2 fs))))))

(defn fibs [n]
  (cond
    (< n 1) []
    (= n 1) [1]
    :else (fibs-work n 2 [1 1])
  )
)

(println (fibs 30))
