const assert = require('assert');

const compress = input => Array.from(input.matchAll(new RegExp(/(.)\1{0,}/, 'g'))).map(x => `${x[0].length}${x[0][0]}`).join('');

assert.equal(
  compress("AAABBAAC"),
  "3A2B2A1C"
);
