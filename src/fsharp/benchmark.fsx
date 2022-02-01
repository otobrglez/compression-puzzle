#!/usr/bin/env -S dotnet fsi -O

#load "compress-pk1.fsx"
#load "compress-pk2.fsx"
#load "compress-pk3.fsx"

let text = "AAABBAAC"
let iterations = 100000
let bestOfTrials = 100 // give it a few trials for JIT to kick in
let candidates = [
    "F#-foldBack",  ``Compress-pk1``.compress
    "F#-recursive", ``Compress-pk2``.compress
    "F#-imperative", ``Compress-pk3``.compress
]

let timeit iterations inputText (fn: string -> string) =
    let startTime = System.DateTime.Now
    for _ in 1..iterations do
        fn inputText |> ignore
    (System.DateTime.Now - startTime).TotalMilliseconds

for name, fn in candidates do
    let bestTime =
        [ for _ in 1..bestOfTrials -> timeit iterations text fn ]
        |> Seq.min
    printfn $"Solution %14s{name}: best time out of {bestOfTrials} trials with {iterations} conversions was %8.4f{bestTime} ms"
