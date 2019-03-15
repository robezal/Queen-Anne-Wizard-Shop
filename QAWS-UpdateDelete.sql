#update the quantity on hand of Pine Wands to include 10 returned Pine Wands.
UPDATE ITEM
     SET QuantityOnHand = 30  
     WHERE ItemID = 6 ;
     
#add a returned item called "Magic Candles" that we got 5 of and are 10.00 a piece.
INSERT INTO ITEM(ItemID, ItemDescription, ReorderPointQuantity, QuantityOnHand, ItemPrice)
VALUES(17,'Magic Candles', NULL, 5, 10.00);

#insert a sale in the sale table for the current date that sells all of the candles to customer 10 from employee 2.
INSERT INTO SALE(SaleID, SaleDate, SubTotal, Tax, Total, CustomerPersonID, EmployeePersonID)
VALUES(8, '2019-03-08', 50.00, 5.11, 55.55, 10, 2);

#insert into the Sale_Item table the correct data for that sale as well.
INSERT INTO SALE_ITEM(SaleID, SaleItemID, Quantity, ItemPrice, ExtendedPrice, ItemID)
VALUES(8,1, 5,10.00, 50.00,17);

#delete from the SALE table where the SaleID is equal to the one you insert.
DELETE 
FROM SALE 
WHERE SaleID = 8;

#Did the row in SALE_ITEM also delete? Why?
#yes. because its cascading.

