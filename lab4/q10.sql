/******************************************************************************************
 Question 10, concurrency
 This is the second of two scripts that tests that the BryanAir database can handle concurrency.
 This script sets up a valid reservation and tries to pay for it in such a way that at most
 one such booking should be possible (or the plane will run out of seats). This script should
 be run in both terminals, in parallel.
**********************************************************************************************/
SELECT "Testing script for Question 10, Adds a booking, should be run in both terminals" as "Message";
SELECT "Adding a reservations and passengers" as "Message";
CALL addReservation("MIT","HOB",2010,1,"Monday","09:00:00",21,@a);
CALL addPassenger(@a,00000001,"Saruman");
CALL addPassenger(@a,00000002,"Orch1");
CALL addPassenger(@a,00000003,"Orch2");
CALL addPassenger(@a,00000004,"Orch3");
CALL addPassenger(@a,00000005,"Orch4");
CALL addPassenger(@a,00000006,"Orch5");
CALL addPassenger(@a,00000007,"Orch6");
CALL addPassenger(@a,00000008,"Orch7");
CALL addPassenger(@a,00000009,"Orch8");
CALL addPassenger(@a,00000010,"Orch9");
CALL addPassenger(@a,00000011,"Orch10");
CALL addPassenger(@a,00000012,"Orch11");
CALL addPassenger(@a,00000013,"Orch12");
CALL addPassenger(@a,00000014,"Orch13");
CALL addPassenger(@a,00000015,"Orch14");
CALL addPassenger(@a,00000016,"Orch15");
CALL addPassenger(@a,00000017,"Orch16");
CALL addPassenger(@a,00000018,"Orch17");
CALL addPassenger(@a,00000019,"Orch18");
CALL addPassenger(@a,00000020,"Orch19");
CALL addPassenger(@a,00000021,"Orch20");
CALL addContact(@a,00000001,"saruman@magic.mail",080667989);
SELECT SLEEP(5); 
SELECT booked_seats from flight where week_no = 1;
SELECT "Making payment, supposed to work for one session and be denied for the other" as "Message";
LOCK TABLES flight READ, reservation WRITE,contact WRITE, booking WRITE, transaction_t WRITE, year_pricing READ, route_t READ, day_week READ, weekly_schedule READ;
SELECT SLEEP(2);
CALL addPayment (@a, "Sauron",7878787878);
SELECT SLEEP(2);
UNLOCK TABLES;
SELECT "Nr of free seats on the flight (should be 19 if no overbooking occured, otherwise -2): " as "Message", 40 -(SELECT booked_seats from flight where week_no = 1) as "nr_of_free_seats";
COMMIT;

/*Question 10 a*/
/*
Overbooking did not occur when the test scripts were executed.
21 seats were booked through terminal 1, therefore when booking of
additional seats were attempted it failed to add more seat.
*/

/*Question 10 b*/
/*
If both the payment's are made in parallel and pass the check:
number_of_passengers > (calculateFreeSeats(flight_number))
then both payment's made will receive a return of available seats
and will be able to add a reservation causing a overbooking to
occur in theory.
*/

/*Question 10 c*/
/*
Using SELECT sleep(5); can achieve an overbooking when both the scripts
are running in parallel when the table locking and unlocking commands are not used.
*/

/*Question 10 d*/
/*
Using LOCK TABLES, as it will Lock all the tables on the server, access to any other table will be restricted until used by the first table. therefore, the first payment can be made and then UNLOCK TABLES command can be used before making the second payment. Read, write is used to specify the tables to be locked and commit is used at the end to finalise the changes.
*/

/*
Secondary Index:
BookingNumber and PassportId are used as foreign keys in the table Booking_Passenger which is able form a link between Passenger and Booking tables. The Ticket Number is used as a Secondary Index.
This can increase the speed of retrieval of the record whereas using the former fields would be slower.
*/
