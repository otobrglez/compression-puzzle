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

(*
    Why is this fast?

    It is practically allocation free, at least inside the loop.

    How?

    1)  StringWriter pre-allocates a buffer ahead of the loop and just appends ouput strings
        to that buffer.
        E.g. when calling sw.Write(15), no strings get allocated: characters 1 and 5 are
        appended directly to output buffer.

    2)  Instead of allocating sub-strings we take a pointer to a slice of the original string (a Span).
        This pointer is stored on stack and gets mutated.
        Instead of s[n..] which would allocate a new string (as seen in recursive solution),
        we use `s <- s.Slice(n)` which mutates the pointer to the underlying string in-place.
*)

assert(compress "AAABBAAC" = "3A2B2A1C")
