SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT C char PROMPT "1 to login as seller || 2 to login as passenger || 3 to signup as passenger: ";

DECLARE
    E int := 0;
    D int := 0;
    seller_login_status int := 0;
    passenger_login_status int := 0;
    passenger_signup_status int := 0;

    status int := 0;
    newstatus int := 0;
    Seller_Name varchar(32);
    Password varchar(32);

    passenger_info number := 0;
    passenger_info_f number := 0;
    Pnamee varchar(20);
    Pnameee varchar(20);
    Genderr varchar(10);
    Agee number;
    nidd varchar(11);
    Passenger_Passwordd varchar(32);

    sellerLoginExp EXCEPTION;
    passengerLoginExp EXCEPTION;
    passengerSignupExp EXCEPTION;
    loginExp EXCEPTION;
BEGIN

    DBMS_OUTPUT.PUT_LINE('Select 1 for seller login');
    DBMS_OUTPUT.PUT_LINE('Select 2 for passenger login');
    DBMS_OUTPUT.PUT_LINE('Select 3 for passenger login');

    E := &C;

    IF (E = 1) THEN
        RAISE sellerLoginExp;
        --book_ticket;

    ELSIF (E = 2) THEN
        RAISE passengerLoginExp;

    ELSIF (E = 3) THEN
        RAISE passengerSignupExp;

    ELSE
        RAISE loginExp;
    END IF;

    EXCEPTION
        WHEN sellerLoginExp THEN
            Seller_Name := seller_logins(status);
            IF (status = 0) THEN
                DBMS_OUTPUT.PUT_LINE('Account not found');
            ELSIF (status = 1) THEN
                DBMS_OUTPUT.PUT_LINE('Invalid credentials');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Welcome '|| Seller_Name);
                seller_login_status := 1;
            END IF;

        WHEN passengerLoginExp THEN
            passenger_info := passenger_logins(Pnamee,Genderr,Agee,nidd,Passenger_Passwordd);
            IF (passenger_info = 0) THEN
                DBMS_OUTPUT.PUT_LINE('Account not found');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Welcome '|| Pnamee);
                passenger_login_status := 1;
            END IF;

        WHEN passengerSignupExp THEN
            passenger_info_f := passenger_register;
            IF (passenger_info_f = 0) THEN
                DBMS_OUTPUT.PUT_LINE('Account not found');
            ELSIF (passenger_info_f = 1) THEN
                DBMS_OUTPUT.PUT_LINE('Account already registered');
            ELSE
                DBMS_OUTPUT.PUT_LINE('You have been registered');
                passenger_signup_status := 1;
            END IF;

        WHEN loginExp THEN
            DBMS_OUTPUT.PUT_LINE('Please login to book ticket');


END;
/

commit;