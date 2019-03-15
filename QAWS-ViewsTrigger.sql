#1
DROP VIEW IF EXISTS SaleSummaryView;
CREATE VIEW SaleSummaryView AS
      SELECT SALE.SaleID, SALE.SaleDate, SALE_ITEM.Quantity,
             ITEM.ItemDescription, SALE.Total
      FROM SALE 
      JOIN SALE_ITEM ON SALE.SaleID = SALE_ITEM.SaleID
      JOIN ITEM ON SALE_ITEM.SaleID = ITEM.ItemID;

#2
DROP VIEW IF EXISTS CustomerSaleSummaryView;
CREATE VIEW CustomerSaleSummaryView AS
      SELECT SALE.SaleID, SALE.SaleDate, PERSON.LastName,
			PERSON.FirstName, ITEM.ItemDescription,
		    ITEM.ItemPrice
      FROM PERSON 
      JOIN SALE ON PERSON.PersonID = SALE.CustomterPersonID 
      JOIN SALE_ITEM ON SALE.SaleID = SALE_ITEM.SaleID
      JOIN ITEM ON SALE_ITEM.SaleID = ITEM.ItemID
      ORDER BY SALE.SaleId;

#3
DROP TRIGGER IF EXISTS CreditCardExpCheck;
DELIMITER //
CREATE TRIGGER CreditCardExpCheck
	BEFORE INSERT ON CUSTOMER
FOR EACH ROW
BEGIN
  IF (NEW.CreditCardExpirationDate < CURDATE() ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT= 'Card is expired';
  END IF;
END;
//DELIMITER ;



#4
DROP PROCEDURE IF EXISTS InsertSale;
	DELIMITER //
	CREATE PROCEDURE InsertSale
		(IN newSaleID  INT,
		IN newCustomerPersonID INT,
		IN newEmployeePersonID INT,
		IN newQuantity INT,                  
		IN newItemPrice NUMERIC(9,2),        
		IN newExtendedPrice  NUMERIC(9,2),         
		IN newItemID  INT, 
		IN newSaleDate  DATE
		)
        
        
	BEGIN
    
    
		DECLARE varCountSale INT;
		DECLARE varCountSaleItem INT;
		DECLARE varSubTotal NUMERIC(9, 2);
		
        
		SELECT  COUNT(*) INTO varCountSale
		FROM  SALE
		WHERE SaleID = newSaleID;

	IF(varCountSale < 1) THEN
		INSERT INTO SALE (SaleID, SaleDate, SubTotal, Tax, Total, CustomterPersonID, EmployeePersonID)
		VALUES(newSaleID, newSaleDate, 0, 0 , 0, newCustomerPersonID, newEmployeePersonID);
	END IF;
	SELECT  COUNT(*) INTO varCountSaleItem
	FROM  SALE_ITEM
	WHERE SaleID = newSaleID;

	CALL InsertSaleItem(newSaleID, varCountSaleItem +1 , newQuantity, newItemPrice, newExtendedPrice,newItemID);
    
	SELECT SUM(ExtendedPrice) INTO varSubTotal
	FROM SALE_ITEM 
	WHERE SaleID = newSaleID;
    

    
	UPDATE SALE
	SET SubTotal = varSubTotal
	WHERE SaleID = newSaleID;
    
	UPDATE SALE
	SET Tax = 0.11 * varSubtotal
	WHERE SaleID = newSaleID;
    
	UPDATE SALE
	SET Total = varSubTotal + varTax
	WHERE SaleID = newSaleID;
	END;
	// 
DELIMITER ;



	DROP PROCEDURE IF EXISTS InsertSaleItem;
	DELIMITER //
	CREATE PROCEDURE InsertSaleItem
	(IN newSaleID INT,
	IN newSaleItemID INT,
	IN newQuantity INT,                  
	IN newItemPrice   NUMERIC(9,2),        
	IN newExtendedPrice  NUMERIC(9,2),         
	IN newItemID INT)
	BEGIN
	INSERT INTO SALE_ITEM
	(SaleID, SaleItemID, Quantity, ItemPrice, ExtendedPrice, ItemID)
	VALUES
	(newSaleID, newSaleItemID, newQuantity, newItemPrice, newExtendedPrice, newItemID);
	END;
	// 
DELIMITER ;

