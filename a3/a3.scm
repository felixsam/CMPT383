;;  Felix Sam
;;;;;;;;;;;;;;;;;;;;;;;		Question 1		;;;;;;;;;;;;;;;;;;;;;;;

;; returns the last element of lst
(define my-last
	(lambda (lst)
		(cond
			;; if lst is null return error
			( (null? lst) (error "my-last: empty list") )
			;; if lst is of length 1 it is the last item of lst
			;; return the item
			( (equal? (length lst) 1) lst )
			;; call the rest of the lst
			( else (my-last (cdr lst) ) )
		)
	)
)


;;;;;;;;;;;;;;;;;;;;;;;		Question 2		;;;;;;;;;;;;;;;;;;;;;;;

;;returns lst with x added to the end of the list
(define snoc
	(lambda (x lst)
		;;define x as a list
		(define item (list x) )
		;;append x to the end of lst 
		(append lst item)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;		Question 3		;;;;;;;;;;;;;;;;;;;;;;;

;;returns the list (0 1 2 ... n-1)
(define range
	(lambda (n)
		(cond
			;;if n is 0 or negative, return the empty list
			( (< n 0) (list) )
			( (= n 0) (list) )
			;; else get the reverse of range-reversed
			;; to return a list from (0,1 ... n-1)
			(else (rev-lst (range-reversed n)))
		)
	)
)

;;function to reverse a list
(define rev-lst
	(lambda (lst)
		(cond 
			  ( (null? lst) (list))
			  ;; append the cdr of the list to the front of the list
			  ( else (append (rev-lst(cdr lst))  (list(car lst)) ) )
		)
	)
)

;;returns the list (n-1 .... 1 , 0)
(define range-reversed
	(lambda (n)
		(cond 
			;;if n is 0 or negative, return the empty list
			( (< n 0) (list) )
			( (= n 0) (list) )
			;; else add n-1 to the list
			( else (cons (- n 1) (range-reversed (- n 1) ) ) )
		)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;		Question 4		;;;;;;;;;;;;;;;;;;;;;;;

;; Based on deep-count-num function from 
;; http://www.cs.sfu.ca/CourseCentral/383/tjd/scheme-intro.html
(define deep-sum
    (lambda (lst)
        (cond
        	;; base case 
        	;; is lst is empty, no numbers to sum
            ((null? lst)
                0)
            ;; if there is a list at the beginning of the list,
            ;; call deep-sum on that list to check if there are numbers to sum
            ((list? (car lst))
                (+ (deep-sum (car lst)) (deep-sum (cdr lst))))
            ;; if the beginning of the list is a number , add that value to the sum
            ;; check the rest of the list for numbers
            ((number? (car lst))
                (+ (car lst) (deep-sum (cdr lst))))
            ;; beginning of the list is not a number or list, ignore it
         	;; look at the rest of the list
            (else
                (deep-sum (cdr lst)))
        )
    )
)

;;;;;;;;;;;;;;;;;;;;;;;		Question 5		;;;;;;;;;;;;;;;;;;;;;;;

;;count-primes Function
(define count-primes
	(lambda (n)
		(cond
			;; if n is less than 2 ,then there are no primes
			( (< n 2) 0)
			;; else call the prime-list function to return a list of Primes less than or equal to n
			;; the length of this list is the number of Primes less than or equal to n
			(else ( length(prime-list n) ) )
		)
	)
)

;;Generate a list of primes
(define prime-list
	(lambda (n)
		(cond
			;; if n is less than 2 then the list will be empty
			( (< n 2) (list))
			;; Base case n = 2 , start the list with 2
			( (= n 2) (list 2))
			( else 
				(cond 
					;; if n is a Prime, add it to the list
					;; then check if n-1 is Prime 
					( (equal? (isprime n) true) (cons n (prime-list (- n 1)) ))
					;;if n is not a Prime check if n-1 is Prime
					( else (prime-list (- n 1) ) )
				)
			)
		)
	)
)


;;function to check if a number n is Prime
(define isprime
	(lambda (n)
		(cond
			  ;;if n is less than 2 , it cannot be Prime
			  ( (< n 2) false) 
			  ;; Base case n=2 is a Prime
			  ( (= n 2) true)
			  ;;Primality Test from https://en.wikipedia.org/wiki/Primality_test
			  ;;Given an input number n, 
			  ;;check whether any prime integer m from 2 to sqrt(n) evenly divides n 
			  ;;use ceiling to get an integer ceiling of sqrt(n)
			  ;;for primality-test function
			  (else (primality-test n ( ceiling(sqrt n))))
		)
	)
)

;;Primality test
(define primality-test
	;;x is the integer to test if it is Prime
	;;y is the modulo to test for divisilibity
	(lambda (x y)
		(cond
			;; a Prime is divisible only by 1 and itself
			;; 2 is the last number to check for divisibility
			( (= y 2) 
				(cond 
					;;if modulo returns 0 then y divides x
					;;x is not prime
					( (= (modulo x y) 0) false)
					(else true)
				)

			)
			(else 
				(cond 
					;;if modulo returns 0 then y divides x
					;;x is not prime
					;;else check the next modulo y-1
					( (= (modulo x y) 0) false)
					(else (primality-test x (- y 1)))

				)
			)
		)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;		Question 6		;;;;;;;;;;;;;;;;;;;;;;;

;; returns true if x is the number 0 or 1 and false otherwise
(define is-bit?
	(lambda (x)
		(cond
			;; check if x is an integer
			( (integer? x)
				;; if x is an integer check if it is 0 or 1
				(cond 
					;; x is a bit only if it is 0 or 1
					((or 
						(= x 0) 
						(= x 1)
					 ) true)
					( else false )
				)
			)
			;; if it's not an integer, it can't be a bit
			(else false)
		)
	)
)


;;;;;;;;;;;;;;;;;;;;;;;		Question 7		;;;;;;;;;;;;;;;;;;;;;;;

;; returns true if lst is the empty list
;; or if it contains only bits (as defined by is-bit?)
(define is-bit-seq?
	(lambda (lst)
		(cond
			;;return true if lst is empty
			( (null? lst) true )
			;;check beginning of lst for bit
			;;if it is a bit, check remaining items in lst
			( (is-bit? (car lst)) (is-bit-seq? (cdr lst)) )
			;;beginning of the list is not a bit
			;;so it can't be a bit-seq
			(else false)
		)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;		Question 8		;;;;;;;;;;;;;;;;;;;;;;;

;;return a list of all the bit-sequences of length n
(define all-bit-seqs
	(lambda (n)
		(cond
			;; if n is less than 1 , then return the empty list
			( (< n 1) (list))
			;; reverse the list from bit-seq-list 
			;; to get all bit-seq from 0 up to 2^n -1 
			(else (rev-lst(bit-seq-list (expt 2 n) n ) ) )

		)
	)
)

;; Get all bit-seq as list for the binary forms of (num - 1) to 0
;; represent the binary forms with length len 
(define bit-seq-list
	(lambda (num len)
		(cond 
			  ;; if the num is 0 or less, return the empty list
			  ( (or
				  (= num 0) 
			  	  (< num 0) 
			  	) (list))
			  ;; add the converted number in binary form to the list
			  ;; starting with num - 1
			  ( else (cons (bit-seq (- num 1) len) (bit-seq-list (- num 1) len ) ) )
		)
	)
)

;; Get a bit-seq of length n 
;; from a converted binary form of a number num
;; represent the binary forms with length len 
(define bit-seq
	(lambda (num n)
		(cond
			;; if the length of the bit seq is same as n
			;; no need to add zeros, return the binary form of num 
			( (= (length (binary num)) n) (binary num) )

			;; if the length of the bit seq is less than n
			;; Call add-zero function to add leading zeros to binary num until it is length n
			( (< (length (binary num)) n) (add-zero  (binary num) (- n (length (binary num)))) )
		)

	)

)

;;add leading zeros to the list n times
(define add-zero
	(lambda (lst n)
		(cond 
			;;negative n , don't add any zeros
			((< n 0) lst)
			;;no more zeros to add
			((= n 0) lst)
			;;add a leading 0 to the list
			(else (cons 0 (add-zero lst (- n 1) ) ) )
		)
	)
)


;;Converts a positive number n > 0 to binary
;;using division by 2
;;returns a list of the bits for n in reverse order
(define binary-reverse
	(lambda (n)
		(cond
			;; base case n = 0
			;; return empty list
			( (= n 0) (list))
			;; if n divides 2 evenly, add a 0 to the list
			;; then divide the quotient by 2
			( (= (modulo n 2) 0) (cons 0 (binary-reverse (quotient n 2) ) ) )
			;; else it leaves a remainder 1 , add 1 to the list
			;; then divide the quotient by 2
			( else (= (modulo n 2) 1) (cons 1 (binary-reverse (quotient n 2) ) ) )
		)
	)
)

;;Convert a number n to binary form
;;by reversing the converted binary from binary-reverse
(define binary
	(lambda (n)
		(rev-lst (binary-reverse n) )
	)
)



