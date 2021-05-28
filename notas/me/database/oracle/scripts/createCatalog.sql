select * from v$instance;

select * from v$pdbs;

alter session set container=RCATPDB;

--to support multiple db and avoid confusion tablespace name = user name = user pass = CAT_<SID>_<SERVER>
--on catalog db (rcat)  tablespace name cat_<sid>_<server>
create tablespace CAT_ORCL_ORACLEDB datafile 'CAT_ORCL_ORACLEDB.dbf' size 200M;

--on catalog db (rcat) user name cat_<sid>_<server>
create user CAT_ORCL_ORACLEDB identified by "CAT_ORCL_ORACLEDB" default tablespace CAT_ORCL_ORACLEDB;
grant connect to CAT_ORCL_ORACLEDB;
grant resource to CAT_ORCL_ORACLEDB;
grant recovery_catalog_owner to CAT_ORCL_ORACLEDB;
grant unlimited tablespace to CAT_ORCL_ORACLEDB;

--on target db
--adapt tnsnames.ora by adding catalog db (rcat)
--connect to register: rman catalog CAT_ORCL_ORACLEDB@RCATPDB
--pass CAT_ORCL_ORACLEDB
--rman> create catalog;
--rman> connect target sys@orcl
--rman> register database;
--rman> report schema;
--rman> exit
--connect when registered: rman target / catalog CAT_ORCL_ORACLEDB@RCATPDB
--rman> resync catalog; --it's auto, but can be forced
