using System.Linq;

static string? Compress(string source)
{
    return !string.IsNullOrEmpty(source) ?
    string.Join("",
        source
        .Aggregate(" ", (x, n) => x + (x.Last() == n ? "" : " ") + n)
        .Trim()
        .Split(" ")
        .Select((s) => $"{s.Length}{s[0]}")
    ) : null;
}

static void Assert(string? expected, string? actual)
{
    if (expected != actual)
    {
        throw new Exception($"Expected: {expected}, but it is {actual}.");
    }
    else
    {
        Console.Write("Ok");
    }
}

Assert("3A2B2A1C", Compress("AAABBAAC"));

