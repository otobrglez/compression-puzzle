const assert = require('assert');

const compress = (x) =>
    x.split('').reduce((acc, curr, index, initial) => {
        if (index !== 0) {
            if (curr === initial[index-1]) {
                acc[acc.length-1].push(curr);
            } else {
                acc.push([curr]);
            }
        } else {
            acc.push([curr])
        }

        return acc;
    }, [])
    .map((v) => v.length+v[0])
    .join('');

assert.equal(
  compress("AAABBAAC"),
  "3A2B2A1C"
);
