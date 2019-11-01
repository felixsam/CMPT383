-- Felix Sam
-------------------------------------------- Question 1 --------------------------------------------
-- The snoc x lst functions returns a new list that is the same as lst, 
-- except x has been added to the end of it
snoc :: a -> [a] -> [a] -- type signature
snoc a [] = [a]         -- base case
snoc a (x:xs) = x : snoc a (xs) --recursive case



-------------------------------------------- Question 2 --------------------------------------------
-- Write your own version of the Haskell append operator ++
myappend :: [a] -> [a] -> [a] --type signature
myappend lst [] = lst  -- base case
myappend lst (x:xs) = myappend (snoc x lst) xs -- recursive case



-------------------------------------------- Question 3 --------------------------------------------
-- Write your own version of reverse
myreverse :: [a] -> [a] --type signature
myreverse [] = []  -- base case
myreverse (x:xs) = (myappend (myreverse xs) [x])  -- recursive case


--------------------------------------------  Question 4 --------------------------------------------
-- Write a function called count_emirps n that returns the number of emirps less than, or equal to, n.

-- smallest divisor
-- http://www.cs.sfu.ca/CourseCentral/383/tjd/haskell_intro_lhs.html
smallest_divisor :: Int -> Int
smallest_divisor n
     | n < 0     = error "n must be >= 0"
     | n == 0    = 0
     | n == 1    = 1
     | otherwise = head (dropWhile (\x -> n `mod` x /= 0) [2..n])


-- is_Prime function
-- http://www.cs.sfu.ca/CourseCentral/383/tjd/haskell_intro_lhs.html
is_prime :: Int -> Bool
is_prime n | n < 2     = False
           | otherwise = (smallest_divisor n) == n


-- reverse a positive int 
-- based on code https://stackoverflow.com/questions/19725292/how-to-reverse-an-integer-in-haskell
-- read, reverse and show are from standard prelude
reverseInt :: Int -> Int
reverseInt = read.reverse.show


-- check if an int is an emirp
is_emirp :: Int -> Bool
is_emirp n | n < 13 = False 
            -- an emirp is a prime that when reversed is a different prime
            -- check if n is prime,  if the reverse of n is not equal to n and if the reverse of n is prime
           | otherwise = is_prime n && (reverseInt n /= n) && is_prime (reverseInt n)


-- count emirps up to n
-- if n < 13 then return 0
-- else the length for the list of emirps from 13 to n is the number of emirps up to n
count_emirps :: Int -> Int
count_emirps n | n < 13 = 0
               | otherwise = length (filter is_emirp [13..n])

 
-------------------------------------------- Question 5 --------------------------------------------
 
-- Write a function called biggest_sum that takes a list of integer lists as input, 
-- and returns the list with the greatest sum.
biggest_sum :: [[Int]] -> [Int]
biggest_sum (x:[]) = x -- base case : biggest sum of only one list is that list
biggest_sum (x:xs) =
    -- check sum of first int list and last int list
    -- if the first int list is smaller, discard it
    -- check the sums in the the rest of the list
    if ( (sum x) < (sum (last xs)))
        then biggest_sum (xs)
    -- if sum of the first int list is greater
    -- discard the last list, check the first list with the remaining list
    else biggest_sum (init (x:xs))

-------------------------------------------- Question 6 --------------------------------------------
-- greatest f seq returns the item in seq that maximizes function f. For example:
-- greatest sum [[2,5], [-1,3,4], [2]]
-- [2,5]
greatest :: (a -> Int) -> [a] -> a
greatest f (x:[]) = x -- base case, if there is only one item, that item maximized function f
greatest f (x:xs) =
    -- compare first and last items in seq using function f
    if ( (f x) > (f (last xs)) )
        -- if first item is greater, then compare first item with 2nd last
        then greatest f (init (x:xs))
        -- else compare items after the first item
    else greatest f (xs)

-------------------------------------------- Question 7 --------------------------------------------
-- Write a function called is_bit x that returns True when x is 0 or 1, and False otherwise.
-- Assume x is of type Int, and the type of the returned value is Bool.

is_bit :: Int -> Bool
is_bit x 
    | x == 0 || x == 1 = True
    | otherwise = False

-------------------------------------------- Question 8 --------------------------------------------
-- Write a function called flip_bit x that returns 1 if x is 0, and 0 if x is 1. 
-- If x is not a bit, then call error msg, where msg is a helpful error message string.
flip_bit :: Int -> Int
flip_bit x
    | x == 0 = 1
    | x == 1 = 0
    | otherwise = error "Not a Bit!"

