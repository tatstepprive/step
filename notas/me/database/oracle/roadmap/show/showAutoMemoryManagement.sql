-- AMM automatic memory management (memory transfer between pga and sga possible)
-- memory_target should not be 0, (disabled if 0)
-- memory_max_target 20% of memory_target
select * from v$parameter where name = 'memory_target';
select * from v$parameter where name = 'memory_max_target';
--show last operation on memory
select * from  V$MEMORY_RESIZE_OPS order by start_time desc;
--show sga usage
select to_char(sum(value)) from v$sga;
--show memory usage per process
SELECT to_char(ssn.sid, '9999') || ' - ' || nvl(ssn.username, nvl(bgp.name, 'background')) ||
nvl(lower(ssn.machine), ins.host_name) "SESSION",
to_char(prc.spid, '999999999') "PID/THREAD",
to_char((se1.value/1024)/1024, '999G999G990D00') || ' MB' " CURRENT SIZE",
to_char((se2.value/1024)/1024, '999G999G990D00') || ' MB' " MAXIMUM SIZE"
FROM v$sesstat se1, v$sesstat se2, v$session ssn, v$bgprocess bgp, v$process prc,
v$instance ins, v$statname stat1, v$statname stat2
WHERE se1.statistic# = stat1.statistic# and stat1.name = 'session pga memory'
AND se2.statistic# = stat2.statistic# and stat2.name = 'session pga memory max'
AND se1.sid = ssn.sid
AND se2.sid = ssn.sid
AND ssn.paddr = bgp.paddr (+)
AND ssn.paddr = prc.addr (+)
order by 3 desc;
---------------------------------
--session id and process id relationship
SELECT a.username, a.osuser, a.program, spid, sid, a.serial# ,module FROM v$session a, v$process b WHERE a.paddr = b.addr AND spid = 3998;
--on OS: top, shift-m to find memory consuming processes
--on OS: processes per instance: ps aux | grep <sid>
---------------------------------
