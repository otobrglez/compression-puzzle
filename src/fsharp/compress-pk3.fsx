#!/usr/bin/env -S dotnet fsi --define:DEBUG

open System

let compress (s:string) =
    use sw = new IO.StringWriter()
    sw.GetStringBuilder().Capacity <- s.Length*2
    let mutable s = s.AsSpan()
    while not s.IsEmpty do
        let mutable n = 1
        while n<s.Length && s[n]=s[0] do n <- n+1
        sw.Write(n)
        sw.Write(s[0])
        s <- s.Slice(n)
    sw.ToString()

assert(compress "AAABBAAC" = "3A2B2A1C")
