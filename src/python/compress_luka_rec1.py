def compress_rec1(input_str):
  """
  Build the result from recursive return values.
  """
  def _compress_rec(_input_str, key=None):
    if not _input_str:
      return "", 0
    head, tail = _input_str[0], _input_str[1:]
    if head == key:
      result, key_count = _compress_rec(tail, key)
      return result, key_count + 1
    else:
      result, key_count = _compress_rec(tail, head)
      return f"{key_count + 1}{head}" + result, 0

  return "".join(_compress_rec(input_str)[0])


assert compress_rec1("AAABBAAC") == "3A2B2A1C"
