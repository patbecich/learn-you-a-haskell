
doubleMe x = x + x

doubleUs x y = x * 2 + y * 2

doubleSmallNumber x = (if x > 100 then x else x*2) + 6

-- let x = [1,2,3,4] ++ [6,7,8,9]

-- let triples = [ (a,b,c) | c <- [1..10], a <- [1..10], b <- [1..10]]

rightTriangles = [ (a,b,c) | c <- [1..10], a <- [1..c], b <- [1..a], a^2 + b^2 == c^2, a+b+c == 24 ]


--factorial :: Integer -> Integer
--factorial n = product [1..n]

foo :: Integer
foo = 4

boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

boomBangs' xs = [ if xs < 10 then "BOOM!" else "BANG!" | odd xs]

removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]
                        

add :: Num a => a -> a -> a
add x y = x + y

-- how is this different from the pattern recognition strategy seen in factorial/lucky? Why does function stop as soon as a condition is met. i.e. lucky = 7

bmiTell :: Double -> String
bmiTell bmi
        | bmi <= 18.5 = "You're underweight!"
        | bmi <= 25.0 = "You're normal!"
        | bmi <= 30.0 = "You're fat!"
        | otherwise = "You're off the charts"

bar :: Integer -> Integer
bar 3 = 3
bar x = x + 1
                      
--factorial' :: Integer -> Integer
--factorial' n = n * factorial' (n-1)
--factorial' 1 = 1

factorial :: Integer -> Integer
factorial 1 = 1
factorial n = n * factorial (n-1)

-- Illustrates same example discussing on factorial example ( specific cases)
-- x does not appear to be catchall like book states
lucky :: Int -> String
lucky 7 = "Lucky!"
lucky x = "You're WRONG!"

sayMe :: Int -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe x = "Something Else!"

addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors a b = (fst a + fst b, snd a + snd b)

addVectors' :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors' (x1, y1)(x2, y2) = (x1 + x2, y1 + y2)
                               
-- Chapter 4 "Hello Recursion"

maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list!"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

replicate' :: Int -> a -> [a]
replicate' n x
           | n <= 0 = []
           | otherwise = x : replicate' (n-1) x

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
      | n <= 0  = []
take' _[]       = []
take' n (x:xs)  = x : take' (n-1) xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
      | a == x     = True
      | otherwise = a `elem'` xs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerOrEqual = [a | a <- xs, a <= x]
        larger = [a | a <- xs, a > x]
    in quicksort smallerOrEqual ++ [x] ++ quicksort larger
