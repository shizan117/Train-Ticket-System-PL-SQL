SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT S number PROMPT "Ticket number to check in || 1 for Dhaka || 2 for Khulna || 3 for Chittagong: ";
ACCEPT B number PROMPT "Enter ticket number: ";

CREATE OR REPLACE PROCEDURE check_avilable_ticket
IS
    seat_noo number := &B;
    
    station_status number := &S;
    passenger_active_statuss number := 0;
    
BEGIN
    
    FOR R IN (SELECT * FROM Passenger WHERE Passenger_active_status=1) LOOP
        passenger_active_statuss := 1;
    END LOOP;

    IF (passenger_active_statuss = 1) THEN
        IF(station_status=1)THEN
            FOR R IN (SELECT Train.* FROM Train INNER JOIN Passenger ON Passenger.StID=Train.StID WHERE  Train.Seat_Left>seat_noo) LOOP
                DBMS_OUTPUT.PUT_LINE(R.Train_Name || ' Source: ' || R.Source || ' Destination: ' || R.Destination || ' Seat Left: ' || R.Seat_Left);
            END LOOP;
        ELSIF(station_status=2)THEN
            FOR R IN (SELECT Train.* FROM Train@site2 INNER JOIN Passenger@site2 ON Passenger.StID=Train.StID WHERE Passenger.Passenger_active_status=1 AND Train.Seat_Left>seat_noo) LOOP
                DBMS_OUTPUT.PUT_LINE(R.Train_Name || ' Source: ' || R.Source || ' Destination: ' || R.Destination || ' Seat Left: ' || R.Seat_Left);
            END LOOP;
        ELSIF(station_status=3)THEN
            FOR R IN (SELECT Train.* FROM Train@site3 INNER JOIN Passenger@site3 ON Passenger.StID=Train.StID WHERE Passenger.Passenger_active_status=1 AND Train.Seat_Left>seat_noo) LOOP
                DBMS_OUTPUT.PUT_LINE(R.Train_Name || ' Source: ' || R.Source || ' Destination: ' || R.Destination || ' Seat Left: ' || R.Seat_Left);
            END LOOP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('You must select a valid station');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('You must login first');    
    END IF;
END;
/

commit;
EXEC check_avilable_ticket;
 
