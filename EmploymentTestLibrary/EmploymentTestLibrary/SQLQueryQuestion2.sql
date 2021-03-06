--В БД есть таблица с регистрацией клиентов вида CustomerId, RegistrationDateTime, Name и таблица с покупками клиентов вида CustomerId, PurchaiseDatetime, ProductName. Напишите SQL запрос, который выберет имена клиентов, которые когда-либо покупали молоко, но не покупали сметану за последний месяц.

USE MASTER
GO

IF NOT EXISTS (SELECT name FROM sysdatabases WHERE name = N'TestDB')
BEGIN
CREATE DATABASE [TestDB] 
END
GO

USE TestDB
GO

CREATE TABLE Customers 
(		CustomerId int NOT NULL IDENTITY 
			                 PRIMARY KEY,
		RegistrationDateTime DATE NOT NULL,
		Name NVARCHAR(30) NOT NULL,
		CHECK (RegistrationDateTime < SYSUTCDATETIME())
)

CREATE TABLE Sells 
(		OrderID int NOT NULL IDENTITY 
			PRIMARY KEY,
			CustomerId int,
		 PurchaseDateTime Date NOT NULL,
		ProductName NVARCHAR(30) NOT NULL,
		FOREIGN KEY(CustomerId) REFERENCES Customers(CustomerId),
		CHECK (PurchaseDateTime < SYSUTCDATETIME())
)

INSERT Customers (RegistrationDateTime, Name) 
VALUES 
('10/20/2017', 'Ivan Ivanych'),
('10/20/2017', 'Pyotr Petrovich'),
('10/05/2017', 'Dima'),
('10/04/2017', 'Egor Sanych'),
('10/20/2017', 'Volodya');
GO

INSERT [TestDB].[dbo].[Sells] (CustomerId, PurchaseDatetime, ProductName) 
VALUES 
(1, '11/21/2017','Milk'),
(1,'10/20/2017', 'Milk'),
(1,'10/20/2017', 'Sour Cream'),
(2,'10/20/2017', 'Sour Cream'),
(2,'12/04/2017', 'Milk'),
(2,'12/04/2017', 'Sour Cream'),
(3,'11/10/2017', 'Sour Cream'),
(3,'12/1/2017', 'Milk'),
(4,'11/28/2017', 'Milk'),
(5,'10/04/2017', 'Sour Cream'),
(5,'12/05/2017', 'Milk');
GO

SELECT DISTINCT Name FROM
	(SELECT CustomersID FROM
		(SELECT [CustomerId] AS CustomersID FROM [TestDB].[dbo].[Sells]
			WHERE ProductName = 'Milk') as a
		LEFT JOIN
		(SELECT [OrderID],[CustomerId] FROM [TestDB].[dbo].[Sells]
			WHERE ProductName = 'Sour Cream' AND PurchaseDatetime > DATEADD(month, -1, SYSUTCDATETIME())) as b -- not cool, maybe?
		ON CustomersID = b.[CustomerId]
		WHERE b.OrderID IS NULL ) c
	LEFT JOIN Customers
ON c.CustomersID = CustomerId


GO