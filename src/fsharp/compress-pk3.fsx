#!/usr/bin/env -S dotnet fsi --define:DEBUG

let compress = function
    | "" -> ""
    | s ->
        use sw = new System.IO.StringWriter()
        sw.GetStringBuilder().Capacity <- s.Length*2
        let mutable lastCh = s[0]
        let mutable reps = 0
        for ch in s do
            if ch = lastCh then
                reps <- reps + 1
            else
                sw.Write(reps)
                sw.Write(lastCh)
                lastCh <- ch
                reps <- 1
        sw.Write(reps)
        sw.Write(lastCh)
        sw.ToString()

assert(compress "AAABBAAC" = "3A2B2A1C")
