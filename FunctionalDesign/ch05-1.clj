; 通常の対話型関数
; void p (Input x) {
;   while (x != DONE)
;     x = (getInput(f(x)))
; }

; 関数型の対話型関数
; システムの状態を保持する変数が無い
; void p (Input x) {
; if (x == DONE)
;  p(getInput(f(x)));
; }