-------------------------------------------- Question 9 --------------------------------------------
-- Write a function called is_bit_seq1 x that returns True if x is the empty list, 
-- or if it contains only bits (as determined by is_bit).
-- Use recursion and guarded commands in your solution.

is_bit_seq1 :: [Int] -> Bool
is_bit_seq1 x
    | null x = True -- empty list
    | is_bit (head x) = is_bit_seq1 (tail x) -- head is a bit, check rest of list
    | otherwise = False -- head is not a bit, list is not bit seq

-- Re-do the previous question, except this time name the function is_bit_seq2 x, 
-- and use recursion and at least one if-then-else expression in your solution. 
-- Don’t use any guarded commands.
is_bit_seq2 :: [Int] -> Bool
is_bit_seq2 x =
    if null x
        then True -- empty list
    else if is_bit (head x)
        then is_bit_seq2 (tail x) -- head is a bit, check rest of list
        else False -- head is not a bit, list is not bit seq

-- Re-do the previous question, 
-- except this time name the function is_bit_seq3 x, 
-- and use the all function in your solution. 
-- Don’t use recursion, guarded commands, or if-then-else.
is_bit_seq3 :: [Int] -> Bool
is_bit_seq3 x = all is_bit x -- all function returns true only if all items in [Int] are bits

-------------------------------------------- Question 10 --------------------------------------------
-- In each of the following functions, x is a list of Int values, 
-- and the type of the returned value is also a list of Int. 

-- Write a function called invert_bits1 x that returns a sequence of bits that is the same as x, 
-- except 0s become 1s and 1s become 0s.
invert_bits1 :: [Int] -> [Int] -- type signature
invert_bits1 [] = [] -- base case
invert_bits1 (x:xs) = (myappend [(flip_bit x)] (invert_bits1 xs) )  -- recursive case


-- Re-do the previous question, but name the function invert_bits2 x, 
-- and it implement it using the map function (and no recursion).
invert_bits2 :: [Int] -> [Int]
invert_bits2 x = (map (flip_bit) x) -- apply flip_bit to all bits in list x


-- Re-do the previous question, but name the function invert_bits3 x, 
-- and it implement it using a list comprehension (and no recursion, and no map function).
invert_bits3 :: [Int] -> [Int]
invert_bits3 x = [flip_bit lst | lst <- x] -- apply flip_bit to all bits in list x


-------------------------------------------- Question 11 --------------------------------------------

-- count_one helper function
-- counts all the ones in a list of int
count_one :: [Int] -> Int
count_one [] = 0
count_one (x:xs) 
   | x == 1 = 1 + (count_one xs)
   | otherwise = count_one xs

-- count_zero helper function
-- counts all the zeros in a list of int
count_zero :: [Int] -> Int
count_zero [] = 0
count_zero (x:xs) 
   | x == 0 = 1 + (count_zero xs)
   | otherwise = count_zero xs

-- Write a function called bit_count x that returns a pair of values indicating the number of 0s and 1s in x. 
-- For example, bit_count [1,1,0,1] returns the pair (1, 3).
bit_count :: [Int] -> (Int, Int)
bit_count x = (count_zero x,count_one x) 




-------------------------------------------- Question 12 --------------------------------------------
-- Write a function called all_basic_bit_seqs n that returns a list of all bit sequences of length n. 
-- The order of the sequences doesn’t matter. If n is less than 1, then return an empty list.
-- all_basic_bit_seqs Int -> [[Int]]

--Converts a decimal n to its binary form as int bit seq of length len
decToBinary :: Int -> Int -> [Int]
decToBinary n len
    | n < 0 = []  -- If n is negative return an empty list

                  -- To get the nth bit :  n/(2^(n-1)) mod 2
                  -- reverse this sequence to get the Decimal converted to bit sequence
    | otherwise = myreverse[ ( (n `div` (2 ^ (x-1))) `mod` 2 ) | x <- [1..len]] 


-- list of all bit sequences of length n is binary forms of 0 to 2^n - 1
all_basic_bit_seqs :: Int -> [[Int]]
all_basic_bit_seqs n
    | n < 1 = [] -- If n is less than 1, then return an empty list.
    | otherwise = [ decToBinary x n | x <- [0..( (2^n) - 1)]] -- Get all bit sequence from 0 to 2^n - 1

-------------------------------------------------------------------------------------------------------
-------------------------------------------- Bit data type --------------------------------------------
data Bit = Zero | One
    deriving (Show, Eq)
