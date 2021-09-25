--drop sequences (TODO)
drop sequence artwork_seq;

--drop table
drop table OtherArt;
drop table Pottery;
drop table TwoID;
drop table Artwork;
drop table Gallery;
drop table Building;
drop table Artist;
drop table Member;
drop table Participant;

create table Participant(
    emailAddress varchar2(50) primary key,
    firstName varchar2(25),
    lastName varchar2(25),
    phoneNumber number(10),
    city varchar(10),
    state varchar2(2),
    hasTicket char(1),
);

create table Member(
	emailAddress varchar2(50) primary key,
	memberID number(10) not null,
	yearJoined number(4) not null,
	constraint Member_email_FK Foreign Key (emailAddress) references Participant (emailAddress) on delete cascade, 
	constraint Member_memberId_UK Unique (memberID, yearJoined)	
);

create table Artist(
	emailAddress varchar2(50) primary key,
	artEventCnt number(30),
	constraint Artist_email_FK Foreign Key (emailAddress) references Participant (emailAddress) on delete cascade 	
);

create table Building(
	name varchar2(50) not null,
	street varchar2(25),
	city varchar2(25),
	state char(2),
	zipcode char(5),
	constraint Building_PK Primary Key (name)
);

create table Gallery(
	name varchar2(30),
	maxCapacity number(30),
	buildingName varchar2(50),
	constraint Gallery_buildingName_FK Foreign Key (buildingName) references Building(name),
	constraint Gallery_Name_PK Primary Key (name, buildingName) 
);

create table Artwork(
	numberID number (10) not null,
	title varchar2(100),
	price number (30),
	gallery varchar2(100),
	buildingName varchar2(50),  
	participantEmail varchar2(100),
	art_type varchar2(25),
	constraint Artwork_PK Primary Key (numberID),
	constraint Artwork_PartEmail_FK Foreign Key (participantEmail) references Participant(emailAddress),
    constraint Artwork_gallery_FK Foreign Key (gallery, buildingName) references Gallery(name, buildingName)
	constraint Artwork_Role Check (art_type in ('Pottery','OtherArt','TwoD')),
	constraint Artwork_UQ Unique (numberID, art_type);
	constraint Artwork_numberID Check (numberID < 1000)
);

-- Create Artwork sequence
create sequence artwork_seq 
start with 1;

create table TwoD(
	numberID number(10) not null,
	medium varchar2(20) not null,
	art_type varchar2(25) default 'TwoD',
	constraint TwoD_PK Primary key (numberID),
	constraint TwoD_type check (art_type in ('TwoD')),
	constraint TwoD_numberID_FK Foreign Key (numberID,art_type) references Artwork(numberID,art_type) on delete cascade,
);

create table Pottery(
	numberID number(10) not null,
	clayBody varchar2(20) not null,
	art_type varchar(25) default 'Pottery',
	constraint Pottery_PK Primary key (numberID),
	constraint Pottery_type check (art_type in ('Pottery')),
	constraint Pottery_numberID_FK Foreign Key (numberID,art_type) references Artwork(numberID,art_type) on delete cascade
);

create table OtherArt(
	numberID number(10) not null,
	art_type varchar(25) default 'OtherArt',
	constraint OtherArt_PK Primary key (numberID),
	constraint OtherArt_type check (art_type in ('OtherArt')),
	constraint OtherArt_numberID_FK Foreign Key (numberID,art_type) references Artwork(numberID,art_type) on delete cascade
);
