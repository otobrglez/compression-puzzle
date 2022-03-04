using System;
using System.Linq;

class Program
{
    static void Main(string[] args)
    {
        Assert("3A2B2A1C", Compress("AAABBAAC"));
    }

    public static string Compress(string input)
    {
        if (string.IsNullOrEmpty(input))
            return "";

        return input
            .Skip(1)    //We will use 1st character as a seed, so skip it
            .Aggregate(
                (repetitions: 1, prevChar: input[0], compressed: ""), //Seed
                (accu, currentChar) => accu.prevChar == currentChar ? (accu.repetitions + 1, accu.prevChar, accu.compressed) : (1, currentChar, $"{accu.compressed}{accu.repetitions}{accu.prevChar}"), //Func
                accu => $"{accu.compressed}{accu.repetitions}{accu.prevChar}") //Finish it
            .ToString();
    }

    public static void Assert(string expected, string actual)
    {
        if (expected != actual)
        {
            throw new Exception($"Excpected: {expected}, but it is {actual}.");
        }
    }

}

