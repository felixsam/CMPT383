; Felix Sam
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Environment env2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Closure Based Environment env2.scm

;; make an empty environment
;; use a list outside the lambda function (v val) as an environment to store (v val) pairings
;; when lambda (v val) is called, add the pair (v val) to the list
(define make-empty-env
    (lambda ()
        (let ( (env (list) ) )
            (lambda ( v val) 
                (set! env (cons (list v val) env))
                env
            )
        )
    )
)

;; Returns a new environment that is the same as env except that the value of v in it is val.
;; If v already has a value in env, then in the newly returned environment this value will be shadowed.
(define extend-env
    (lambda (v val env)
        ;; get the environment closure from make-empty-env
        (let ((env2 (env v val)) )
            (lambda (v1 val1)
                ;; add the (v val) pair to the environment
                (set! env2 (cons (list v1 val1) env2))
                ;; return the updated environment
                env2
            )
        )
    )
)

;; Returns the value of variable v in environment env.
(define apply-env
    (lambda (env v)
        ;; call env-as-list to get the environment as a list
        (define env2 (env-as-list env))
        ;; call apply-lst on the environment to find the value of v 
        (apply-lst env2 v)  
    )
)

;;call the env closure from make-empty-env
;;to get the environment as a list
(define env-as-list
    (lambda (env)
        ;; call the closure in make-empty-env with a (v val) pair ('tempV 'tempVal)
        ;; the cdr of this list will contain the environment as a list to be used in apply-lst
        (cdr(env 'tempV 'tempVal))
    )
)


;; finds the value of val in (v val) if v exists in the list
(define apply-lst
    (lambda (lst v)
        (cond
            ;; if the lst is empty, then the environment is empty
            ;; or v is not in the environment
            ;; then return an error
            ((null? lst) (error "apply-env: unknown variable" v))

            ;; search if v is in the environment by looking at the first (v val) pair
            ;; if v is in this pair then get its val
            ;; else search the rest of the (v val) pairs
            ( else
                (cond 
                    ;; check the v in the first (v val) pair in the list
                    ;; if it is the v that we want, get its val
                    ( (equal? (car(car lst)) v) (get-val (car lst)) )
                    ;; else look at the rest of the (v val) pairs in the list
                    (else (apply-lst (cdr lst) v)) 
                )
            )

        )
    )
)

;; From the pair (v val)
;; get the v val by getting the second element of the pair
(define get-val
    (lambda (lst)
        ;; index 1 contains the val for the pair
        (list-ref lst 1)
    )
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; EBNF Grammar ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;   expr =   "(" expr "+" expr ")"
;;          | "(" expr "-" expr ")"
;;          | "(" expr "*" expr ")"
;;          | "(" expr "/" expr ")"
;;          | "(" expr "**" expr ")"  ;; e.g. (2 ** 3) is 8, (3 ** 3) is 27
;;          | "(" "inc" expr ")"      ;; adds 1 to expr
;;          | "(" "dec" expr ")"      ;; subtracts 1 from expr
;;          | var
;;          | number
;; number = a Scheme number
;; var    = a Scheme symbol

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; EBNF Grammar ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; myeval function ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evaluates the infix expression expr in the environment env


;; Based on logic and structure from simplify function 
;; in section Simplifying a Propositional Expression 
;; from http://www.cs.sfu.ca/CourseCentral/383/tjd/scheme-intro.html
(define myeval
    (lambda (expr env)
    	(cond
    		;; if the expr is a number
    		;; return the number
    		((number? expr) 
    			expr)

    		;; if expr is symbol
    		;; call (apply-env env expr) on the expr
    		((symbol? expr)
    			(apply-env env expr))


;; To evaluate expressions of the form (op expr)
;; check the first element of expr for the op
;; then do the correct operation on the second element of expr


    		;; expr = "(" "inc" expr ")"      
    		;; adds 1 to expr
            ;; check if the first element in expr is 'inc
            ;; if it is, the second element of the expr is increased by 1
    		((equal? (first expr) 'inc)
    			(+ (myeval (second expr) env) 1))

    		;; expr = "(" "dec" expr ")"      
    		;; subtracts 1 from expr 
      		((equal? (first expr) 'dec)
    			(- (myeval (second expr) env) 1))  
    			



;; To evaluate expressions of the form (expr op expr)
;; check the second element of expr for the op
;; then do the correct operation for the first and third element of expr


      		;; expr = "(" expr "**" expr ")"
            ;; check if the second expr is the operator **
            ;; if it is the first expr is raised to the value of third expr
    		((equal? (second expr) '**)
    			(expt (myeval (first expr) env) 
    				(myeval (third expr) env)
    			)
    		)

			;; expr = "(" expr "*" expr ")"	
    		((equal? (second expr) '*)
    			(* (myeval (first expr) env) 
    				(myeval (third expr) env)
    			)
    		)

    		;; expr = "(" expr "/" expr ")"
    		((equal? (second expr) '/)
                ;;check for divison by 0
                ;;throw error if it is
    			(cond
    				( (equal? (third expr) 0)
    					(error "myeval: Division by 0 not allowed")
    				)
    				(else
		    			(/ (myeval (first expr) env) 
		    				(myeval (third expr) env)
		    			)
    				)
    			)

    		)

			;; expr = "(" expr "+" expr ")"		
    		((equal? (second expr) '+)
    			(+ (myeval (first expr) env) 
    				(myeval (third expr) env)
    			)
    		)

    		;; expr = "(" expr "-" expr ")"
    		((equal? (second expr) '-)
    			(- (myeval (first expr) env) 
    				(myeval (third expr) env)
    			)
    		)

    		;; if expr does not follow EBNF Grammar
    		;; return an error
    		(else 
    			(error "myeval: Expression does not follow EBNF Grammar")
    		)

    	)
        
    )
)