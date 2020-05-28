

       1. Please fix the cardinality of the relationship 'weeklySchedule' and 'flight'
           - Fixed.

       2. The 'Ticket no' can't be an attribute of 'Passenger' directly, because one passenger could have many tickets. Please rethink how would you store ticket_no. After fixing this issue, please update the primary key of 'passenger'
           - This fix is related to the join table made while fixing the RM model and it's many-to-many relationship display. Now Ticket Number is a part of the join table between a passenger and a booking. This
             makes it unique to each booking allowing a passanger to have multiple tickets in multiple flights.

       3. One booking has only one 'contact', and this contact must be one of the passengers in this booking. Please rethink relations related to 'contact'
           - The contact table directly related to passenger is gone, this is now represented by having email and phone number directly in the booking, as well as a link to what passenger is the contact. (Linking a passport ID to a passanegr in a one-to-one relationship)

       4. The primary key of Weekday should be (Day_of_week, year), remember to update the RM correspondingly
           - The key has been updated.

       5. In RM, regarding the relation between 'passenger' and 'booking', please check how to map an M: N relation in Relation model in the course slides (topic 5)
          - A join table was created where the M:N relationship is linked with two foreign keys. The Passport ID and Booking number.
