
use DWAdventure
select*
into tb_temp_emplo
from DimEmployee


select 
EmployeeKey
,FirstName
,LastName
,MiddleName
,StartDate
,EndDate
from dbo.tb_temp_emplo


 update dbo.tb_temp_emplo
 set EndDate = GETDATE() 


 drop table dbo.tb_temp_emplo