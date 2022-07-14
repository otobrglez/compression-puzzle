from functools import reduce

compress=lambda s:reduce(lambda a,b:([a[0]+str(a[1])+b[0],1],[a[0],a[1]+1])[b[0]==b[1]],zip(s,s[1:]+'0'),['',1])[0]

assert compress("AAABBAAC") == "3A2B2A1C"
