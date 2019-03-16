# Queen-Anne-Wizard-Shop

Implementation Assignment: Queen Anne Wizard Shop

For this assignment, we are going to use our data model from the last project assignment 
and create a Harry Potter themed Wizard Store.

Part I - Create Tables
Create the tables from the data model using SQL in the last Project Assignment. 
Name the sql file QAWS-CreateTable.sql.

Be sure to include Primary Keys, Foreign keys and On Update, On Delete functionality.

Use this table for the On Update, On Delete functionality:

[Relationship]--------[Referential Integrity Constraint]-----------------------[Cascading Behavior on Child] 
[PARENT----CHILD]                                                              [ON UPDATE---ON DELETE]  
                                                                               [PARENT PK---PARENT PK]

PERSON--CUSTOMER-----PersonID in CUSTOMER must exist in PersonID in PERSON-----NO(PROHIBIT)---YES 
PERSON--EMPLOYEE-----PersonID in EMPLOYEE must exist in PersonID in PERSON-----NO(PROHIBIT)---YES 
CUSTOMER--SALE---CustomerPersonID in SALE must exist in PersonID in CUSTOMER---NO(PROHIBIT)---NO(PROHIBIT) 
EMPLOYEE--SALE---EmployeePersonIDin EMPLOYEE must exist in PersonID in EMPLOYEE-NO(PROHIBIT)--NO(PROHIBIT) 
SALE---SALE_ITEM---SaleID in SALE_ITEM must exist in SaleID in SALE-------------NO(PROHIBIT)--YES 
ITEM---SALE_ITEM----ItemID in SALE_ITEM must exist in ItemID in ITEM------------NO(PROHIBIT)---NO(PROHIBIT) 
ITEM---ORDER--------ItemID in ORDER must exist in ItemID in ITEM----------------NO(PROHIBIT)---NO(PROHIBIT) 
VENDOR--ORDER-------VendorID in ORDER must exist in VendorID in VENDOR----------NO(PROHIBIT)---NO(PROHIBIT) 


Part II - Insert Data
Insert the data that is shown below in the tables of the Excel document posted in Canvas called QAWS.xlsx. 
Yes, it will be tedious. Name the file QAWS-InsertData.sql

Part III - Update and Delete
Create a sql file called QAWS-UpdateDelete.sql.
In it write a query to update the quantity on hand of Pine Wands to include 10 returned Pine Wands.
Write another query to add a returned item called "Magic Candles" that we got 5 of and are 10.00 a piece. 
Now insert a sale in the sale table for the current date that sells all of the candles to customer 10 from employee 2. 
Now insert into the Sale_Item table the correct data for that sale as well. 
Now delete from the SALE table where the SaleID is equal to the one you insert. 
Did the row in SALE_ITEM also delete? Why?

 
Part IV - Create Views, Triggers, and Stored Procedures
In a file called QAWS-ViewsTriggers.sql

(1) Write a SQL statement to create a view called SaleSummary View which will contain the:
SALE.SaleID, SALE.SaleDate, SALE_ITEM.Quantity, ITEM.ItemDescription, SALE.Total, in that order.
Then write a query to return all of the rows of this new view ordered by SaleID.

(2) Create a SQL statement to create a view called CustomerSaleSummaryView which will
list the SALE.SaleID, SALE.SaleDate, PERSON.LastName, PERSON.FirstName, ITEM.ItemDescription,
ITEM.ItemPrice in that order. Order them by SaleID.

(3) Create a trigger called CreditCardExpCheck that will cause 
a data constraint on the CUSTOMER table and wont allow a CreditCardExpirationDate to be inserted that is before today's date.
Today's date can be determined with the function: CURDATE().
In files called QAWS-InsertSale.sql and QAWS-InsertSaleItem.sql

(4) You are going to create two stored procedures. 
The ultimate goal is to to be able to insert a sale and it will 
add a row to the SALE table and then add a row to the SALE_ITEM table. 
This requires two stored procedures, with InsertSaleItem being called from within the stored procedure InsertSale. 
This is due to child insert constraints. It should be done if a person only wants to add 
a new sale item quantity to an existing sale, they can just called InsertSaleItem by itself. 
Please have both stored procedures check to make sure the SaleID and/or SaleItemID being attempted to insert do not exist.

** Clarification on 4. My intention was to have two stored procedures: InsertSale and InsertSaleItem. 
InsertSaleItem will be called within InsertSale. 
InsertSale will insert a new sale from parameters taken as input and then 
automatically created a new SaleItem row as well to indicate what sale items are included on the Sale being added. 
The part that is confusing is I mention the stored procedure InsertSaleItem should be able to work by itself instead 
of having to be called within InsertSale. **
