const compress = (s) => s.match(/(.)\1*/g).map(x => `${x.length}${x[0]}`).join('');

const decompress = (s) => s.match(/(\d+)(.)/g).map(x => x[1].repeat(x[0])).join('');

require("assert").equal(compress("AAABBAAC"), "3A2B2A1C");
require("assert").equal(decompress("3A2B2A1C"), "AAABBAAC");
