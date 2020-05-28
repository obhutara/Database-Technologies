DROP PROCEDURE IF EXISTS addReservation;
DROP PROCEDURE IF EXISTS addPassenger;
DROP PROCEDURE IF EXISTS addContact;
DROP PROCEDURE IF EXISTS addPayment;

DELIMITER //
 
CREATE PROCEDURE addReservation(departure_airport_code varchar(3), arrival_airport_code varchar(3), schedule_year int, week int, day_of_week varchar(11), time_t time, number_of_passengers int, OUT output_reservation_nr int)
BEGIN
    DECLARE local_route_id int DEFAULT 0;
    DECLARE local_schedule_id int DEFAULT 0;
    DECLARE local_flight_no int DEFAULT 0;
    DECLARE local_booked_seats int DEFAULT 0;

    -- We get our route_id to help us find the flight
    SELECT route_id INTO local_route_id 
    FROM route_t 
    WHERE airport_from = departure_airport_code
    AND airport_to = arrival_airport_code
    AND schedule_year = route_year;

    IF local_route_id = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'There exist no flight for the given route, date and time';
    END IF;

    SELECT schedule_id INTO local_schedule_id
    FROM weekly_schedule
    WHERE local_route_id = weekly_schedule.route_id
    AND time_t = weekly_schedule.departure_time
    AND day_of_week = weekly_schedule.day_of_week;

    IF local_schedule_id = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'There exist no flight for the given route, date and time';
    END IF;

    SELECT flight_no, booked_seats INTO local_flight_no, local_booked_seats
    FROM flight
    WHERE local_schedule_id = flight.schedule_id
    AND week = flight.week_no;

    -- Add error checking here, for the number of seats
    IF number_of_passengers > calculateFreeSeats(local_flight_no) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'There are not enough seats available on the chosen flight';
    END IF;
    
    INSERT INTO reservation VALUES(NULL, number_of_passengers, local_flight_no);

    -- This simply assigns the last inserted id to the output variable in order for the frontend to retreive it.
    SET output_reservation_nr = LAST_INSERT_ID();

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE addPassenger(reservation_nr int, passport_number int, passenger_name varchar(30))
BEGIN
    DECLARE passengerExist int DEFAULT 0;
    DECLARE reservationExists int DEFAULT 0;
    DECLARE paymentMade int DEFAULT 0;

    -- Check if the reservation exists
    SELECT reservation_no INTO reservationExists 
    FROM reservation 
    WHERE reservation_no = reservation_nr;

    IF reservationExists = 0 THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The given reservation number does not exist';
    END IF;

    -- Check if the reservation has already been paid for, no further changes can be made.
    SELECT reservation_no INTO paymentMade 
    FROM transaction_t 
    WHERE reservation_no = reservation_nr;

    IF paymentMade != 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot add more passengers, reservation has already been paid for';
    END IF;

    -- Check if the passenger already exists in passenger table
    SELECT passport_id INTO passengerExist FROM passenger WHERE passport_number = passport_id;
    IF passengerExist = 0 THEN
        INSERT INTO passenger VALUES (passport_number, passenger_name);
    END IF;

    -- Add try catch here for errors like invalid reservation number, now it throws generic error.
    INSERT INTO reservation_passenger VALUES (reservation_nr, passport_number);
END //

DELIMITER ;


DELIMITER //
CREATE PROCEDURE addContact (reservation_nr int, passport_number int, email varchar(30), phone_number bigint(20))
BEGIN

    DECLARE reservationExists int DEFAULT 0;
    DECLARE passengerExists int DEFAULT 0;

    -- In order to do separate error messages, we first check if reservation exists and then if the passanger is registered to that reservation
    SELECT reservation_no INTO reservationExists 
    FROM reservation 
    WHERE reservation_no = reservation_nr;

    SELECT passport_id INTO passengerExists 
    FROM reservation_passenger 
    WHERE reservation_no = reservation_nr AND passport_id = passport_number;

    IF reservationExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The given reservation number does not exist';
    END IF;

    IF passengerExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The person is not a passenger of the reservation';
    END IF;

    -- If we get here, the passenger exists within the given reservation, we can add the contact.
    INSERT INTO contact VALUES (reservation_nr, passport_number, email, phone_number);

END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addPayment (reservation_nr int, cardholder_name varchar(60), credit_card_number bigint(20))
BEGIN

    DECLARE reservationExists int DEFAULT 0;
    DECLARE passengerExists int DEFAULT 0;
    DECLARE contactExists int DEFAULT 0;

    
    DECLARE reservedSeats int;
    DECLARE availableSeats int;

    DECLARE reservationSeatPrice int;

    -- Check if reservation exists
    SELECT reservation_no INTO reservationExists 
    FROM reservation 
    WHERE reservation_no = reservation_nr;

    IF reservationExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The given reservation number does not exist';
    END IF;

    -- Check if the reservation has a contact passanger, in order to proceed with payment
    SELECT passport_id INTO contactExists 
    FROM contact 
    WHERE reservation_no = reservation_nr;

    IF contactExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The reservation has no contact yet';
    END IF;

    -- Check if the number of reserved seats still exist
    -- The example adds more passangers then initially reserved seats?

    SELECT COUNT(*) INTO reservedSeats
    FROM reservation_passenger 
    WHERE reservation_no = reservation_nr;

    IF reservedSeats > calculateFreeSeats( (SELECT flight_no FROM reservation WHERE reservation_no = reservation_nr)) THEN
        DELETE FROM reservation WHERE reservation_no = reservation_nr;
        
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'There are not enough seats available on the flight anymore, deleting reservation';
    
    ELSE
    -- if we get here the payment is made and we want to add the credentials to the DB and also confirm the booking.
        INSERT INTO transaction_t VALUES (reservation_nr, credit_card_number, cardholder_name);

        -- We need to calculate the total price for the booking
        SET reservationSeatPrice = calculatePrice( (SELECT flight_no FROM reservation WHERE reservation_no = reservation_nr) );
        INSERT INTO booking VALUES (NULL, reservationSeatPrice*reservedSeats, reservation_nr);
        SELECT "Booking confirmed!" as "Message";
    END IF;
END //
DELIMITER ;         
