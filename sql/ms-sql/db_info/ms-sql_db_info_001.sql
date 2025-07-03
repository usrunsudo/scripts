/*
# ms-sql_db_info_001.sql
# Author: @usrunsudo
*/

WITH fs AS
(
    select database_id, type, size * 8.0 / 1024 size
    from sys.master_files
),
LastRestores AS
(
SELECT
	[d].[database_id],
    DatabaseName = [d].[name] ,
    [d].[create_date] ,
    [d].[compatibility_level] ,
    [d].[collation_name] ,
    r.*,
    RowNum = ROW_NUMBER() OVER (PARTITION BY d.Name ORDER BY r.[restore_date] DESC)
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.[restorehistory] r ON r.[destination_database_name] = d.Name
)
SELECT database_id, DatabaseName, create_date, restore_history_id, restore_date, user_name,
	(select sum(size) from fs where type = 0 and fs.database_id = LastRestores.database_id) DataFileSizeMB,
    (select sum(size) from fs where type = 1 and fs.database_id = LastRestores.database_id) LogFileSizeMB
FROM [LastRestores]
WHERE [RowNum] = 1
	AND database_id > 4
	AND DatabaseName NOT IN ('master', 'tempdb', 'model', 'msdb')
	--AND restore_date < Convert(datetime, '2024-01-01')
--ORDER BY database_id
ORDER BY DatabaseName
