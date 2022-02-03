#!/usr/bin/env -S dotnet fsi -O

#load "compress-pk1.fsx"
#load "compress-pk2.fsx"
#load "compress-pk3.fsx"

let candidates = [
    "F#-foldBack",  ``Compress-pk1``.compress
    "F#-recursive", ``Compress-pk2``.compress
    "F#-imperative", ``Compress-pk3``.compress
]

let testText = "AAABBAAC"

let randomString (n:int) =
    let sb = System.Text.StringBuilder(n)
    let letters = [|'A'..'Z'|]
    let rnd = System.Random()
    while sb.Length < n do
        let ch = letters[rnd.Next() % letters.Length]
        let count = min (rnd.Next() % 20) (n - sb.Length)
        for _ in 1..count do sb.Append ch |> ignore
    sb.ToString()

let timeit iterations inputText (fn: string -> string) =
    let startTime = System.DateTime.Now
    for _ in 1..iterations do
        fn inputText |> ignore
    (System.DateTime.Now - startTime).TotalMilliseconds

let benchmark text iterations bestOfTrials =
    for name, fn in candidates do
        let bestTime =
            [ for _ in 1..bestOfTrials -> timeit iterations text fn ]
            |> Seq.min
        printfn $"%14s{name}: best time out of %3d{bestOfTrials} trials with %6d{text.Length} chars x %6d{iterations} compressions was %9.4f{bestTime} ms"

printfn "Benchmarking:"
benchmark testText 100_000 100
benchmark (randomString 100_000) 8 20
