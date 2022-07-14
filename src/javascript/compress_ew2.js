const assert = require("assert");

//     v 70 chars, no regex /\/\/\:
compress=(s,r="",c=1)=>[...s].map((v,i)=>v==s[i+1]?c++:[r+=c+v,c=1]).pop()[0]

assert.equal(compress("AAABBAAC"), "3A2B2A1C");
