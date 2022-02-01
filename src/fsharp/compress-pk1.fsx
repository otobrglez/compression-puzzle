#!/usr/bin/env -S dotnet fsi --define:DEBUG

let compress s =
    (s, [])
    ||> Seq.foldBack (fun ch lst ->
        match ch, lst with
        | ch, (c,n)::tail when c=ch -> (c,n+1)::tail
        | ch, lst -> (ch,1)::lst
    )
    |> Seq.map (fun (c,n) -> $"{n}{c}")
    |> String.concat ""

assert(compress "AAABBAAC" = "3A2B2A1C")
