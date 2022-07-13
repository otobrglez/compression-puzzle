def compress(s='', r="", c=1):
    for p, v in zip(s, s[1:] + '0'):
        # print(c, p, v, r)
        if p == v:
            c += 1
        else:
            r += str(c) + p
            c = 1

    return r


assert compress("AAABBAAC") == "3A2B2A1C"
