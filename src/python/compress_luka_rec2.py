def compress_rec2(input_str, key=None, count=0):
  """
  Make counter tail-recursive, while still concatenating recursive return values.
  """
  if key is None and not input_str:
    return ""
  elif not input_str and key is not None:
    return f"{count}{key}"
  head, tail = input_str[0], input_str[1:]
  if head == key:
      return compress_rec2(tail, key, count + 1)
  elif key is not None:
    return f"{count}{key}" + compress_rec2(tail, head, 1)
  else:
    return compress_rec2(tail, head, 1)


assert compress_rec2("AAABBAAC") == "3A2B2A1C"
