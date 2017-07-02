-- informations
SELECT current_database();

SELECT current_user;
SELECT inet_server_addr(), inet_server_port();
SELECT version();

conninfo

ALTER USER postgres PASSWORD ' md53175bce1d3201d16594cebf9d7eb3f9d';

SELECT date_trunc('second', current_timestamp - pg_postmaster_start_time()) as uptime;

SELECT pg_postmaster_start_time(); 
SELECT current_timestamp - pg_postmaster_start_time(); 





