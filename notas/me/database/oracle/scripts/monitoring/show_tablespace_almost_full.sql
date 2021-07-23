set linesize 300;
select
   a.tablespace_name,
   round(a.bytes_alloc / 1024 / 1024) mb_alloc,
   round(nvl(b.bytes_free, 0) / 1024 / 1024) mb_free,
   round((a.bytes_alloc - nvl(b.bytes_free, 0)) / 1024 / 1024) mb_used,
   round((nvl(b.bytes_free, 0) / a.bytes_alloc) * 100) Pct_Free,
   100 - round((nvl(b.bytes_free, 0) / a.bytes_alloc) * 100) Pct_used,
   round(maxbytes/1024 / 1024) Max
   --,(select 'Warning: FULL or ALMOST FULL' from dual where round(maxbytes/1048576)-round((a.bytes_alloc - nvl(b.bytes_free, 0)) / 1024 / 1024)<10) status
   , (select 'WARNING: FULL or ALMOST FULL' from dual where round((nvl(b.bytes_free, 0) / a.bytes_alloc) * 100)<10) status --Pct_Free < 10%
   from ( select f.tablespace_name, sum(f.bytes) bytes_alloc,
   sum(decode(f.autoextensible, 'YES',f.maxbytes,'NO', f.bytes)) maxbytes
from
   dba_data_files f
group by
   tablespace_name) a,
(  select
      f.tablespace_name,
      sum(f.bytes) bytes_free
   from
      dba_free_space f
group by
      tablespace_name) b
where
      a.tablespace_name = b.tablespace_name (+)
union
select
   h.tablespace_name,
   round(sum(h.bytes_free + h.bytes_used) / 1024 / 1024) mb_alloc,
   round(sum((h.bytes_free + h.bytes_used) - nvl(p.bytes_used, 0)) / 1024 /1024) mb_free,
   round(sum(nvl(p.bytes_used, 0))/ 1048576)  mb_used,
   round((sum((h.bytes_free + h.bytes_used) - nvl(p.bytes_used, 0)) /
   sum(h.bytes_used + h.bytes_free)) * 100) Pct_Free,
   100 - round((sum((h.bytes_free + h.bytes_used) - nvl(p.bytes_used, 0)) /
   sum(h.bytes_used + h.bytes_free)) * 100) Pct_used,
   round(max(h.bytes_used + h.bytes_free)/1024) Max
   ,(select 'nvt' from dual) status
from
   sys.v_$TEMP_SPACE_HEADER h, sys.v_$Temp_extent_pool p
where
   p.file_id(+) = h.file_id
and
   p.tablespace_name(+) = h.tablespace_name
group by
   h.tablespace_name
ORDER BY 6 desc;

