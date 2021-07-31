 SELECT DS.TABLESPACE_NAME, SEGMENT_NAME, ROUND(SUM(DS.BYTES) / (1024 * 1024)) AS MB
 FROM DBA_SEGMENTS DS
 WHERE SEGMENT_NAME IN (SELECT TABLE_NAME FROM DBA_TABLES)
 GROUP BY DS.TABLESPACE_NAME,
       SEGMENT_NAME
 ORDER BY 3 DESC;

---------------------------------
SELECT owner, segment_type, segment_name, COUNT(*)
FROM   dba_extents
GROUP BY owner, segment_type, segment_name
ORDER BY segment_type, segment_name;
