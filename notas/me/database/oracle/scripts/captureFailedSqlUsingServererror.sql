--Issue: Capture Failed SQL using servererror trigger
--capture all ora- exceptions

-- Create monitor table
create table server_errors (

  error_time        timestamp,
  username  varchar2(30),
  error_message   varchar2(512),
  sql_statement      varchar2(2014)
);

-- Catch All error
create or replace trigger catch_servererrors
   after servererror on database
declare
   sql_text ora_name_list_t;
   message varchar2(2000) := null;
   statement varchar2(2000) := null;
begin
  for depth in 1 .. ora_server_error_depth loop
    message:= message|| ora_server_error_msg(depth);
  end loop;

  for i in 1 .. ora_sql_txt(sql_text) loop
     statement := statement || sql_text(i);
  end loop;

  insert into server_errors (error_time,username,error_message,sql_statement) values (sysdate, ora_login_user,message,statement);
end;
/

--Note: The servererror Trigger cannot fire for the following errors:
--ORA-01403: no data found
--ORA-01422: exact fetch returns more than requested number of rows
--ORA-01034: ORACLE not available
--ORA-04030: out of process memory when trying to allocate string bytes (string, string)
--ORA-01423: error encountered while checking for extra rows in exact fetch
