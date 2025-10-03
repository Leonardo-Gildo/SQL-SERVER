# 🚢 Restaurar AdventureWorks no Docker

Este guia descreve o passo a passo para restaurar o banco **AdventureWorksDW2019** em um container Docker com SQL Server.

---

## 📂 Estrutura
- **Backup local (.bak)** → gerado no SQL Server (Windows local).
- **Docker (sql2022)** → destino do banco de dados restaurado.

---

## 🛠️ Passo a Passo

### 1. Criar BACKUP no SQL Server (instância local)
```sql
BACKUP DATABASE [AdventureWorksDW2019]
TO DISK = 'C:\Backup\AdventureWorksDW2019.bak'
WITH INIT, FORMAT;

# Criar a pasta de backup dentro do container (se não existir)
docker exec -it sql2022 mkdir -p /var/opt/mssql/backup

# Copiar o .bak do Windows para dentro do container
docker cp "C:\Backup\AdventureWorksDW2019.bak" sql2022:/var/opt/mssql/backup/

# Confirmar se o arquivo chegou ao container
docker exec -it sql2022 ls -lh /var/opt/mssql/backup/

RESTORE FILELISTONLY 
FROM DISK = '/var/opt/mssql/backup/AdventureWorksDW2019.bak';

RESTORE DATABASE [AdventureWorksDW2019]
FROM DISK = '/var/opt/mssql/backup/AdventureWorksDW2019.bak'
WITH MOVE 'AdventureWorksDW2017' TO '/var/opt/mssql/data/AdventureWorksDW2019.mdf',
     MOVE 'AdventureWorksDW2017_log' TO '/var/opt/mssql/data/AdventureWorksDW2019_log.ldf',
     REPLACE;

SELECT name, create_date 
FROM sys.databases
WHERE name = 'AdventureWorksDW2019';
