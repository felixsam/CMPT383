; Felix Sam

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Implentation Details ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Closure based implentation for environment

;; an empty environment is a closure that has an empty list as an environment 
;; it returns a lambda function that takes (v val) as arguments
;; This function takes the pair (v val) and adds it to the environment

;; (extend-env v val env) adds a (v val) pair to the environment env 
;; by calling the function returned by make-empty-env 
;; this (v val) pair is added to the front of the list
;; (extended-env v val env) returns a lambda function (v val) 
;; similar to the lambda function (v val) in make-empty-env 
;; but updated with the new (v val) pair in the environment

;; the helper functions (apply-list lst v) and (env-as-list env) will be used in (apply-env env v)

;; (env-as-list env) will call the lambda function (v val) returned by make-empty-env or updated by extend-env
;; (env-as-list env) calls lambda function ('tempV 'tempVal) 
;; in order to return a list with temporary (v val) pair ('tempV 'tempVal) added to the environment
;; the cdr of this list is the environment which will be used in (apply-list lst v)

;; (apply-list lst v) will take the environment as a list and search (v val) pairs in the environment
;; starting at the front of the list, if v in (v val) is the v we are searching for
;; return the val in the (v val) pair
;; else look at the rest of the environment
;; if v is not in the environment or environment is empty, return an error

;; (apply-env env v) calls (env-as-list env) to get a list of the environment
;; It will also call (apply-list lst v) to get the val of v in this list if v is in the environment
;; else return an error

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		  env2.scm		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
			((null? lst) (error "apply-env: empty environment"))

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

