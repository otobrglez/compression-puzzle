"""
A very simple algorithm that iterates through the string and counts
how many times a given character is detected.
"""
RESULT = "3A2B2A1C"


def compress_romunov(input_string):
    output_string = []

    current_letter = input_string[0]
    current_counter = 0

    # Go through the string and record number of occurrences
    # per character.
    for el in input_string:
        if el in current_letter:
            current_counter += 1
        else:
            output_string.append(f"{current_counter}{current_letter}")
            current_letter = el
            current_counter = 1

    # Finally, add the last encoded character.
    output_string.append(f"{current_counter}{current_letter}")

    output = "".join(output_string)

    return output


assert compress_romunov(input_string="AAABBAAC") == RESULT
