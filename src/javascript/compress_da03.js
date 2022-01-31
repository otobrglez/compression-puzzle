const assert = require('assert');

const compress = (input) => {
  let store = ''
  let count = 1
  
  array.forEach((letter, i) => {
    if (letter === array[i+1] ) {
      count++
    } else {
      store += count+letter
      count = 1
    }
  })
  return store
}

assert.equal(
  compress("AAABBAAC"),
  "3A2B2A1C"
)
