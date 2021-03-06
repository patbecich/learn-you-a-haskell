import           Data.Char
import qualified Data.Map  as Map


testFunction :: [a] -> [a]
testFunction []     = []
testFunction (x:xs) = x: testFunction xs

head' :: [a] -> a
head' []    = error "Can't call and empty list"
head' (x:_) = x

data Point = Point Float Float deriving (Show)

data Shape = Circle Point Float | Rectangle Point Point deriving (Show)


surface :: Shape -> Float
surface (Circle _ r)          = pi * r ^ 2
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)

nudge :: Shape -> Float -> Float -> Shape
nudge (Circle (Point x y) r) a b = Circle (Point (x+a) (y+b)) r
nudge (Rectangle (Point x1 y1) (Point x2 y2)) a b = Rectangle (Point (x1+a) (y1+b)) (Point (x2+a) (y2+b))

baseCircle :: Float -> Shape
baseCircle r = Circle (Point 0 0 ) r

baseRect :: Float -> Float -> Shape
baseRect width height = Rectangle (Point 0 0) (Point width height)

data Person = Person String String Int Float String String deriving (Show)

getName :: Person2 -> String
getName (Person2 firstName _ _ _ _ _) = firstName

data Person2 = Person2 { firstName :: String
                     , lastName    :: String
                     , age         :: Int
                     , height      :: Float
                     , phoneNumber :: String
                     , flavor      :: String
                     } deriving (Show)

--data Maybe a = Nothing | Justa a
-- surface (Circle (Point 0 0) 24)
-- 1809.5574
--  :t Circle
-- Circle :: Point -> Float -> Shape
--  :t Circle (Point 0 0)
-- Circle (Point 0 0) :: Float -> Shape
--  surface $ Circle (Point 0 0) 24
-- 1809.5574
-- 

onlyPositive :: Int -> Maybe Int
onlyPositive x
  | x < 0 = Nothing
  | otherwise = Just $ 10 * x

onlyPositive' :: Maybe Int -> Maybe Int
onlyPositive' Nothing = Nothing
onlyPositive' (Just x)
  | x < 0 = Nothing
  | otherwise = Just (10 * x)


onlyPositive'' :: Maybe Int -> Maybe Int
onlyPositive'' mx = fmap (\x -> (10 * x)) mx

data Car = Car { company :: String
               , model   :: String
               , year    :: Int
               } deriving (Show)

tellCar :: Car -> String
tellCar (Car {company = c, model = m, year = y}) = "This " ++ c ++ " " ++ m ++ " was made in " ++ show y

data Vector a = Vector a a a deriving (Show)

vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)

vectMult :: (Num t) => Vector t -> t -> Vector t
(Vector i j k) `vectMult` m = Vector (i*m) (j*m) (k*m)

scalarMult :: (Num t) => Vector t -> Vector t -> t
(Vector i j k) `scalarMult` (Vector l m n) = i*j + j*m + k*n

data Person3 = Person3 {firstName' :: String
                      ,lastName'   :: String
                      ,age'        :: Int
                      } deriving (Eq, Show, Read)

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
  deriving (Eq, Ord, Show, Read, Bounded, Enum)

phoneBook :: [(String,String)]
phoneBook =
  [("betty", "555-2938")
  ,("bonnie", "452-2928")
  ]

--type PhoneBook = [(String,String)]
type PhoneNumber = String
type Name = String
type PhoneBook = [(Name, PhoneNumber)]

phoneBook' :: PhoneBook
phoneBook' =
  [("betty", "555-2938")
  ,("bonnie", "452-2928")
  ]

inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
inPhoneBook name pnumber pbook = (name,pnumber) `elem` pbook

-- aka "inPhoneBook :: String -> String -> [(String,String)] -> Bool

type AssocList k v = [(k,v)]

--data Either a b = Leftt a | Rightt b deriving (Eq, Ord, Read, Show)


data LockerState = Taken | Free deriving (Show, Eq)

type Code = String

type LockerMap = Map.Map Int (LockerState, Code)

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map =
  case Map.lookup lockerNumber map of
    Nothing -> Left $ "Locker number " ++ show lockerNumber ++ "doesn't exist!"
    Just (state, code) -> if state /= Taken
      then Right code
      else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"

