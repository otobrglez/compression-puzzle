import Data.List

main = interact (unlines . map compress . lines)
compress = concatMap rle . group
rle s@(x:_) = shows (length s) [x]