-------------------------------------------- Bit data type --------------------------------------------
-------------------------------------------------------------------------------------------------------




-------------------------------------------- Question 13 --------------------------------------------
-- Implement flipBit :: Bit -> Bit, which changes a Zero to a One, and vice-versa.
flipBit :: Bit -> Bit
flipBit x 
    | x == Zero = One
    | x == One = Zero



-------------------------------------------- Question 14 --------------------------------------------
-- Implement invert :: [Bit] -> [Bit], which flips all the bits in the input list
invert :: [Bit] -> [Bit]
invert lst = (map (flipBit) lst)


-------------------------------------------- Question 15 --------------------------------------------
-- Implement all_bit_seqs n, which returns a list of Bit lists representing all possible bit sequences of length n.

-- Helper Function convertToBit x
-- Convert a Bit 0 or 1 of type Int to type Bit
convertToBit :: Int -> Bit
convertToBit x
    | x == 0 = Zero
    | x == 1 = One
    | otherwise = error "Not 0 or 1 !"

-- Helper Function decToBits
-- Convert a decimal to a bit sequence with length len of type Bit [Bit] 
decToBits :: Int -> Int -> [Bit]
decToBits n len
    | n < 0 = [] -- if n is negative return empty list
    -- else convert all the int bits to Bit type to get Binary number represented as Bit Type
    | otherwise = (map (convertToBit) (decToBinary n len))

-- list of all bit lists of length n is binary forms of 0 to 2^n - 1 represented as Bit type
all_bit_seqs :: Int -> [[Bit]]
all_bit_seqs n
    | n < 1 = [] -- If n is less than 1, return empty list
    -- else get all decimals from 0 to 2^n -1 represented as type Bit
    | otherwise = [ decToBits x n | x <- [0..( (2^n) - 1)]] 

-------------------------------------------- Question 16 --------------------------------------------
-- Helper Function bitToInt
-- converts Bit to an integer 0 if Zero
-- Or 1 if One
bitToInt :: Bit -> Int
bitToInt x
    | x == Zero = 0
    | x == One = 1
    | otherwise = error "Not a Bit !"

-- Implement bitSum1 :: [Bit] -> Int, 
-- which returns the sum of the bits in the input where Zero is 0, and One is 1.
bitSum1 :: [Bit] -> Int
bitSum1 lst = sum (map (bitToInt) lst ) -- convert [Bit] to [Int] and then sum them up



-------------------------------------------- Question 17 --------------------------------------------
-- Implement bitSum2 :: [Maybe Bit] -> Int, which returns the sum of the maybe-bits in the input, 
-- i.e. Just Zero is 0, Just One is 1, and Nothing is 0. 

-- Based on function  maybeSum :: [Maybe Integer] -> Integer 
-- http://www.cs.sfu.ca/CourseCentral/383/tjd/basic_user_types_lhs.html 
bitSum2 :: [Maybe Bit] -> Int
bitSum2 [] = 0 -- base case empty list
bitSum2 (Nothing:xs) = bitSum2 xs -- do not sum up Nothing
bitSum2 ((Just x):xs) 
    | x == One = (+1) (bitSum2 xs) -- Sum up Just One's
    | otherwise = bitSum2 xs -- do not sum up Just Zero's

bitSum3 :: [Maybe Bit] -> Int
bitSum3 [] = 0 -- base case empty list
bitSum3 (x:xs) = 
    if x == Nothing || x == Just Zero
        then bitSum3 xs
    else (+1) (bitSum3 xs)

---------------------------------------------------------------------------------------------------------------
-------------------------------------------- Custom List Data Type --------------------------------------------
data List a = Empty | Cons a (List a)
    deriving Show
-------------------------------------------- Custom List Data Type --------------------------------------------
---------------------------------------------------------------------------------------------------------------




-------------------------------------------- Question 18 -------------------------------------------- 
-- Implement toList :: [a] -> List a, which converts a regular Haskell list to a List a.
toList :: [a] -> List a
toList [] = Empty -- base case empty Haskell List
toList (x:xs) = Cons x (toList xs)  -- recursive case



-------------------------------------------- Question 19 --------------------------------------------
-- Implement toHaskellList :: List a -> [a], which converts a List a to a regular Haskell list.
toHaskellList :: List a -> [a]
toHaskellList Empty = [] -- base case
toHaskellList (Cons first rest) = (myappend [first] (toHaskellList rest)) -- recursive case



