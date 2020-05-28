/*
    Open two MySQL sessions. We call one of them A and the other one B. Write START TRANSACTION; in both terminals

    a) In session A, add a new reservation
        Done (However, used year_pricing instead, easier to do from command line).
    
    b) Is this reservation visible in session B? Why? Why not? 
        SELECT * FROM year_pricing; @Terminal 2 => "The transaction is not visible because it has not yet been commited by @Terminal 1"

    c) What happens if you try to modify the reservation from A in B? Explain what happens and why this happens and how this relates to the concept of isolation of transactions.
        If @Terminal 1 starts a transaction and executes addYear(parameters) without commiting while @Terminal 2 executes "UPDATE year_pricing SET profitfactor=4" it will hold @Terminal 2 until @Terminal 1 is done with its transaction (unlocks) by either commiting or rolling back
        This ensures data completeness and assures that no dirty-reads/modifications are made.

*/