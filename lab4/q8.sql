/*
Answer the following theoretical questions

a) How can you protect the credit card information in the database from hackers?
    To protect credit card data one can not use the approach of storing passwords where a one-way
    hash function can be used as for credit cards the data needs to be retrieved to enable future usage.

    There are, without going into too much detail a general flow that can be followed when storing
    sensetive information that should be able to be acquried in the future:

    Encrypt the sensetive data using a symmetrical crypto (like AES256) and a strong key.
    (This could essentially be enough already assuming that the server holding the key is not compromised when the credit card information is leaked)

    Furthermore, additional security can be added by using the user password as additional security, meaning the server can never reveal the information by the key alone (meaning a compromised key will still not reveal the user password)
    The key can then be co-created by using the user password (NOT THE STORED PASSWORD HASH) upon login.


b) Give three advantages of using stored procedures in the database (and thereby execute them on the server) instead of writing the same functions in the front-end of the system (in for example java-script on a web-page)

    1) Security. Some of the functions written as procedures could be easily modified if written with client-side JavaScript (Never trust the client).
    2) Perfomance. It reduces the amount of information that is sent and therefore enchances performance (especially for devices with slow connection speed). 
    3) Complexity. Using stored procedures one can do much more complex queries compared to what can be done in javascript without a lot of code and/or communication with the database to retreive such data
*/