set linesize 132;
 select sysdate,  (select instance_name from v$instance) as sid, (select host_name from v$instance) as host  from dual ;
