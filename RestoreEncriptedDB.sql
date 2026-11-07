USE [master]
RESTORE DATABASE
[Hotel]
FROM DISK = 'C:\SQLSERVERBackup\Hotel_TDE.bak'
WITH FILE = 1, 
MOVE 'Hotel' TO 'C:\Users\zapat\Hotel.mdf',
MOVE 'Hotel_log' TO 'C:\Users\zapat\Hotel_log.ldf',
NOUNLOAD, STATS = 5

-- Creacion llave maestra
CREATE MASTER KEY ENCRYPTION
BY PASSWORD='MiLlaveMaestra123*';
GO
-- Creacion certificado
CREATE CERTIFICATE TDE_HOTELERIACERT
FROM FILE = 'C:\SQLSERVERBackup\TDE_HOTELERIA_CERT'
WITH PRIVATE KEY (FILE='C:\SQLSERVERBackup\TDE_HOTELERIA_PrivateKey.pvk', 
	ENCRYPTION BY PASSWORD='MiContraseñaDeEncriptacion123*')
GO

USE [master]
RESTORE DATABASE
[Hotel]
FROM DISK = 'C:\SQLSERVERBackup\Hotel_TDE.bak'
WITH FILE = 1, 
MOVE 'Hotel' TO 'C:\Users\zapat\Hotel.mdf',
MOVE 'Hotel_log' TO 'C:\Users\zapat\Hotel_log.ldf',
NOUNLOAD, STATS = 5