; Felix Sam

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Simplication Rules ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (0 + e) simplifies to e
;; (e + 0) simplifies to e
;; (0 * e) simplifies to 0
;; (e * 0) simplifies to 0
;; (1 * e) simplifies to e
;; (e * 1) simplifies to e
;; (e - 0) simplifies to e
;; (e - e) simplifies to 0
;; (e ** 0) simplifies to 1
;; (e ** 1) simplifies to e
;; (1 ** e) simplifies to 1
;; if n is a number, then (inc n) simplifies to the value of n + 1
;; if n is a number, then (dec n) simplifies to the value of n - 1



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Simplify Expr ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; returns, if possible, a simplified version of expr


;; based on simplify function from 
;; Simplifying a Propositional Expression
;; http://www.cs.sfu.ca/CourseCentral/383/tjd/scheme-intro.html
(define simplify
	(lambda (expr)
		(cond
			;; if expr is a number, return the number
			( (number? expr)
				expr)
			;; if expr is a symbol, return a symbol 
			( (symbol? expr)
				expr)


            ;; expr (a op b) is an expr of length 3
            ;; op are the operators + * - **
            ;; a or b are either numbers or symbols 
            ( (equal? (length expr) 3)
                (cond

        			;; (0 + e) simplifies to e
                    ;; check if the first element of the expr is 0
                    ;; and check if second element of expr is the addition operator
                    ;; this is equivalent to the third expr
                    ((and (equal? (simplify (first expr)) 0) (equal? (second expr) '+))
                        (simplify (third expr)))

        			;; (e + 0) simplifies to e
                    ((and (equal? (simplify (third expr)) 0) (equal? (second expr) '+))
                        (simplify (first expr)))

        			;; (0 * e) simplifies to 0
                    ((and (equal? (simplify (first expr)) 0) (equal? (second expr) '*))
                        0)

        			;; (e * 0) simplifies to 0
                    ((and (equal? (simplify (third expr)) 0) (equal? (second expr) '*))
                        0)

        			;; (1 * e) simplifies to e
                    ((and (equal? (simplify (first expr)) 1) (equal? (second expr) '*))
                        (simplify (third expr)))

        			;; (e * 1) simplifies to e
                    ((and (equal? (simplify (third expr)) 1) (equal? (second expr) '*))
                        (simplify (first expr)))

        			;; (e - 0) simplifies to e
                    ((and (equal? (simplify (third expr)) 0) (equal? (second expr) '-))
                        (simplify (first expr)))


        			;; (e - e) simplifies to 0
                    ((and (equal? (simplify (first expr)) (simplify (third expr))) (equal? (second expr) '-))
                        0)

        			;; (e ** 0) simplifies to 1
                    ((and (equal? (simplify (third expr)) 0) (equal? (second expr) '**))
                        1)

        			;; (e ** 1) simplifies to e
                    ((and (equal? (simplify (third expr)) 1) (equal? (second expr) '**))
                        (simplify (first expr)))

        			;; (1 ** e) simplifies to 1
                    ((and (equal? (simplify (first expr)) 1) (equal? (second expr) '**))
                        1)

                    
                    ;;run simplify on any sub expr in the expr
                    ;;if there are no sub expr to simplify
                    ;;the simplified expr is returned
                    (else
                        (list (simplify (first expr)) (second expr) (simplify (third expr)))

                    )
                )
            )
            
            ;; expr of length 2 are increment by 1 (inc n) and decrement by 1 (dec n)
            ;; n is the number to increment or decrement
            ( (equal? (length expr) 2)
                (cond 
                    ;; if n is a number, then (inc n) simplifies to the value of n + 1
                    ((and (number? (second expr)) (equal? (first expr) 'inc))
                        (simplify (+ (second expr) 1)))

                    ;; if n is a number, then (dec n) simplifies to the value of n - 1
                    ((and (number? (second expr)) (equal? (first expr) 'dec))
                        (simplify (- (second expr) 1)))
                )
                (else
                    (list (first expr) (simplify (second expr)))
                )
            )
            
            ;; if expr is not of length 3, form: (a op b)
            ;; or if expr is not of length 2, form: (inc a) or (dec a)
            ;; return the expr
            (else expr)
		)
	)
)

