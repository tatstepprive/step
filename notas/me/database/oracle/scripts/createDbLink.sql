
--create database link <link_name> connect to <user> identified by <pass> using <connect_string_for_remote_db>;
CREATE [PUBLIC] DATABASE LINK MY_LINK
    CONNECT TO remote_user IDENTIFIED BY password
    USING '(DESCRIPTION=
                (ADDRESS=(PROTOCOL=TCP)(HOST=oracledb.example.com)(PORT=1521))
                (CONNECT_DATA=(SERVICE_NAME=service_name))
            )';

--connect_string_for_remote_db can be:
--"(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=<hostname>)(PORT=<port>)))(CONNECT_DATA=(SERVICE_NAME=<service_name>)))"
--"(ADDRESS=(PROTOCOL=TCP)(HOST=<hostname>)(PORT=<port>)))(CONNECT_DATA=(SERVICE_NAME=<service_name>))"
-- entry from tnsnames.ora like pdb1 without details
select * from <table_name>@<link_name>;

select * from all_db_links;
select * from dba_db_links;