-------------------------------------------- Question 20 --------------------------------------------
-- Implement append A B, that returns a new List a that consists of all the elements of A followed by all the elements of B. 
-- In other words, it does for List a what ++ does for regular Haskell lists. 
append :: List a -> List a -> List a
append Empty lst = lst -- base case, appending empty list to a list returns the same list
append (Cons first rest) lst2 = Cons first (append rest lst2) -- recursive case



-------------------------------------------- Question 21 --------------------------------------------
-- Implement the function removeAll f L that returns a List a that is the same as L but all items satisfying
-- f (i.e. for which f returns True) have been removed. 
-- f is a predicate of type a -> Bool and L has type List a.
removeAll :: (a -> Bool) -> List a -> List a
removeAll f Empty = Empty -- base case 
removeAll f (Cons first rest) =
    if ( (f first) == True ) -- call function f on the first item of List a
        then (removeAll f rest) -- if it returns true remove it, check rest of List a
    else (append (Cons first Empty) (removeAll f rest)) -- else check the rest of List a



-------------------------------------------- Question 22 --------------------------------------------
-- Implement the function sort L, where L has type List a, 
-- that returns a new List a equal to L in ascending order. 
-- Based on quicksort from http://www.cs.sfu.ca/CourseCentral/383/tjd/haskell_functions_lhs.html
sort :: Ord a => List a -> List a
sort Empty = Empty -- base case
                        
                         -- partition first between items smaller than it and items bigger than it
                         -- smalls ++ [x] ++ bigs
sort (Cons first rest) = (append (append smalls (Cons first Empty)) bigs)

                                -- smalls = sort the list with all elements >= first removed
                         where smalls = sort ( (removeAll (\x -> x >= first) rest ) )

                                -- bigs = sort the list with all elements < first removed
                               bigs = sort ( (removeAll (\x -> x < first) rest ) )


-------------------------------------------- Practice 1 --------------------------------------------
-- Write a function called isdigit that 
-- tests if a character is one of the digits '0', '1', ..., '9'. 
-- It has this signature:
isdigit :: Char -> Bool
isdigit c = elem c "0123456789"

-------------------------------------------- Practice 2 --------------------------------------------
-- Write a function called isletter 
-- that tests if a character is one of the 26 lowercase letters 'a', 'b', ..., 'z',
--  or one of the 26 uppercase letters 'A', 'B', ..., 'Z'. It has this signature:
isletter :: Char -> Bool
isletter c = elem c "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
-------------------------------------------- Practice 3 --------------------------------------------
--The following functions each take a predicate function and a list as input, 
--and remove certain items from the list based on the predicate function. 
--They all have this signature: (a -> Bool) -> [a] -> [a]

-- ltrim removes all items from the start of the list that satisfy the predicate function.
ltrim :: (a -> Bool) -> [a] -> [a]
ltrim _ [] = [] -- base case
ltrim f (x:xs) = 
    if f x 
        then ltrim f xs
    else 
        x:xs

-- rtrim removes all items from the end of the list that satisfy the predicate function.
rtrim :: (a -> Bool) -> [a] -> [a]
rtrim f lst = reverse (ltrim f (reverse lst))

-- trim removes all items from both the start and end of the list that satisfy the predicate function.
trim :: (a -> Bool) -> [a] -> [a]
trim f lst = ltrim f (rtrim f lst)


-------------------------------------------- Practice 4 --------------------------------------------
-- lpad c n lst returns a new list equal to lst but with n copies of c on the left side. 
-- Write the most general type signature for it.
lpad :: a -> Int -> [a] -> [a]
lpad c n lst = (replicate n c) ++ lst

lpad2 :: a -> Int -> [a] -> [a]
lpad2 _ 0 lst = lst
lpad2 _ _ [] = []
lpad2 c n lst = [c] ++ (lpad2 c (n-1) lst)

lpad3 :: a -> Int -> [a] -> [a]
lpad3 c n lst
    | null lst = []
    | n <= 0 = lst
    | otherwise = [c] ++ (lpad3 c (n-1) lst)

lpad4 :: a -> Int -> [a] -> [a]
lpad4 c n lst
    | null lst = []
    | n <= 0 = lst
    | otherwise = c:(lpad4 c (n-1) lst) 

-- rpad c n lst returns a new list equal to lst but with n copies of c on the right side. 
-- Write the most general type signature for it.
rpad :: a -> Int -> [a] -> [a]
rpad c n lst = lst ++ (replicate n c) 

-- The Composition Operator
f :: Int -> Int
f n = n + 1

g :: Int -> Int
g n = 2*n - 1

fg = f . g  -- fg is the composition of f and g
