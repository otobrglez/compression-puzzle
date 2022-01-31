import re

compress = lambda input: "".join(sum([[str(len(v)), v[0]] for i, v in enumerate(re.split(r'(?<=(.))(?!\1|$)', input)) if i % 2 == 0], []))

assert compress("AAABBAAC") == "3A2B2A1C"
