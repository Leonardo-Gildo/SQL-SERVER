###############################################################
# 🚢 Passo a Passo - Restaurar Banco AdventureWorks no Docker
# Autor: Leonardo Gildo
# Objetivo: Migrar BD do SQL Server local -> Docker (SQL Server)
###############################################################

# ==============================================
# 1. Criar BACKUP no SQL Server (instância local)
# ==============================================
-- Execute no SSMS (Windows local)
BACKUP DATABASE [AdventureWorksDW2019]
TO DISK = 'C:\Backup\AdventureWorksDW2019.bak'
WITH INIT, FORMAT;

# ==============================================
# 2. Copiar o .bak para o container Docker
# ==============================================
# No PowerShell:
# (ajuste o nome do container caso não seja sql2022)

# Criar a pasta de backup dentro do container (se não existir)
docker exec -it sql2022 mkdir -p /var/opt/mssql/backup

# Copiar o .bak do Windows para dentro do container
docker cp "C:\Backup\AdventureWorksDW2019.bak" sql2022:/var/opt/mssql/backup/

# Confirmar se o arquivo chegou ao container
docker exec -it sql2022 ls -lh /var/opt/mssql/backup/

# ==============================================
# 3. Descobrir nomes lógicos do .bak
# ==============================================
-- Execute no SSMS/ADS conectado ao Docker (localhost,1433)
RESTORE FILELISTONLY 
FROM DISK = '/var/opt/mssql/backup/AdventureWorksDW2019.bak';

-- Isso vai mostrar algo como:
-- LogicalName: AdventureWorksDW2017
-- LogicalName: AdventureWorksDW2017_log

# ==============================================
# 4. Restaurar o banco dentro do Docker
# ==============================================
-- Use os nomes lógicos descobertos no passo anterior
-- Aqui forçamos a restaurar como AdventureWorksDW2019

RESTORE DATABASE [AdventureWorksDW2019]
FROM DISK = '/var/opt/mssql/backup/AdventureWorksDW2019.bak'
WITH MOVE 'AdventureWorksDW2017' TO '/var/opt/mssql/data/AdventureWorksDW2019.mdf',
     MOVE 'AdventureWorksDW2017_log' TO '/var/opt/mssql/data/AdventureWorksDW2019_log.ldf',
     REPLACE;

# ==============================================
# 5. Validar
# ==============================================
-- Verificar no SSMS/ADS (Docker) se o banco aparece em Databases
SELECT name, create_date 
FROM sys.databases
WHERE name = 'AdventureWorksDW2019';
