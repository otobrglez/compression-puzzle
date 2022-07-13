const assert = require("assert");

//     v 79 chars, no regex /\/\/\:
compress=(s,r="",c=1)=>[...s].reduce((_,v,i,a)=>(v==a[i+1]?[0,c++]:[r+=c+v,c=1]),0)[0]

assert.equal(compress("AAABBAAC"), "3A2B2A1C");

