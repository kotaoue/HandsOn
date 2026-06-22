(declare fib)

(defn fib-w [n]
  (cond
    (< n 1) nil
    (<= n 2) 1
    :else (+ (fib (dec n)) (fib (- n 2)))))

(def fib (memoize fib-w))

(defn lazy-fibs []
  (map fib (rest (range))))

;(take 10 (lazy-fibs))
;;returns: (1 1 2 3 5 8 13 21 34 55)
;
;(take 30 (lazy-fibs))
;;returns: (1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765 10946 17711 28657 46368 75025 121393 196418 317811 514229)

(println (fib 30))
(println (take 30 (lazy-fibs)))
