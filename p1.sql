-- Project 1 Phase 1
-- Trang Pham, Prudence Lam, Helen Le

--drop sequences 
drop sequence memberID_seq;
drop sequence numberID_seq;

--drop tables
drop table OtherArt;
drop table Pottery;
drop table TwoID;
drop table Artwork;
drop table Gallery;
drop table Building;
drop table Artist;
drop table Member;
drop table Participant;

-- create Participant table
create table Participant(
    emailAddress varchar2(50) primary key,
    firstName varchar2(25),
    lastName varchar2(25),
    phoneNumber number(10),
    city varchar(10),
    state varchar2(2),
    hasTicket char(1),
);

-- insert values into Participant
insert into Participant values ('gerrymatteo@gmail.com','Gerry','Matteo',9892718375,'Gaines','MI','Y');
insert into Participant values ('phyllisbeinart@gmail.com','Phyllis','Beinart',203-200-1053,'CT','N');
insert into Participant values ('nancyburroughs@gmail.com','Nancy','Burroughs',215-923-5571,'PA','N');
insert into Participant values ('blairgagnon@gmail.com','Blair','Gagnon',402-808-7567,'NE','N');
insert into Participant values ('bethjohnston@gmail.com','Beth','Johnston',276-415-9001,'VA','N');
insert into Participant values ('bethjohnston2@gmail.com','Beth','Johnston',901-221-9041,'TN','N');
insert into Participant values ('barbaraperrino@gmail.com','Barbara','Perrino',937-734-8719,'OH','Y');
insert into Participant values ('jrlynch@gmail.com','JR','Lynch',281-704-3001,'TX','N');
insert into Participant values ('rickcatallozzi@gmail.com','Rick','Catallozzi',847-476-3764,'IL','N');
insert into Participant values ('krzysztofmathews@gmail.com','Krzysztof','Mathews',801-358-8284,'UT','N');
insert into Participant values ('paulmurray@gmail.com','Paul','Murray',336-547-7655,'NC','Y');
insert into Participant values ('michaelgarr@gmail.com','Michael','Garr',916-718-1231,'CA','N');
insert into Participant values ('pamneal@gmail.com','Pam','Neal',903-490-3322,'TX','N');
insert into Participant values ('terryvan@gmail.com','Terry','Van',708-471-4643,'IL','Y');
insert into Participant values ('sharonsmith@gmail.com','Sharon','Smith',612-402-4537,'MN','N');
insert into Participant values ('lindacovington@gmail.com','Linda','Covington',757-783-5399,'VA','Y');
insert into Participant values ('joangarfinkel@gmail.com','Joan','Garfinkel',925-236-1640,'CA','N');
insert into Participant values ('gracejackson@gmail.com','Grace','Jackson',651-554-9257,'MN','N');
insert into Participant values ('michaelgarr@gmail.com','Michael','Garr',231-546-8120,'MI','N');
insert into Participant values ('catherinebates@gmail.com','Catherine','Bates',734-546-3516,'MI','N');

-- create Member table. this relationship is in an overlapping IsA from Participant
create table Member(
	emailAddress varchar2(50) primary key,
	memberID number(10) not null,
	yearJoined number(4) not null,
	constraint Member_email_FK Foreign Key (emailAddress) references Participant (emailAddress) on delete cascade, 
	constraint Member_memberId_UK Unique (memberID, yearJoined)	
);

-- create Member sequence
create sequence memberID_seq 
start with 1;

-- insert values into Member
insert into Member values('gerrymatteo@gmail.com',memberID_seq.nextval,2020);
insert into Member values('phyllisbeinart@gmail.com',memberID_seq.nextval,2019);
insert into Member values('nancyburroughs@gmail.com',memberID_seq.nextval,2016);
insert into Member values('blairgagnon@gmail.com',memberID_seq.nextval,2021);
insert into Member values('bethjohnston@gmail.com',memberID_seq.nextval,2020);

-- create Artist table
create table Artist(
	emailAddress varchar2(50) primary key,
	artEventCnt number(30),
	constraint Artist_email_FK Foreign Key (emailAddress) references Participant (emailAddress) on delete cascade 	
);

