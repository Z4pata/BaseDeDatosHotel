USE Hotel;
GO

-- Backup FULL
BACKUP DATABASE Hotel
TO DISK = 'C:\SQLSERVERBackup\Hotel_FULL.bak'
WITH
    FORMAT,
    INIT,
    NAME = 'Backup Completo Hotel',
    STATS = 10;
GO

-- RESTORE FULL a otra conexion
RESTORE DATABASE Hotel
FROM DISK = 'C:\SQLSERVERBackup\Hotel_FULL.bak'
WITH
    MOVE 'Hotel'
        TO 'C:\SQLData\Hotel.mdf',
    MOVE 'Hotel_log'
        TO 'C:\SQLLogs\Hotel_log.ldf',
    REPLACE,
    RECOVERY,
    STATS = 10;
GO

-- Backup DIFFERENTIAL
-- Debe haber primero un FULL
-- Backup FULL
BACKUP DATABASE Hotel
TO DISK = 'C:\SQLSERVERBackup\Hotel_FULL.bak'
WITH
    FORMAT,
    INIT,
    NAME = 'Backup Completo Hotel',
    STATS = 10;
GO

-- Con el FULL hecho, generamos el DIFFERENTIAL
BACKUP DATABASE Hotel
TO DISK = 'C:\SQLSERVERBackup\Hotel_DIFF.bak'
WITH
    DIFFERENTIAL,
    INIT,
    NAME = 'Backup Diferencial Hotel',
    STATS = 10;
GO

-- RESTORE DIFFERENTIAL
-- Restaurar el FULL
RESTORE DATABASE Hotel
FROM DISK = 'C:\SQLSERVERBackup\Hotel_FULL.bak'
WITH
    NORECOVERY,
    REPLACE,
    STATS = 10;
GO

-- Restaurar DIFFERENTIAL
RESTORE DATABASE Hotel
FROM DISK = 'C:\SQLSERVERBackup\Hotel_DIFF.bak'
WITH
    RECOVERY,
    STATS = 10;
GO


-- Backup LOG
-- Solo funciona con recovery model de la base de datos en FULL
SELECT
    name,
    recovery_model_desc
FROM sys.databases
WHERE name = 'Hotel';

-- Debe haber un Backup FULL
BACKUP DATABASE Hotel
TO DISK = 'C:\SQLSERVERBackup\Hotel_FULL.bak'
WITH INIT, STATS = 10;
GO

-- Crear Backup LOG
BACKUP LOG Hotel
TO DISK = 'C:\SQLSERVERBackup\Hotel_LOG_01.trn'
WITH INIT, STATS = 10;
GO
-- segundo Backup LOG
BACKUP LOG Hotel
TO DISK = 'C:\SQLSERVERBackup\Hotel_LOG_02.trn'
WITH INIT, STATS = 10;
GO

-- Restaurar Backup LOG
-- primero se restaura el FULL
RESTORE DATABASE Hoteleria
FROM DISK = 'C:\SQLSERVERBackup\Hotel_FULL.bak'
WITH NORECOVERY, REPLACE;
GO

-- luego cada LOG en orden
RESTORE LOG Hotel
FROM DISK = 'C:\SQLSERVERBackup\Hotel_LOG_01.trn'
WITH NORECOVERY;
GO

RESTORE LOG Hotel
FROM DISK = 'C:\SQLSERVERBackup\Hotel_LOG_02.trn'
WITH NORECOVERY;
GO
