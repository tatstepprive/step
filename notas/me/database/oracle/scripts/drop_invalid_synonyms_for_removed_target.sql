-- for sqldeveloper : SET SERVEROUTPUT ON
--SET SERVEROUTPUT ON
declare
cursor syno is
   select a.owner, a.synonym_name, a.table_owner, a.table_name
   from all_synonyms a, dba_objects d
   where d.object_type='SYNONYM'
   and d.status='INVALID'
   and d.object_name=a.synonym_name;
--   and not exist (select object_name from dba_objects where owner=table_owner and object_name=table_name);--see v_target_count
v_target_count number;
ddl_str varchar2(300);
begin
   for syno_rec in syno 
   loop
   select count(*) into v_target_count
   from dba_objects 
   where owner=syno_rec.table_owner
   and object_name=syno_rec.table_name;
   if v_target_count = 0
      then
      ddl_str:='drop synonym '||syno_rec.owner||'.'||syno_rec.synonym_name;
      dbms_output.put_line(ddl_str);
--      begin
--         execute immediate ddl_str;
--      exception
--         when others then
--         dbms_output.put_line(SQLERRM);
--      end;
   end if;
   end loop;
end;
/
