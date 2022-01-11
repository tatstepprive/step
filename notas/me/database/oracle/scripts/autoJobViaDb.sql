--Compile invalid objects each 15 minutes 
CREATE OR REPLACE PROCEDURE SYS.COMPILE_INVALID_OBJ_PROC
AS
   cursor cur is
   select owner,
   object_name,
   object_type,
   decode (object_type, 'PACKAGE',2, 'PACKAGE_BODY', 3,1) as recompile_order,
   decode(object_type,'PACKAGE BODY','PACKAGE', object_type) as object_type2compile,
   decode(object_type,'PACKAGE BODY','BODY','') as body2comile
   from dba_objects
   where  status='INVALID'
   and object_type in ('PACKAGE', 'PACKAGE BODY', 'PROCEDURE', 'FUNCTION', 'TRIGGER', 'VIEW', 'TYPE')
   order by 4;
ddl_str varchar2(250);
begin
   for cur_rec in cur
   loop
    ddl_str:= 'ALTER ' || cur_rec.object_type2compile || ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE '|| cur_rec.body2comile;
      dbms_output.put_line(ddl_str||';');
      begin
         execute immediate ddl_str;
      exception
         when others then
         dbms_output.put_line(SQLERRM);
      end;
   end loop;
end;
/
begin
dbms_scheduler.create_job(
job_name=>'mon_compile_inv_obj',
job_type=>'stored_procedure',
job_action=>'SYS.COMPILE_INVALID_OBJ_PROC',
start_date=>sysdate,
repeat_interval=>'freq=minutely; interval=15',
enabled=>true,
auto_drop=>false);
end;
/
------------------------------------------
