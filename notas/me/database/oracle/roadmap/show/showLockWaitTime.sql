---Show Lock Wait Time (nice to use in monitoring)
SELECT 
  blocking_session "BLOCKING_SESSION",
  sid "BLOCKED_SESSION",
  serial# "BLOCKED_SERIAL#",
  seconds_in_wait "WAIT_TIME(SECONDS)",
  round(seconds_in_wait/60) "WAIT_TIME(MINUTES)"
FROM v$session
WHERE blocking_session is not NULL
ORDER BY blocking_session;

