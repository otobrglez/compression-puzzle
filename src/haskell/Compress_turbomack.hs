import Data.Char (chr)
import System.IO (getLine)

count :: String -> [(Int, Char)]
count str = foldr insertChar [] str
  where
    insertChar c [] = [(1, c)]
    insertChar c ((count, char) : tail) =
        if c == char
            then (count + 1, char) : tail
            else (1, c) : (count, char) : tail

compress :: String -> String
compress orig =
    (\(c, v) -> [chr (c + 48), v]) =<< count orig

main :: IO ()
main = getLine >>= (print . compress)
