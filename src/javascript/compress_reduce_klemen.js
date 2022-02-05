const assert = require('assert')

const compress = (string) =>
  [...`${string} `].reduce(
    ([out = "", count, char], input) =>
      input === char
        ? [out, count + 1, char]
        : count > 0
        ? [`${out}${count}${char}`, 1, input]
        : [out, 1, input],
    []
  )[0];

assert.equal(
    compress("AAABBAAC"),
    "3A2B2A1C"
)
