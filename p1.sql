--drop sequences (TODO)

--drop table (TODO)

create table Participant(
    email varchar2(50),
    firstName varchar2(25),
    lastName varchar2(25),
    phoneNumber number(10),
    city varchar(10),
    state varchar2(2),
    hasTicket char(1)
    constraint Participant_email Primary Key (email)
);
