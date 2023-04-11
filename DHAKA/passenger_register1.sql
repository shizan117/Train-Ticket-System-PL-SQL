SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE TRIGGER InsertIntoPassenger 
AFTER INSERT 
ON Passenger
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('New Passenger has been added');
END;
/

ACCEPT X char PROMPT "Passenger Name: ";
ACCEPT Y char PROMPT "Passenger Gender: ";
ACCEPT Z number PROMPT "Passenger Age: ";
ACCEPT A char PROMPT "Passenger NID: ";
ACCEPT W char PROMPT "Passenger Password: ";

CREATE OR REPLACE FUNCTION passenger_register
RETURN number
IS

    Pnamee varchar(20);
    Genderr varchar(10);
    Agee number;
    nidd varchar(11);
    Passenger_Passwordd varchar(32);

    previous_passenger number := 0;
    passenger_new_id number := 0;
    St_iddd number := 0;
    Passenger_active_statusss number := 0;


BEGIN

    Pnamee := '&X';
    Genderr := '&Y';
    Agee := &Z;
    nidd := '&A';
    Passenger_Passwordd := '&W';

    FOR R IN (SELECT * FROM Passenger WHERE Pname=Pnamee AND nid=nidd AND Passenger_Password=Passenger_Passwordd) LOOP
        previous_passenger := 1;
    END LOOP;


    IF (previous_passenger = 0) THEN
        SELECT max(PID) into passenger_new_id FROM Passenger;
        passenger_new_id := passenger_new_id + 1;

        INSERT into Passenger values(passenger_new_id,Pnamee,Genderr,Agee,nidd,Passenger_Passwordd,St_iddd,Passenger_active_statusss);
        previous_passenger := 2;
    END IF;

    return previous_passenger;

END;
/

commit;