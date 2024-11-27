# Find the product that genrated high revenue? 
 SELECT 
    ProductName, SUM(Quantity * PricePerUnit) TotalRevenue
FROM
    orderdetails
GROUP BY 1
order by totalrevenue desc 
limit 1 ; 

# Which city has placed the highest number of orders?
SELECT 
    c.city, COUNT(o.orderid) AS TotalOrders
FROM
    customers c
        JOIN
    orders o ON c.customerid = o.CustomerID
GROUP BY c.city
ORDER BY totalorders DESC;

# What is the total number of delivered and canceled orders?
SELECT 
    o.DeliveryStatus, COUNT(od.OrderID) totalorders
FROM
    orders o
        JOIN
    orderdetails od ON o.OrderID = od.OrderID
GROUP BY DeliveryStatus;

#what is the total revenue of generated
SELECT 
    SUM(Totalamount) AS TotalSales
FROM
    orders;
   
   #Find the city with the highest total revenue
    SELECT 
    c.city, SUM(o.TotalAmount) TotalAmount
FROM
    customers c
        JOIN
    orders o ON c.CustomerID = o.CustomerID
GROUP BY c.city
ORDER BY totalamount DESC
LIMIT 1;

# Identify customers who haven't placed any orders.
SELECT 
    c.CustomerID, c.name
FROM
    customers c
        LEFT JOIN
    orders o ON c.CustomerID = o.CustomerID
        LEFT JOIN
    orderdetails od ON o.OrderID = od.OrderID
WHERE
    od.OrderID IS NULL
; 
#List all customers with their rank based on total spending
select c.CustomerID, c.name,sum(o.totalamount) TotalSpend,
rank() over (order by sum(o.totalamount) desc) as 'Rank'
 from customers c
 join orders o on c.customerid = o.customerid	
 group by c.CustomerID,c.Name
;

# List all customers with their rank based on total purchase 
select c.CustomerID,c.name,sum(od.quantity * od.PricePerUnit) TotalPurchase,
rank() over (order by sum(od.quantity) desc)as 'rank'
 from customers c
 join orders o on c.CustomerID = o.CustomerID
 join orderdetails od on o.OrderID = od.OrderID
 group by 1,2
;

#Find customers who placed multiple orders on the same day.
SELECT 
    customerid,
    DATE(orderdatetime) Orderdate,
    COUNT(orderid) OrderCount
FROM
    orders
GROUP BY 1 , 2
HAVING 3 > 1;
;

# List the top 5 customers based on their totalPurchase 
with Cte as(SELECT 
    c.CustomerID, c.name as Name, c.city, SUM(od.Quantity * od.PricePerUnit) TotalAmount
FROM
    customers c
        JOIN
    orders o ON c.CustomerID = o.CustomerID
    join orderdetails od on o.OrderID = od.OrderID
GROUP BY 1 , 2 , 3
ORDER BY TotalAmount DESC)
select Name,totalamount from cte
limit 5
;

