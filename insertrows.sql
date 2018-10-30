connect to bigsql XXconnectXX;

INSERT INTO XXtableXX
WITH cte(id,pos,fl,st,tm,part) AS
(VALUES('ID1',1,0,'',NULL,0) UNION ALL
SELECT
'ID'||(pos+1),pos + 1,RAND(),
'val='||RAND(),
(TIMESTAMP('1970-01-01','00:00:00') + (RAND() * 1411000000) SECONDS),
CASE WHEN part < 9 THEN part+1 ELSE 0 END
FROM cte
WHERE pos < XXtablesizeXX)
SELECT * FROM cte;


terminate;
