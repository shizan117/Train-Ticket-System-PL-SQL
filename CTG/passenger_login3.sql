SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE TRIGGER UpdateStatusPassenger
AFTER UPDATE 
OF Passenger_active_status
ON Passenger
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Status of passengers has been updated');
END;
/

ACCEPT X char PROMPT "Passenger Name: ";
ACCEPT Y char PROMPT "Passenger Gender: ";
ACCEPT Z number PROMPT "Passenger Age: ";
ACCEPT A char PROMPT "Passenger NID: ";
ACCEPT W char PROMPT "Passenger Password: ";

CREATE OR REPLACE FUNCTION passenger_logins(Pnameee IN OUT char,Genderrr IN OUT char,Ageee IN OUT number,niddd IN OUT char,Passenger_Passworddd IN OUT char)
RETURN number
IS

    Pnamee varchar(20);
    Genderr varchar(10);
    Agee number;
    nidd varchar(11);
    Passenger_Passwordd varchar(32);

    previous_passenger number := 0;
    name_of_passenger varchar(20) := 'empty';

BEGIN

    Pnamee := '&X';
    Genderr := '&Y';
    Agee := &Z;
    nidd := '&A';
    Passenger_Passwordd := '&W';


    FOR R IN (SELECT * FROM Passenger WHERE Pname=Pnamee AND Gender=Genderr AND Age=Agee AND nid=nidd) LOOP
        previous_passenger := 1;
    END LOOP;

    IF (previous_passenger = 1) THEN
        UPDATE Passenger SET Passenger_active_status=0;
        UPDATE Passenger SET Passenger_active_status=1 WHERE Pname=Pnamee AND Gender=Genderr AND Age=Agee AND nid=nidd;
        
        Pnameee := Pnamee;
        Genderrr := Genderr;
        Ageee := Agee;
        niddd := nidd;
        Passenger_Passworddd := Passenger_Passwordd;

    END IF;

    return previous_passenger;

END;
/