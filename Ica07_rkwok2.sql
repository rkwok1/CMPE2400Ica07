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
where SupplierID in (select SupplierID
					 from  Suppliers
					 where Country in ('Sweden','Italy'))
order by UnitPrice
go

--q4--
select ProductName as 'Product Name', UnitPrice as 'Unit Price' from Products
where exists (select SupplierID
			  from Suppliers
			  where Country in ('Sweden','Italy')And Suppliers.SupplierID = Products.SupplierID) --Making sure you are comapring supplier ids from both tables being the same-- 
order by UnitPrice
go

--q5--
declare @minPrice int = 20

select ProductName as 'Product Name' from Products
where CategoryID in (select CategoryID
					 from Categories
					 where CategoryName in ('Seafood','Confections')) and (UnitPrice > @minPrice)
order by CategoryID asc, ProductName asc
go

--q6--
declare @minPrice int = 20
select ProductName as 'Product Name'from Products
where exists (select CategoryName
			  from Categories
			  where CategoryName in ('Seafood','Confections') and Categories.CategoryID = products.CategoryID) and (UnitPrice > @minPrice)
order by  CategoryID asc, ProductName asc
go

--q7--
declare @max int = 15
select CompanyName as 'Company Name', Country from Customers
where CustomerID in (select CustomerID 
				  from Orders
				  where	OrderID in ( select OrderID --Connection to Order Details
									 from [Order Details]
									 where (UnitPrice*Quantity) < @max))
order by Country
go
			
--q8--

declare @max int =15
select CompanyName as 'Company Name', Country from Customers
where exists (select CustomerID
			  from Orders
			  where exists (select OrderID
							from [Order Details]
			 				where ((UnitPrice*Quantity) < @max) and [Order Details].OrderID = Orders.OrderID )
			  and Orders.CustomerID = Customers.CustomerID) --exists does not need the in clause

order by Country
go

--q9--

declare @7days int = 7;
select ProductName as 'Product Name' from Products
where ProductID in( select ProductID
					from [Order Details]
					where OrderID in ( select OrderID
									   from Orders
									   where CustomerID in (select CustomerID
															from Customers
														    where Country in('UK','USA'))
									   and( DATEDIFF(DD,RequiredDate,ShippedDate)) > @7days))

order by ProductName asc
go

--q10--
select OrderID as 'Order ID', ShipCity as "Ship City" from Orders
where OrderID in (select OrderID
				  from [Order Details]
				  where ProductID in (select ProductID
									  from Products
									  where SupplierID in (select SupplierID
														   from Suppliers
														   where Suppliers.City = Orders.ShipCity)))
order by ShipCity asc
go

														      						
										