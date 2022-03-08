

static string? Compress(string source)
{
  int i = 0;
  char prev = source[0];
  string? result = null;
  source += " "; // apend 1 char, to be sure the last group of letters will also be used (count + char)
  for(int j=0;j<source.Length;j++)
  {
    if(source[j] == prev)
    {
      i++;
    }
    else
    {
      result += $"{i}{prev}";
      i = 1;
    }
    prev = source[j];
  }
  return result;
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
