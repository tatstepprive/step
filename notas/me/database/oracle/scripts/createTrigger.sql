--Create trigger for row level event (fired on each row affected, no rows not fired)
create or replace trigger my_trigger
before update
on my_table
for each row
begin
dbms_output.put_line('Inserted');
end;
/
