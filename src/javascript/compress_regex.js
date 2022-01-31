const assert = require('assert');

const compress = (input) => {
  return input.replace(/([^])\1*/g, (match, p) => match.length + p)
}

assert.equal(
  compress("AAABBAAC"),
  "3A2B2A1C"
)
