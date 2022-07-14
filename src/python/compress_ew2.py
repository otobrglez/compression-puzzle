def compress(s='', r='', c=1):
    for p, v in zip(s, s[1:] + '0'):
        [r,c]=([r+str(c)+p,1],[r,c+1])[p==v]
    return r


assert compress("AAABBAAC") == "3A2B2A1C"
