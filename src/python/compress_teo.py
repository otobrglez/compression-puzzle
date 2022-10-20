def compress_teo(input_string):
    start = 0
    current_letter = input_string[0]
    out = ""

    for i, el in enumerate(input_string):
        if el not in current_letter:
            out += f"{i-start}{current_letter}"
            start = i
            current_letter = el

    out += f"{len(input_string) - start}{current_letter}"
    return out 

assert compress_teo("AAABBAAC") == "3A2B2A1C"
