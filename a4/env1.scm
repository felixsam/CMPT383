; Felix Sam

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Implentation Details ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; list based implentation for environment

;; an empty environment is a list with two empty lists nested where:
;; first list holds v's 
;; second list holds val's


;; (extend-env v val env) will take v and add it to the front of the first list that contains v's
;; it will also take val and adds it to the front of the second list that contains val's


;; (apply-env env v) checks if the first element in the list containing v's is the v we are searching for
;; if it is get the corresponding val that matches with v
;; if it isn't check the rest of the v-list for the v we are searching
;; if the list of v's are searched, or the list is empty, return an error


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 		env1.scm 		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; make an empty environment
;; an empty environment is a list with two empty lists nested
;; first list holds v 
;; second list holds val
(define make-empty-env
	(lambda ()
		(list (list) (list))
	)
)


;; Returns a new environment that is the same as env except that the value of v in it is val.
;; If v already has a value in env, then in the newly returned environment this value will be shadowed.
(define extend-env
	(lambda (v val env)
		;; get the list for v's seperately and then add the new v to this list
		(define v-list (cons v (first env)))
		;; get the list for val's seperately and then add the new val to this list
		(define val-list (cons val (second env)))
		;; update the environment with the new (v val)
		(list v-list val-list)
	)
)

;; Returns the value of variable v in environment env.
;; If v is not in env, then use Scheme’s standard error function to raise a helpful error message.
(define apply-env
	(lambda (env v)
		(cond
			;; if the v-list is empty, then v is not in the environment
			;; or the v-list has been searched
			;; return an error
			((null? (first env)) (error "apply-env: empty environment"))

            (else
				(cond 
					;; check the first element in the list of v's to see if it is the v we are looking for
					;; if it is get the matching val for the v
					( (equal? (car (first env)) v) (car(second env)) )
					;; if v is not at the beginning of the v list
					;; check the rest of the v list to see if v is in the environment
					(else (apply-env (list (cdr(first env)) (cdr (second env))) 
						v)) 
				)
			)
		)
	)
)