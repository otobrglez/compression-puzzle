#!/usr/bin/env -S dotnet fsi --define:DEBUG

let rec compress = function
    | "" -> ""
    | s ->
        let n = s |> Seq.takeWhile ((=) s[0]) |> Seq.length
        $"{n}{s[0]}{compress s[n..]}"

assert(compress "AAABBAAC" = "3A2B2A1C")
