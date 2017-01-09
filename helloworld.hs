--main = putStrLn "hello, world"

-- main = do
--   putStrLn "Hello, what's your name?"
--   name <- getLine
--   putStrLn ("Hey " ++ name ++ ", you rock!")

-- main = do
--   putStrln "Hello, what's your name?"
--   name <- getLine
--   putStrLn $ "Zis is your future: " ++ tellFortune name
  
import Data.Char

main = do
  putStrLn "What's your first name?"
  firstName <- getLine
  putStrLn "What's your last name?"
  lastName <- getLine
  let bigFirstName = map toUpper firstName
      bigLastName = map toUpper lastName
  putStrLn $ "hey " ++ bigFirstName ++ " "
                    ++ bigLastName++ " "
                    ++ ", how are you?"
