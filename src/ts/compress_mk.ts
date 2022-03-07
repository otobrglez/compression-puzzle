import assert from 'assert';

function compress(input: string): string {
    if (input.length === 0) {
        throw new Error('Heiii, can not compress empty string');
    }

    let compressedInput = '';
    const splittedInput = input.split('');
    let currentCount = 0;
    let prevChar = splittedInput[0];
    for (const currentChar of splittedInput) {
        if (currentChar === prevChar) {
            currentCount++;
            continue;
        }
        compressedInput += `${currentCount}${prevChar}`;
        currentCount = 1;
        prevChar = currentChar;
    }

    compressedInput += `${currentCount}${prevChar}`;   
    return compressedInput;
}

assert.equal(
    compress("AAABBAAC"),
    "3A2B2A1C"
);