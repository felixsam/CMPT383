-- Felix Sam

-- replicate n x is a list of length n with x the value of every element. 
-- It is an instance of the more general Data.List.genericReplicate, in which n may be of any integral type.
myreplicate :: Int -> a -> [a]
myreplicate n x = 
    if n <= 0
        then []
    else 
        x : (myreplicate (n-1) x)

myreplicate2 :: Int -> a -> [a]
myreplicate2 n x
    | n <= 0 = []
    | otherwise = x : (myreplicate (n-1) x)


-- creates a list, the first argument determines, 
-- how many items should be taken from the list passed as the second argument
mytake :: Int -> [a] -> [a]
mytake n lst
    | n <= 0 = []
mytake _ [] = []
mytake n (x:xs) = x : (mytake (n-1) xs) 

-- it creates an infinite list where all items are the first argument
myrepeat :: a -> [a]
myrepeat n = n:myrepeat n


-- makes a list of tuples, each tuple conteining elements of both lists occuring at the same position
myzip :: [a] -> [b] -> [(a,b)]
myzip _ [] = []
myzip [] _ = []
myzip (x:xs) (y:ys) = (x,y): (myzip xs ys)

--reverse zip
myunzip :: [(a,b)] -> ([a],[b])
myunzip [] = ([],[])

--subtracts the first argument from the second one
mysubtract :: Num a => a -> a -> a
mysubtract x y = x - y

-- returns te number of items in a list
mylength :: [a] -> Int
mylength [] = 0
mylength (x:xs) = 1 + mylength (xs)

mylength2 :: [a] -> Int
mylength2 [] = 0
mylength2 (_:xs) = 1 + mylength (xs)

-- returns the last item of a list
mylast :: [a] -> a
mylast [] = error "Empty List!"
mylast lst
    | length(lst) == 1 = (head lst)
    | otherwise = mylast (tail lst)

-- returns the list (0 1 2 ... n-1)
myrange :: Int -> [Int]
myrange n = [n | n <- [0..n-1]]

-- it accepts a list and returns the list without its first item
mytail :: [a] -> [a]
mytail [] = error "Empty List"
mytail (x:xs) = (xs)


-- it accepts a list and returns the list without its first item
myhead :: [a] -> a
myhead [] = error "Empty List"
myhead (x:xs) = x

-- returns True if all items in the list fulfill the condition
myall :: (a -> Bool) -> [a] -> Bool
myall f [] = True
myall f (x:xs) =
    if f x
        then myall f xs
    else False


-- mydropfunction 
-- Input: drop 5 [1,2,3,4,5,6,7,8,9,10]
-- Output: [6,7,8,9,10]
mydrop :: Int -> [a] -> [a]
mydrop 0 lst = lst
mydrop _ [] = []
mydrop n (x:xs) = mydrop (n-1) xs

-- it accepts a list and returns the list without its last item
myinit :: [a] -> [a]
myinit [] = error "Empty List!"
myinit lst
    |length lst == 1 = []
    |otherwise = reverse(tail (reverse lst))


-- it evaluates the function flipping the order of arguments
mymap :: (a -> b) -> [a] -> [b]
mymap f lst = [f n | n <- lst]

mymap2 :: (a -> b) -> [a] -> [b]
mymap2 _ [] = []
mymap2 f (x:xs) = f x : (mymap2 f xs)

-- returns True if at least one item in the list fulfills the condition
myany :: (a -> Bool) -> [a] -> Bool
myany _ [] = False
myany f (x:xs) = 
    if f x
        then True
    else myany f xs

-- returns the minimum value from the list
mymin :: Ord a => [a] -> a
mymin [] = error "Empty List"
mymin [x] = x
mymin (x:xs) = 
    if x < last xs
        then mymin (init (x:xs))
    else mymin xs

myfilter :: (a -> Bool) -> [a] -> [a]
myfilter _ [] = []
myfilter f (x:xs) =
    if f x
        then x:(myfilter f xs)
    else myfilter f xs


myfilter2 :: (a -> Bool) -> [a] -> [a]
myfilter2 f lst = [n | n <- lst, f n == True]


myproduct :: Num a => [a] -> a
myproduct [] = 1
myproduct (x:xs) = x * (myproduct xs)

mysum :: Num a => [a] -> a
mysum [] = 0
mysum (x:xs) = x + (mysum xs)

mynegate :: Num a => a -> a
mynegate n = (-1)*n

mycycle :: [a] -> [a]
mycycle lst = lst ++ (mycycle lst)

myid :: a -> a
myid x = x

mytakewhile :: (a -> Bool) -> [a] -> [a]
mytakewhile _ [] = []
mytakewhile f (x:xs) 
    | f x == True = x:mytakewhile f xs
    | otherwise = []

mysum3 :: (Num a) => [a] -> a
mysum3 xs = foldl (\acc x -> acc + x) 0 xs 

mysum4 :: (Num a) => [a] -> a
mysum4 xs = foldr (\acc x -> acc + x) 0 xs 

mylen2 :: [a] -> Int
mylen2 xs = foldr (\x y -> 1 + y) 0 xs