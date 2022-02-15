using System;

static string Compress(string sourceSequence)
{
    if (string.IsNullOrEmpty(sourceSequence))
    {
        throw new ArgumentException($"'{nameof(sourceSequence)}' cannot be null or empty.", nameof(sourceSequence));
    }

    var currentPosition = 1;
    var currentCharacter = sourceSequence.Substring(0, 1);
    var numberOfRepetitions = 1;
    var compressed = String.Empty;

    while (currentPosition < sourceSequence.Length)
    {
        if (sourceSequence.Substring(currentPosition, 1) == currentCharacter)
        {
            numberOfRepetitions++;
        }
        else
        {
            compressed += $"{numberOfRepetitions}{currentCharacter}";
            numberOfRepetitions = 1;
            currentCharacter = sourceSequence.Substring(currentPosition, 1);
        }
        currentPosition++;
    }

    compressed += $"{numberOfRepetitions}{currentCharacter}";

    return compressed;
}

static void Assert(string expected, string actual)
{
    if (expected != actual)
    {
        throw new Exception($"Excpected: {expected}, but it is {actual}.");
    }
}

Assert("3A2B2A1C", Compress("AAABBAAC"));
