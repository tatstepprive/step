--shows if the database is RAC (Real Application Clusters) = multiple instance open one database
select parallel from v$instance;
--NO (if no RAC, if single instance database)
