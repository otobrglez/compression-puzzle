def compress_tailrec(input_str, key=None, count=0, result=""):
  """
  Tail-recursive version.
  """
  if key is None and not input_str:
    return ""
  elif not input_str:
    return f"{result}{count}{key}"
  head, tail = input_str[0], input_str[1:]
  if head == key:
      return compress_tailrec(tail, key, count + 1, result)
  elif key is not None:
    return compress_tailrec(tail, head, 1, f"{result}{count}{key}")
  else:
    return compress_tailrec(tail, head, 1)


assert compress_tailrec("AAABBAAC") == "3A2B2A1C"
