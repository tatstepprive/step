-- create 100 tables with name my_tablex where x=1-100, number rows all users
-- set some parts in comment by removing --
declare
 ddl_str1 varchar2(200);
 ddl_str2 varchar2(200);
 c int;
begin
  for i in 1..100 loop
    select count(*) into c from user_tables where table_name = upper('my_table'||i);
    if c = 1 then
        ddl_str1 := 'DROP TABLE my_table'||i;
        dbms_output.put_line(ddl_str1);
--/*      
        begin
          execute immediate ddl_str1;
        exception
          when others then
            dbms_output.put_line(SQLERRM);
        end;
--*/
    end if;
    ddl_str2 := 'create table my_table'||i||' AS (SELECT username FROM all_users) ';
    dbms_output.put_line(ddl_str2);
--/*    
    begin
      execute immediate ddl_str2;
    exception
      when others then
        dbms_output.put_line(SQLERRM);
    end;
--*/
  end loop;
end;
/
