const assert = require('assert');

const compress = (input) => {
  let store = ''
  let count = 1
  let first = ''
  input.split('').reduce((prev, cur) => {
    if (cur === prev  ) {
      count++
    } else {
      store += count+cur
      count = 1
    }
    return cur
  }, '')
  return store
}

assert.equal(
  compress("AAABBAAC"),
  "3A2B2A1C"
)
