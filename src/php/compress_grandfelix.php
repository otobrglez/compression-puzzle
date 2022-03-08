<?php

function compress(string $str): string
{
    if (empty($str)) {
        return "";
    }

    $count = 0;
    $previous = $str[0];
    $result = "";
    $strLen = strlen($str);
    for ($i = 0; $i < $strLen; $i++) {
        if ($previous != $str[$i]) {
            $result .= $count . $previous;
            $count = 0;
            $previous = $str[$i];
        }

        $count++;
    }

    return $result . $count . $str[$strLen - 1];
}

assert(compress('AAABBAAC') == '3A2B2A1C');
assert(compress('AAABBAAAACCC') == '3A2B4A3C');