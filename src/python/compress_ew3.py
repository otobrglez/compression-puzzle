from functools import reduce

compress=lambda s:reduce(lambda a,b:([a[0]+str(a[1])+b,1,a[2]+1],[a[0],a[1]+1,a[2]+1])[a[2]+1<len(s)and b==s[a[2]+1]],s,['',1,0])[0]

assert compress("AAABBAAC") == "3A2B2A1C"
