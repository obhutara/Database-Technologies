/*
        TDDD37 - Lab 4
    Filip Klang, filkl010
    Omkar Bhurta, omkbh878
*/


-- DROP TABLE IF EXISTS tableName
DROP TABLE IF EXISTS reservation_passenger;
DROP TABLE IF EXISTS booking_passenger;
DROP TABLE IF EXISTS booking;
DROP TABLE IF EXISTS transaction_t;
DROP TABLE IF EXISTS contact;
DROP TABLE IF EXISTS passenger;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS flight;
DROP TABLE IF EXISTS weekly_schedule;
DROP TABLE IF EXISTS day_week;
DROP TABLE IF EXISTS year_pricing;
DROP TABLE IF EXISTS route_t;
DROP TABLE IF EXISTS airport;



-- Question 2
CREATE TABLE airport (
	airport_code varchar(3) NOT NULL,
	airport_name varchar(30) NOT NULL,
    country varchar(30) NOT NULL,

    PRIMARY KEY(airport_code)
);

CREATE TABLE route_t (
    route_id int AUTO_INCREMENT,
    route_year int NOT NULL,
    airport_from varchar(3) NOT NULL,
    airport_to varchar(3) NOT NULL,
    route_price float NOT NULL,

    
    PRIMARY KEY (route_id, route_year),

    CONSTRAINT fk_airport_route_from 
        FOREIGN KEY (airport_from) 
        REFERENCES airport(airport_code)
        ON DELETE CASCADE,

    CONSTRAINT fk_airport_route_to 
        FOREIGN KEY (airport_to) 
        REFERENCES airport(airport_code)
        ON DELETE CASCADE
);


CREATE TABLE year_pricing (
    year_no int NOT NULL,
    profitfactor float NOT NULL
);

CREATE TABLE day_week (
    day_of_week varchar(10) NOT NULL,
    weekday_factor float NOT NULL,
    year_no int NOT NULL,

    PRIMARY KEY(day_of_week, year_no)
);


CREATE TABLE weekly_schedule (
    schedule_id int AUTO_INCREMENT PRIMARY KEY,
    departure_time time NOT NULL,
    schedule_year int NOT NULL,
    route_id int NOT NULL,
    day_of_week varchar(20) NOT NULL,

    CONSTRAINT fk_schedule_route
        FOREIGN KEY (route_id)
        REFERENCES route_t(route_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_day_of_week_weekday
        FOREIGN KEY (day_of_week)
        REFERENCES day_week(day_of_week)
);


CREATE TABLE flight (
    flight_no int AUTO_INCREMENT,
    booked_seats int NOT NULL DEFAULT 0,
    schedule_id int NOT NULL,
    week_no int NOT NULL,

    PRIMARY KEY(flight_no, week_no),

    CONSTRAINT fk_flight_schedule
        FOREIGN KEY (schedule_id)
        REFERENCES weekly_schedule(schedule_id)
);


CREATE TABLE reservation (
    reservation_no int AUTO_INCREMENT PRIMARY KEY,
    reserved_seat_count int NOT NULL,
    flight_no int NOT NULL,

    CONSTRAINT fk_reservation_flight_no
        FOREIGN KEY (flight_no)
        REFERENCES flight(flight_no)
);


CREATE TABLE passenger (
    passport_id int NOT NULL PRIMARY KEY,
    name varchar(60) NOT NULL
);

CREATE TABLE reservation_passenger (
    reservation_no INT,
    passport_id INT,

    PRIMARY KEY(reservation_no, passport_id),

    CONSTRAINT fk_reservation_passenger_reservation
        FOREIGN KEY (reservation_no)
        REFERENCES reservation(reservation_no)
        ON DELETE CASCADE,

    CONSTRAINT fk_reservation_passenger_passenger
        FOREIGN KEY (passport_id)
        REFERENCES passenger(passport_id)
);


CREATE TABLE contact (
    reservation_no int NOT NULL PRIMARY KEY,
    passport_id int NOT NULL,
    email varchar(30) NOT NULL,
    phone_no bigint NOT NULL,

    CONSTRAINT fk_contact_reservation
        FOREIGN KEY (reservation_no)
        REFERENCES reservation(reservation_no)
        ON DELETE CASCADE,

    CONSTRAINT fk_contact_passenger
        FOREIGN KEY (passport_id)
        REFERENCES passenger(passport_id)
        ON DELETE CASCADE
);


CREATE TABLE transaction_t (
    reservation_no int NOT NULL PRIMARY KEY,
    credit_card_no bigint NOT NULL,
    cardholder_name varchar(60) NOT NULL,

    CONSTRAINT fk_transaction_reservation
        FOREIGN KEY (reservation_no)
        REFERENCES reservation(reservation_no)
        ON DELETE CASCADE
);


CREATE TABLE booking (
    booking_no int AUTO_INCREMENT PRIMARY KEY,
    total_price float NOT NULL,
    reservation_no int NOT NULL,

    CONSTRAINT fk_booking_reservation
        FOREIGN KEY (reservation_no)
        REFERENCES reservation(reservation_no)
        ON DELETE CASCADE
);

CREATE TABLE booking_passenger (
    booking_no int NOT NULL,
    passport_id int NOT NULL,
    ticket_number int NOT NULL UNIQUE,

    PRIMARY KEY(booking_no, passport_id),

    CONSTRAINT fk_booking_passenger_booking
        FOREIGN KEY (booking_no) 
        REFERENCES booking(booking_no),

    CONSTRAINT fk_booking_passenger_passenger
        FOREIGN KEY (passport_id)
        REFERENCES passenger(passport_id)
);

