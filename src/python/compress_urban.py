import itertools


def compress_iterative(in_):
    acc = ""
    while in_:
        head_char = in_[0]
        group = itertools.takewhile(lambda x: x == head_char, in_)
        group_count = sum(1 for _ in group)
        acc += f"{group_count}{head_char}"
        in_ = in_[group_count:]
    return acc


def compress_recursive(in_: str, acc: str = None):
    if not in_:
        return acc

    if acc is None:
        acc = ""

    head_char = in_[0]
    group = itertools.takewhile(lambda x: x == head_char, in_)
    group_count = sum(1 for _ in group)
    acc += f"{group_count}{head_char}"
    return compress_recursive(in_[group_count:], acc)


assert compress_iterative("AAABBAAC") == "3A2B2A1C"
assert compress_recursive("AAABBAAC") == "3A2B2A1C"
