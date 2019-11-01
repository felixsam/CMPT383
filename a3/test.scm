(load "a3.scm")

(my-last '(cat))
(my-last '(cat dog))
(my-last '(cat dog (1 2 3)))
(my-last '())

(snoc 'a '(1 2 3))
(snoc '(1 2 3) '(1 2 3))

(range 4)
(range 9)
(range 0)
(range -3)

(deep-sum '(a 2 (b (1 c)) 3))

(count-primes -10)
(count-primes 0)
(count-primes 10)
(count-primes 100)
(count-primes 1000)
(count-primes 10000)
(count-primes 1)

(is-bit? 0)
(is-bit? 1)
(is-bit? 2)
(is-bit? 'cow)
(is-bit? '(0 1))

(all-bit-seqs 0)
(all-bit-seqs 1)
(all-bit-seqs 2)
(all-bit-seqs 3)
(all-bit-seqs -1)