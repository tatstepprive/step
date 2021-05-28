-- register services after restart listener to skip wait time 60 sec
alter system register;

-- show listener parameter value=listener_<sid> ; written in tnsnames.ora
-- or value can be direct (ADDRESS = (PROTOCOL = TCP)(HOST = <host>)(PORT = <port>))
-- if value is empty - no problem, default listener values for services registration will be taken 
show parameter local;
