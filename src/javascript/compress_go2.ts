const assert = require('assert');

const groupByChar = (chars: string[], prev: string | null = null, acc: string[][] = []): string[][] => {
    if (chars.length === 0) {
      throw new Error(`You silly person, don't compress empty strings :D`);
    }
  
    const [ch1, ...chRest] = chars;
    
    if (acc.length === 0 && chRest.length === 0) {
      return [[ch1]];
    }
  
    if (acc.length === 0) {
      return groupByChar(chRest, ch1, [[ch1]]);
    }
  
    const newAcc = ch1 === prev ? [...acc.slice(0, -1), [...acc.slice(-1)[0], ch1]]: [...acc, [ch1]]
  
    return chRest.length === 0 ? newAcc : groupByChar(chRest, ch1, newAcc); 
  }
  
const compress = (input: string) =>  groupByChar([...input]).map((v) => `${v.length}${v[0]}`).join('')

assert.equal(
compress("AAABBAAC"),
"3A2B2A1C"
);
  