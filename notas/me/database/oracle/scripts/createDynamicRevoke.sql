--create dynamic revoke, copy and past result and execute
select 'REVOKE ', privilege , 'FROM ', grantee, ';'
   from dba_sys_privs
   where privilege like '% ANY %'
   and grantee in (select username from dba_users where oracle_maintained='N')
   and grantee not in ('MONITOR_RO')
   and privilege not in ('SELECT ANY DICTIONARY')
 -- and grantee='MY_SCHEMA'
   order by 4,2;

--check counts
 select  grantee, count(*)
   from dba_sys_privs
   where privilege like '% ANY %'
   and grantee in (select username from dba_users where oracle_maintained='N')
   and grantee not in ('MONITOR_RO')
   and privilege not in ('SELECT ANY DICTIONARY')
 -- and grantee='MY_SCHEMA'
   group by grantee
   order by 2;
