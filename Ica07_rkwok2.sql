--ica 07 Ryan Kwok--

--q1--
declare @max int = 800;
select LastName as 'Last Name', Title from Employees
where EmployeeID in ( select EmployeeID --must be the same as initial
					  from Orders --You can continue down from your from statements from the 'from' clause
					  where Freight > @max)
order by LastName
go

--q2--

declare @max int = 800;
select LastName as 'Last Name', Title from Employees
where exists ( select Freight
			   from Orders 
			   where Freight > @max
			   and Employees.EmployeeID = Orders.EmployeeID)
order by LastName
go

--q3--
select ProductName as ' Product Name', UnitPrice as 'Unit Price' from Products
where EmployeeID in {select EmployeeID
					 from  Employees
					 where Country
									