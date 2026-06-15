;; ch03-0-2.clj

;; defn = 関数定義
;; (defn 関数名 [引数] 本体)

;; cond = 条件分岐の式
;; cond は「値を返す」
;; 述語と結果のペアを左から順に見て、最初に true の結果を返す
(defn classify [n]
  (cond
    (< n 1) "less than 1"
    (= n 1) "equal to 1"
    :else   "greater than 1"))

(println "(< 0 1) =>" (< 0 1))

(println "(= 0 0) =>" (= 0 0))
(println "(= 0 1) =>" (= 0 1))
(println "(= 1 0) =>" (= 1 0))
(println "(= 1 1) =>" (= 1 1))

(println "(classify 0) =>" (classify 0))
(println "(classify 1) =>" (classify 1))
(println "(classify 2) =>" (classify 2))
