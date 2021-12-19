--show location (recommend: multiplex controlfile) 
select * from v$controlfile;
--1 shared row for multiple control files (multiplexed)
select value from v$parameter where name='control_files';
--1 row/controlfile for multiple control files (multiplexed)
select value from v$parameter2 where name='control_files';
