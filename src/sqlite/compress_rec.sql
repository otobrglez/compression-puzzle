/* SQLite 3 supports recursive queries for graphs, etc ... */

DROP VIEW IF EXISTS compress_view;

CREATE VIEW compress_view AS
WITH RECURSIVE
  letters(x, prev, cnt, result) AS (
     SELECT "AAABBAAC" , "", 1, ""
     UNION ALL
     SELECT substr(x,2), 
      substr(x,2,1), 
      case when prev = "" OR prev = substr(x,2,1) then cnt + 1 else 1 end,
      case when prev = "" OR prev = substr(x,2,1) then result else result || cnt || prev end
      FROM letters LIMIT 9
  )
SELECT * FROM letters;

SELECT * FROM compress_view;

/* returns a more interesting result
AAABBAAC||1|
AABBAAC|A|2|
ABBAAC|A|3|
BBAAC|B|1|3A
BAAC|B|2|3A
AAC|A|1|3A2B
AC|A|2|3A2B
C|C|1|3A2B2A
||1|3A2B2A1C
*/

SELECT max(result) FROM compress_view;

/* returns
3A2B2A1C
*/
