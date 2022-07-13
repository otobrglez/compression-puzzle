using System;
using System.Text;


var s = "AAABBAACC";
var r = new StringBuilder();
var c = 1;
var i = 0;
do
{
  if (s[i] == s[i + 1])
  {
    c++;
  }
  else
  {
    r.Append("" + c + s[i]);
    c = 1;
  }
}
while (++i < s.Length - 1);

Console.WriteLine(r.ToString());
