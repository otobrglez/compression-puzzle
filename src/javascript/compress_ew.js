const assert = require("assert");

//     v 74 chars, no regex /\/\/\:
compress=s=>[...s].reduce(([r,c],v,i,a)=>(v==a[i+1]?[r,c+1]:[r+c+v,1]),['',1])[0]

assert.equal(compress("AAABBAAC"), "3A2B2A1C");

