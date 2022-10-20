'''
this impleentation uses the functional programming technique of continuations
'''

def format_count(character, count):
    return "" if count == 0 else f'{count}{character}'


def compress_continue(s, f):
    if s == "":
        return f("", prev_char=None, count=0)

    def g(acc, prev_char, count):
        if s[0] == prev_char:
            return f(acc, prev_char, count + 1)
        return f(format_count(prev_char, count) + acc, s[0], 1)
        
    return compress_continue(s[1:], g)

def compress(s):
    return compress_continue(s, collect)


def collect(acc, prev_char, count):
    return format_count(prev_char, count) + acc


if __name__ == '__main__':
    compressed = compress('AAABBAAC')
    assert compressed == '3A2B2A1C'

