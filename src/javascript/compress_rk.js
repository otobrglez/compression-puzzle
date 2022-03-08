const assert = require('assert')

const compress = (input) =>
	[...input].reduce((acc, el) => {
  	return el !== acc.slice(-1) ?
    			`${acc}1${el}` :
    			`${acc.slice(0,-2)}${parseInt(acc.substr(-2,1))+1}${el}`;
  }, '');

assert.equal(
  compress("AAABBAAC"),
  "3A2B2A1C"
);
