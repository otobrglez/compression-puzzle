const assert = require('assert');

const compress = (input) => {
  let r = '';
	let c = 1;

  input.split('').forEach((l, i, a) => {
    if (l === a[i+1] ) {
      c++;
		} else {
      r += `${c}${l}`;
      c = 1;
		}
  });
  return r;
};

assert.equal(
  compress("AAABBAAC"),
  "3A2B2A1C"
)
