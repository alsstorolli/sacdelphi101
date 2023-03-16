CD\Program Files (x86)\PostgreSQL\9.6\bin\
 SET PGPASSWORD=sacd35269147
pg_dump.exe --host 192.168.10.105 --encoding latin1 --port 5432 --username "sac"  --format plain -C --column-inserts --file "\sac\scripttempcliente.sql" --table clientestemp sac60
