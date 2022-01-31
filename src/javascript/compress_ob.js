const assert = require('assert');

const sequence = (string) => 
  string.split(/(?<=(.))(?!\1|$)/g)
    .filter((_, i) => !(i % 2))
    .map((c) => [c.length, c[0]])
    .flatMap((c) => c)
    .join('')

assert.equal(
  sequence("AAABBAAC"),
  "3A2B2A1C"
)