-- insert values into Artist
insert into Artist values('bethjohnston@gmail.com',2);
insert into Artist values('barbaraperrino@gmail.com',10);
insert into Artist values('jrlynch@gmail.com',5);
insert into Artist values('rickcatallozzi@gmail.com',20);
insert into Artist values('krzysztofmathews@gmail.com',12);

-- create Building table
create table Building(
	name varchar2(50) not null,
	street varchar2(25),
	city varchar2(25),
	state char(2),
	zipcode char(5),
	constraint Building_PK Primary Key (name)
);

-- insert values into Building
insert into Building values ('Smart World','4241 Palmer Road','Westerville','OH','43081');
insert into Building values ('Power Tower','4328 Lynn Street','Dochester','MA','02122');

-- create Gallery table
create table Gallery(
	name varchar2(30),
	maxCapacity number(30),
	buildingName varchar2(50),
	constraint Gallery_buildingName_FK Foreign Key (buildingName) references Building(name),
	constraint Gallery_Name_PK Primary Key (name, buildingName) 
);

-- insert values into Gallery
insert into Gallery values('Elizabeth',200,'Smart World');
insert into Gallery values('Ice Muse',150,'Smart World');
insert into Gallery values('Hollow Picture',300,'Smart World');
insert into Gallery values('Nature',250,'Power Tower');
insert into Gallery values('The Creative',240,'Power Tower');
insert into Gallery values('Love Gallery',80,'Power Tower');

-- create Artwork table
create table Artwork(
	numberID number (10) not null,
	title varchar2(100),
	price number (30),
	gallery varchar2(100),
	buildingName varchar2(50),  
	participantEmail varchar2(100),
	art_type varchar2(25),
	constraint Artwork_PK Primary Key (numberID),
	constraint Artwork_PartEmail_FK Foreign Key participantEmail references Participant(emailAddress),
    constraint Artwork_gallery_FK Foreign Key (gallery, buildingName) references Gallery(name, buildingName)
	constraint Artwork_Role Check (art_type in ('Pottery','OtherArt','TwoD')),
	constraint Artwork_UQ Unique (numberID, art_type);
	constraint Artwork_numberID Check (numberID < 1000)
);

-- create Artwork sequence
create sequence numberID_seq 
start with 1;

