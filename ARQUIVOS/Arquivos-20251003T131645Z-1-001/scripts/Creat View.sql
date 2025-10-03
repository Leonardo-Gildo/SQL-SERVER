
--create view
--alter view
--drop view

--create  view nome_view as 
--select ( a consulta que voce quiser disponibilizar)

--alteracao  create or alter view (nome_view) as select ( a consulta que voce quiser disponibilizar)



create or alter view VW_chefao as 
select 
EmployeeKey
,LastName
,Title
,Phone
,EmailAddress
,DepartmentName
from [dbo].[DimEmployee]
where DepartmentName = 'Marketing'


select * from VW_chefao

























































create or alter  view vw_chefao as 
select *
from [dbo].[DimEmployee]
where DepartmentName = 'Production'



create create view nome_view as 
select ( a consulta que voce quiser disponibilizar)











