(load "a3.scm")

;;;;;;;;;;;;;;;;;;;;;;;		Question 1		;;;;;;;;;;;;;;;;;;;;;;;

(my-last '(cat))
;Value: cat

(my-last '(cat dog))
;Value: dog

(my-last '(cat dog (1 2 3)))
;Value 11: (1 2 3)

(my-last '())
;my-last: empty list


;;;;;;;;;;;;;;;;;;;;;;;		Question 2		;;;;;;;;;;;;;;;;;;;;;;;

(snoc 'a '(1 2 3))
;Value: (1 2 3 a)

(snoc '(1 2 3) '(1 2 3))
;Value: (1 2 3 (1 2 3))


;;;;;;;;;;;;;;;;;;;;;;;		Question 3		;;;;;;;;;;;;;;;;;;;;;;;
(range 4)
;Value 22: (0 1 2 3)

(range 9)
;Value 23: (0 1 2 3 4 5 6 7 8)

(range 0)
;Value: ()

(range -3)
;Value: ()


;;;;;;;;;;;;;;;;;;;;;;;		Question 4		;;;;;;;;;;;;;;;;;;;;;;;
(deep-sum '(a 2 (b (1 c)) 3))
;Value: 6


;;;;;;;;;;;;;;;;;;;;;;;		Question 5		;;;;;;;;;;;;;;;;;;;;;;;
(count-primes -10)
;Value: 0

(count-primes 0)
;Value: 0

(count-primes 10)
;Value: 4

(count-primes 100)
;Value: 25

(count-primes 1000)
;Value: 168

(count-primes 10000)
;Value: 1229

(count-primes 1)
;Value: 0


;;;;;;;;;;;;;;;;;;;;;;;		Question 6		;;;;;;;;;;;;;;;;;;;;;;;
(is-bit? 0)
;Value: #t

(is-bit? 1)
;Value: #t

(is-bit? 2)
;Value: #f

(is-bit? 'cow)
;Value: #f

(is-bit? '(0 1))
;Value: #f

;;;;;;;;;;;;;;;;;;;;;;;		Question 7		;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;		Question 8		;;;;;;;;;;;;;;;;;;;;;;;
(all-bit-seqs 0)
;Value: ()

(all-bit-seqs 1)
;Value 14: ((0) (1))

(all-bit-seqs 2)
;Value 15: ((0 0) (0 1) (1 0) (1 1))

(all-bit-seqs 3)
;Value 16: ((0 0 0) (0 0 1) (0 1 0) (0 1 1) (1 0 0) (1 0 1) (1 1 0) (1 1 1))

(all-bit-seqs -1)
;Value: ()
