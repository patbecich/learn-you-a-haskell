-- main = do
--     line <- getLine
--     if null line
--         then return ()
--         else do
--             putStrLn $ reverseWords line
--             main

-- reverseWords :: String -> String
-- reverseWords = unwords . map reverse . words

-- main = do
--   print True
--   print 2
--   print "haha"
--   print 3.2
--   print [3,4,2]

main = do
   a <- getLine
   b <- getLine
   c <- getLine
   print [a,b,c]

-- This is equivalent to:

-- main = do
--   rs <- sequence [getLine, getLine, getLine]
--   print rs
