using System.Linq;
using System.Text.RegularExpressions;

static string? Compress(string source)
{
  return string.Join("", Regex.Matches(source, "(\\w)\\1*").Select((s) => $"{s.Value.Length}{s.Value[0]}"));

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

