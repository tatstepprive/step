--check for invalid synonym and the target object exists
select owner, synonym_name, table_owner, table_name
from all_synonyms
where synonym_name in  (select object_name from dba_objects where status='INVALID' and object_type='SYNONYM');
and exists (select object_name from dba_objects where owner=table_owner and object_name=table_name);

--create or replace [public] synonym owner.synonym_name for table_owner.table_name;
