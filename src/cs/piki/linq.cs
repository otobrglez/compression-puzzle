using System;
using System.Linq;
using MoreLinq;


var result = String.Concat("AAABBAACC".GroupAdjacent(c => c, (c, cc) => "" + cc.Count() + c));
Console.WriteLine(result);
