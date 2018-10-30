connect to bigsql XXconnectXX;

select D.ID,max(T.tm) from XXtable1XX AS D , XXtableXX AS T WHERE T.part=D.part GROUP BY D.ID;

terminate;
