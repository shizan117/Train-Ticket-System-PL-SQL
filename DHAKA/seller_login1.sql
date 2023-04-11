SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE TRIGGER UpdateStatusSeller
AFTER UPDATE 
OF Seller_active_status
ON seller
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Status of sellers has been updated');
END;
/

CREATE OR REPLACE FUNCTION seller_logins(D IN OUT int)
RETURN varchar
IS

    A varchar(32);
    B varchar(32);

BEGIN

    A := '&Seller_Name';
    B := '&Seller_Password';
    D := 0;
    FOR R IN (SELECT * FROM seller WHERE Seller_name=A) LOOP
        D := 1;
    END LOOP;

    FOR R IN (SELECT * FROM seller WHERE Seller_name=A AND Seller_Password=B) LOOP
        D := 2;
        UPDATE seller SET Seller_active_status=0;
        UPDATE seller SET Seller_active_status=1 WHERE Seller_name=A AND Seller_Password=B;
    END LOOP;

    return A;

END;
/

commit;