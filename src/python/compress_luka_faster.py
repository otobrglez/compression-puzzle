import itertools


def compress(input_str):
  return "".join(
    [f"{len(list(seq))}{key}" for key, seq in itertools.groupby(input_str)]
  )


assert compress("AAABBAAC") == "3A2B2A1C"
