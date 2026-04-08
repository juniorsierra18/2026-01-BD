SELECT p.productname
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE NOT EXISTS (
        SELECT 1
        FROM orders o
        JOIN orderdetails od ON o.orderid = od.orderid
        WHERE od.productid = p.productid
        AND o.employeeid = e.employeeid
    )
);
SELECT c.contactname
FROM customers c
WHERE (
    SELECT MAX(od.unitprice)
    FROM orders o
    JOIN orderdetails od ON o.orderid = od.orderid
    WHERE o.customerid = c.customerid
) < 50;
SELECT e.title, e.firstname, e.lastname
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM orders o
    JOIN orderdetails od ON o.orderid = od.orderid
    JOIN products p ON od.productid = p.productid
    WHERE o.employeeid = e.employeeid
    AND p.productname IN ('Gravad Lax', 'Mishi Kobe Niku')
);
SELECT e.firstname, e.lastname, c.companyname
FROM employees e
JOIN customers c ON c.city = 'Bruxelles'
WHERE (e.employeeid, c.customerid) IN (
    SELECT o.employeeid, o.customerid
    FROM orders o
    JOIN shippers s ON o.shipvia = s.shipperid
    WHERE s.companyname = 'Speedy Express'
);
SELECT e.firstname, e.lastname, e.address, e.city, e.region
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.employeeid = e.employeeid
      AND o.shipcountry = 'Belgium'
);
