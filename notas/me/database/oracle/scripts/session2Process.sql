SELECT machine,process, to_char (logon_time,'yyyy:mm:dd:HH:MI') as start_time
from v$session where username='HR';
--output process=1234
--If/when remote client uses SQL*Net to access the DB, 
--then OS process will display (LOCAL=NO)
--IIRC, V$SESSION.MACHINE will report which hostname the client connection originated.
--using LOGON/start times you can match the process on the remote client with the DB session
--ps -ef see STIME
--ps -eo user,%mem,%cpu,start see start
--px aux