-- insert values into Artwork
insert into Artwork values(numberID_seq.nextval,'Fort Adams',100,'Elizabeth','Smart World','gerrymatteo@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Treed Mixed',100,'Ice Muse','Smart World','phyllisbeinart@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Farewell Bennys',85,'Ice Muse','Smart World','nancyburroughs@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Yorkshire',75,'Hollow Picture','Smart World','blairgagnon@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Pottery',300,'Hollow Picture','Smart World','bethjohnston@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Grapefruit & Pottery',300,'Elizabeth','Smart World','bethjohnston2@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Untitled',105,'Elizabeth','Smart World','barbaraperrino@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Peace Black & White',150,'Elizabeth','Smart World','jrlynch@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Tranquil Rain',185,'Ice Muse','Smart World','rickcatallozzi@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Gherr',100,'Ice Muse','Smart World','krzysztofmathews@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Sand Fog',300,'Nature','Power Tower','paulmurray@gmail.com','Pottery');
insert into Artwork values(numberID_seq.nextval,'Dolphins With Supertanker',250,'The Creative','Power Tower','michaelgarr@gmail.com','Pottery');
insert into Artwork values(numberID_seq.nextval,'Begonia',800,'Elizabeth','Smart World','pamneal@gmail.com','Pottery');
insert into Artwork values(numberID_seq.nextval,'Heusen Kitty',85,'The Creative','Power Tower','terryvan@gmail.com','Pottery');
insert into Artwork values(numberID_seq.nextval,'Pears & Grapes',300,'Nature','Power Tower','sharonsmith@gmail.com','OtherArt');
insert into Artwork values(numberID_seq.nextval,'Vase',95,'Nature','Power Tower','lindacovington@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Native American Spirits',79.95,'The Creative','Power Tower','joangarfinkel@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Creatures from Above',85,'Hollow Picture','Smart World','gracejackson@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Jenny Lake Grand Teton',250,'Love Gallery','Power Tower','michaelgarr@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Stoneware Jar and Spoon',85,'Love Gallery','Power Tower','catherinebates@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Two Cornered Boxen',75,'Ice Muse','Smart World','rickcatallozzi@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Red and Yellow Roses',300,'Hollow Picture','Smart World','krzysztofmathews@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Iris',350,'Ice Muse','Smart World','paulmurray@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'Drydock',250,'Nature','Power Tower','michaelgarr@gmail.com','TwoID');
insert into Artwork values(numberID_seq.nextval,'All That Sparkles Jewelry',90,'Ice Muse','Smart World','pamneal@gmail.com','OtherArt');

-- create twoD table
create table TwoD(
	numberID number(10) not null,
	medium varchar2(20) not null,
	art_type varchar2(25) default 'TwoD',
	constraint TwoD_PK Primary key (numberID),
	constraint TwoD_type check (art_type in ('TwoD')),
	constraint TwoD_numberID_FK Foreign Key (numberID,art_type) references Artwork(numberID,art_type) on delete cascade,
);

insert into TwoID values(1,'Oil on Canvas','TwoD');
insert into TwoID values(2,'Oil on Linen','TwoD');
insert into TwoID values(3,'Oil','TwoD');
insert into TwoID values(4,'Oil on Canvas','TwoD');
insert into TwoID values(5,'Oil','TwoD');
insert into TwoID values(6,'Acrylic','TwoD');
insert into TwoID values(7,'Acrylic','TwoD');
insert into TwoID values(8,'Graphite and Pastel','TwoD');
insert into TwoID values(9,'Oil','TwoD');
insert into TwoID values(10,'Oil and Cold Wax','TwoD');
insert into TwoID values(20,'Soft Pastel','TwoD');
insert into TwoID values(19,'Watercolor','TwoD');
insert into TwoID values(18,'Watercolor','TwoD');
insert into TwoID values(17,'Oil and Cold Wax','TwoD');
insert into TwoID values(16,'Pastel, Plein Air','TwoD');
insert into TwoID values(21,'Watercolor','TwoD');
insert into TwoID values(22,'Soft Pastel','TwoD');
insert into TwoID values(23,'Soft Pastel','TwoD');
insert into TwoID values(24,'Oil','TwoD');

-- create Pottery table
create table Pottery(
	numberID number(10) not null,
	clayBody varchar2(20) not null,
	art_type varchar(25) default 'Pottery',
	constraint Pottery_PK Primary key (numberID),
	constraint Pottery_type check (art_type in ('Pottery')),
	constraint Pottery_numberID_FK Foreign Key (numberID,art_type) references Artwork(numberID,art_type) on delete cascade
);

-- insert values into Pottery
insert into Pottery values(11,'Stoneware','Pottery');
insert into Pottery values(14,'Terra Cotta','Pottery');
insert into Pottery values(13,'Clay','Pottery');
insert into Pottery values(12,'Ceramics','Pottery');

-- create Others table
create table OtherArt(
	numberID number(10) not null,
	art_type varchar(25) default 'OtherArt',
	constraint OtherArt_PK Primary key (numberID),
	constraint OtherArt_type check (art_type in ('OtherArt')),
	constraint OtherArt_numberID_FK Foreign Key (numberID,art_type) references Artwork(numberID,art_type) on delete cascade
);

-- insert values into Others
insert into OtherArt values (25);
insert into OtherArt values (15);

-- create ParticipantList table
-- could be updated by a Trigger in the future
create table ParticipantList(
    emailAddress varchar2(50) not null,
	numberID number(10) not null, 
	rank number(2) not null,
	constraint PL_PK Primary Key (emailAddress,numberID),
	constraint PL_Email_FK Foreign Key emailAddress references Participant(emailAddress),
	constraint PL_Number_FK Foreign Key numberID references Artwork(numberID),
	constraint PL_UQ Unique (emailAddress, rank),
	constraint PL_Rank Check (rank >= 1 and rank <= 20)
);

/* This is a separate table to ensure 1 to 1 relationship between participant and artwork won
 * However, the winning table should be updated by a trigger, which will assign winner to artwork
 * with the person who ranked it the highest and has not already won something
*/
create table WinList(
	emailAddress varchar2(50) not null, 
	numberID number(10) not null, 
	constraint PL_PK Primary Key (emailAddress, numberID),
	constraint PL_Email_FK Foreign Key emailAddress references Participant(emailAddress),
	constraint PL_Number_FK Foreign Key numberID references Artwork(numberID),
);