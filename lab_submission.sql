-- CREATE TRG_AFTER_UPDATE_ON_customers
CREATE TRIGGER TRG_AFTER_UPDATE_ON_customers
AFTER 
UPDATE 
	ON 
	customers FOR EACH ROW 
BEGIN 
	DELETE FROM stomeers_data_reminders
	WHERE  customer_id = OLD.customer_id;

	INSERT INTO customer_data_reminders (customer_id, reminder_text, created_at)
	VALUES
		(OLD.customer_id, 'Please fill in the missing address details.', NOW()),  
        (OLD.customer_id, 'Reminder: Update the phone number if changed.', NOW()),  
        (OLD.customer_id, 'Don’t forget to verify the email address.', NOW());  
	
END;
-- UPDATE part
UPDATE 
	`part`  
SET 
	`part_selling_buying_check`
WHERE 
	(part_sellingprice > part_buyingprice);  
