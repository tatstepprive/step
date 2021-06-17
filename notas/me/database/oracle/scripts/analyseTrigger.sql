select * from all_triggers;
--output 70 rows
select * from user_triggers;
--output 2 rows for hr (status should be enabled)
select * from user_objects where object_name=upper('check_workhours');
--output 1 row
select * from user_objects where object_type='TRIGGER';
--output 2 rows for hr (status should be valid)
select * from all_objects where status='INVALID'
--output no rows
