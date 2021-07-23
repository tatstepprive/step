 SELECT A.tablespace_name tablespace, 
    D.mb_total mb_alloc,
    (D.mb_total - SUM (A.used_blocks * D.block_size) / 1024 / 1024) mb_free,
    SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_used,
    round((( D.mb_total - SUM (A.used_blocks * D.block_size) / 1024 / 1024 )/ D.mb_total) * 100) Pct_Free,
    100 - round((( D.mb_total - SUM (A.used_blocks * D.block_size) / 1024 / 1024 )/ D.mb_total) * 100) Pct_used,
    K.mb_max
   FROM v$sort_segment A,
    (
   SELECT B.name, C.block_size, SUM (C.bytes) / 1024 / 1024 mb_total
    FROM v$tablespace B, v$tempfile C
     WHERE B.ts#= C.ts#
      GROUP BY B.name, C.block_size) D,
          (
   SELECT tablespace_name, round(maxbytes / 1024 / 1024) mb_max
    FROM dba_temp_files 
     ) K
    WHERE A.tablespace_name = D.name and A.tablespace_name=K.tablespace_name and D.name=k.tablespace_name
    GROUP by A.tablespace_name, D.mb_total,  K.mb_max;
