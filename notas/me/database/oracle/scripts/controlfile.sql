show CON_NAME;
--PDB1
show parameters control_files;
shutdown immediate;
-- move or copy control file (do no move or copy when db open)
startup nomount;
alter system set control_files="/data/control01.ctl, /data2/control01.clt, /data3/control03.ctl" scope=spfile;
startup force;
show parameters control_files;

