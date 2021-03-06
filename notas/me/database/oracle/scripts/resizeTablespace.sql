-- resize system tablespace because it more then 99% used
alter tablespace system add datafile '/u01/app/oracle/oradata/ORCL/pdb1/system02.dbf' size 100m autoextend on next 10M maxsize unlimited;

alter tablespace system add datafile '/u01/app/oracle/oradata/ORCL/pdb1/system03.dbf' size 100m autoextend on next 10M maxsize unlimited;

--resize sysaux tablespace because it is more then 97% used
alter tablespace SYSAUX add datafile '/u01/app/oracle/oradata/ORCL/pdb1/sysaux02.dbf' size 100m autoextend on next 10M maxsize unlimited;
alter tablespace SYSAUX add datafile '/u01/app/oracle/oradata/ORCL/pdb1/sysaux03.dbf' size 100m autoextend on next 10M maxsize unlimited;


--resize undo tablespace because it is more then 95% used
--Attention not 150MB but 150M
select * from dba_data_files;
alter database datafile '/u01/app/oracle/oradata/ORCL/pdb1/undotbs01.dbf' resize 150M;
