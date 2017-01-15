

--Files and Streams

-- import           Control.Monad
--import           Data.Char
import           Data.List
import           System.Directory
import           System.Environment
import           System.IO


-- main = forever $ do
--   putStr "Give me some input: "
--   l <- getLine
--   putStrLn $ map toUpper l

-- main = do
--   contents <- getContents
--   putStr (map toUpper contents)

-- main = do
--   contents <- getContents
--   putStr (shortLinesOnly contents)

-- shortLinesOnly :: String -> String
-- shortLinesOnly input =
--     let allLines = lines input
--         shortLines = filter (\line -> length line < 10) allLines
--         result = unlines shortLines
--     in result

--"interact function"

--main = interact shortLinesOnly

-- main = interact $ unlines . filter ((<10) . length) . lines

-- respondPalindromes = unlines . map (\xs -> if isPalindrome xs then "palindrome" else "not a palindrome") . lines
--     where   isPalindrome xs = xs == reverse xs

-- main = interact respondPalindromes


-- main = do
--   handle <- openFile "lyrics.txt" ReadMode
--   contents <- hGetContents handle
--   putStr contents
--   hClose handle

-- Or "withFile" implementation

-- main = do
--   withFile "lyrics.txt" ReadMode (\handle -> do
--       contents <- hGetContents handle
--       putStr contents)

-- withFile' :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
-- withFile' path mode f = do
--     handle <- openFile path mode
--     result <- f handle
--     hClose handle
--     return result

-- readFile

-- main = do
--     contents <- readFile "lyrics.txt"
--     putStr contents

-- writeFile

-- main = do
--     contents <- readFile "lyrics.txt"
--     writeFile "lyricsCaps.txt" (map toUpper contents)

-- appendFile

-- main = do
--     todoItem <- getLine
--     appendFile "lyrics.txt" (todoItem ++ "\n")

-- removing an item from txt filepath

-- main = do
--   handle <- openFile "lyrics.txt" ReadMode
--   (tempName, tempHandle) <- openTempFile "." "temp"
--   contents <- hGetContents handle
--   let todoTasks = lines contents
--       numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
--   putStrLn "These are your TO-DO items:"
--   putStr $ unlines numberedTasks
--   putStrLn "Which one do you want to delete?"
--   numberString <- getLine
--   let number = read numberString
--       newTodoItems = delete (todoTasks !! number) todoTasks
--   hPutStr tempHandle $ unlines newTodoItems
--   hClose handle
--   hClose tempHandle
--   removeFile "lyrics.txt"
--   renameFile tempName "lyrics.txt"

-- command line arguments

-- main = do
--     args <- getArgs
--     progName <- getProgName
--     putStrLn "The arguments are:"
--     mapM putStrLn args
--     putStrLn "The program name is:"
--     putStrLn progName

-- view/add/delete function

dispatch :: [(String, [String] -> IO ())]
dispatch =  [ ("add", add)
            , ("view", view)
            , ("remove", remove)
            ]

dispatch' :: String -> ( [String] -> IO ())
dispatch' "add"    = add
dispatch' "view"   = view
dispatch' "remove" = remove

main = do
    (command:args) <- getArgs
    let (Just action) = lookup command dispatch
    action args

add :: [String] -> IO ()
add [fileName]           = putStrLn "Include new line"
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

view :: [String] -> IO ()
view [fileName] = do
    contents <- readFile fileName
    let todoTasks = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
    putStr $ unlines numberedTasks

remove :: [String] -> IO ()
remove [fileName, numberString] = do
    handle <- openFile fileName ReadMode
    (tempName, tempHandle) <-openTempFile "." "temp"
    contents <- hGetContents handle
    let number = read numberString
        todoTasks = lines contents
        newTodoItems = delete (todoTasks !! number) todoTasks
    hPutStr tempHandle $ unlines newTodoItems
    hClose handle
    hClose tempHandle
    removeFile fileName
    renameFile tempName fileName

--zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
--zipWith' f
