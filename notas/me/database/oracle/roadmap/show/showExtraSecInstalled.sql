--show extra security installed
select * from v$option where parameter in ('Oracle Database Vault', 'Oracle Label Security');

--show what is not installed/used
select * from v$option where value='FALSE';
