# Author: @brodul
# Ref: https://replit.com/@brodul/IrritatingSoftWordprocessor#main.py

def rec_group(input_, c, result):
    # conclude recursion
    if len(input_) == 1:
        c += 1
        result.append(str(c) + input_)
        return result
    # get first element, save the rest
    char, rest = input_[0], input_[1:]
    c += 1
    # if the first element is diffrent
    # from the first element of the rest
    if char != rest[0]:
        result.append(str(c) + char)
        # reset counter do the rest
        return rec_group(rest, 0, result)
    return rec_group(rest, c, result)

def compress(input_):
    result = rec_group(input_, 0, [])
    return "".join(result)

assert compress("AAABBAAC") == "3A2B2A1C"
