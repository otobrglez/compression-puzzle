import itertools

def compress(input_str):
  return ''.join(map(lambda i: str(len(list(i[1]))) + i[0], itertools.groupby(input_str)))

assert compress("AAABBAAC") == "3A2B2A1C"
