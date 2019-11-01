;  Felix Sam
; Closure-based implementation (assignment 4):
;  The environment is a function which takes a variable name and returns
;  its value, if it is bound. This is the second of the two approaches I
;  mentioned on canvas: this version is more natural in a language like scheme.

; In an empty environment, no variables are bound, so every query should
; throw an error. make-empty-env returns a function which always produces an error:
(define 
	(make-empty-env) 
	(lambda 
		(q) 
		(error "variable not bound: " q)
	)
)

; Returns a new environment with v bound to val.
; The new environment checks whether its input is equal to 
; v; if it is, it returns val. If not, it will fall back 
; to the old environment and try again:
(define 
	(extend-env v val env) 
	(lambda 
		(q) 
		(if 
			(equal? q v)
			val 
			(env q) ; env is an environment storing all of the previous variable bindings, but 
			; since env is a function, the only way to access these bindings is by calling env on q.
		)
	)
)

; In this version, apply-env has a very simple implementation!
(define 
	(apply-env env v) 
	(env v) ; env returns the value of v if v is bound.
)