lockers :: LockerMap
lockers = Map.fromList
  [(100,(Taken,"ZD39I"))
  ,(101,(Free,"JAH3I"))
  ,(103,(Free,"IQSA9"))
  ,(105,(Free,"QOTSA"))
  ,(109,(Taken,"893JJ"))
  ,(110,(Taken,"99292"))
  ]

-- Recursive Data Structures

--data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord)

infixr 5 :-:
data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)

infixr 5 .++
(.++) :: List a -> List a -> List a
Empty .++ ys = ys
(x :-: xs) .++ ys = x :-: (xs .++ ys)

-- Binary search trees

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
  | x == a = Node x left right
  | x < a = Node a (treeInsert x left) right
  | x > a = Node a left (treeInsert x right)

treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
  | x == a = True
  | x < a = treeElem x left
  | x > a = treeElem x right

-- Typeclasses 102

data TrafficLight = Red | Yellow | Green

data TestType = A | B | C

testTypeNumber :: TestType -> Int
testTypeNumber A = 1
testTypeNumber B = 2
testTypeNumber C = 3


instance Eq TrafficLight where
  Red == Red = True
  Green == Green = True
  Yellow == Yellow = True
  _ == _ = False

instance Show TrafficLight where
  show Red    = "Red light"
  show Yellow = "Yellow light"
  show Green  = "Green light"

-- instance (Eq m) => Eq (Maybe m) where
--   Just x == Just y = x == y
--   Nothing == Nothing = True
--   _ == _ = False

-- A yes-no typeclass

class YesNo a where
  yesno :: a -> Bool

instance YesNo Int where
  yesno 0 = False
  yesno _ = True

instance YesNo [a] where
  yesno [] = False
  yesno _  = True

instance YesNo Bool where
  yesno = id

-- id is a standard library function that takes a parameter and returns the same thing

instance YesNo (Maybe a) where
  yesno (Just _) = True
  yesno Nothing  = False

instance YesNo (Tree a) where
  yesno EmptyTree = False
  yesno _         = True

instance YesNo TrafficLight where
  yesno Red = False
  yesno _   = True

yesnoIf :: (YesNo y) => y -> a -> a -> a
yesnoIf yesnoVal yesResult noResult = if yesno yesnoVal then yesResult else noResult

-- the Functor typeclass

-- class Functor f where
  -- fmap :: (a -> b) -> f a -> f b

-- instance Functor [] where
  -- fmap = map

-- instance Functor Maybe where
--   fmap f (Just x) = Just (f x)
--   fmap f Nothing  = Nothing

instance Functor Tree where
  fmap f EmptyTree = EmptyTree
  fmap f (Node x leftsub rightsub) = Node (f x) (fmap f leftsub) (fmap f rightsub)

-- instance Functor (Either a) where
  -- fmap f (Right x) = Right (f x)
  -- fmap f (Left x) = Left x

asciiCodes = [1..90]
asciiLetters = fmap chr asciiCodes

capitalA :: Maybe Char
capitalA = fmap chr (Just 65)

noCapitalA :: Maybe Char
noCapitalA = fmap chr Nothing

toCharacter :: Maybe Int -> Maybe Char
toCharacter my = fmap chr my

toCharacter' :: Maybe Int -> Maybe Char
toCharacter' (Just i) = Just (chr i)
toCharacter' Nothing  = Nothing

toB :: (Int -> b) -> Maybe Int -> Maybe b
toB f (Just i) = Just (f i)
toB f Nothing  = Nothing

aToB :: (a -> b) -> Maybe a -> Maybe b
aToB f (Just i) = Just (f i)
aToB f Nothing  = Nothing

data Maybe' a = Just' a | Nothing' deriving (Show)

maybeFoo :: Maybe' Int
maybeFoo = Just' 65


aToB' :: (a -> b) -> Maybe' a -> Maybe' b
aToB' f (Just' i) = Just' (f i)
aToB' f Nothing'  = Nothing'

instance Functor Maybe' where
  fmap f fa = aToB' f fa
