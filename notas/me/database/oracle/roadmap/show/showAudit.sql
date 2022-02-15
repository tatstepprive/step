--show fga and unified audit 
select * from v$option where parameter like '%udit%';
--Fine-grained Auditing	TRUE	0 (=FGA audit)
--Unified Auditing	TRUE	0 (=unified audit)

--show standard audit
select * from v$parameter where name='audit_trail';
--value=null (default, disabled), value=DB (enabled)

--show audit logs path on OS (include connect attempts, bounce, any alter system, alter database commands)
select * from v$parameter where name='audit_file_dest';

--audit
select * from dba_objects where owner='AUDSYS';
select * from dba_objects where owner='AUDSYS' and object_type='TABLE';
select * from AUDSYS.AUD$UNIFIED;
select * from AUDSYS."AUD$UNIFIED";
select * from unified_audit_trail;
