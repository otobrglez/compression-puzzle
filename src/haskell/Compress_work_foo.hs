import Data.List

main = interact (unlines . map compress . lines) -- loop on the lines not the whole input
compress = concatMap rle . group                 -- group splits by =, then encode the unit and concat
rle s@(x:_) = shows (length s) [x]               -- the worker computes the length and returns the unit
