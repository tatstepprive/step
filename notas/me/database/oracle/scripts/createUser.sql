CREATE USER james IDENTIFIED BY xxx;
GRANT connect TO james;
GRANT UNLIMITED TABLESPACE TO james;
GRANT create table, create view, create procedure, create sequence, create synonym TO james;
