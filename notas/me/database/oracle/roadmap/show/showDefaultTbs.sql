--show default tablespaces in db
select * from database_properties where property_name like '%TABLESPACE%';
-- output property_name property_value description
-- output DEFAULT_TEMP_TABLESPACE TEMP
-- output DEFAULT_PERMANENT_TABLESPACE USERS
