
create user 'A' @'localhost' identified by 'password';
create user 'B' @'localhost' identified by 'password';


create database db1;
GRANT ALL ON db1.* TO 'A' @'localhost' with grant option;

GRANT SELECT ON db1.book TO 'B' @'localhost';

GRANT SELECT ON db1.book_view TO 'B' @'localhost';

GRANT INSERT ON db1.book TO 'B' @'localhost';
revoke SELECT on db1.* from 'B' @'localhost';
revoke INSERT on db1.* from 'B' @'localhost';

revoke INSERT on db1.book from 'B' @'localhost';

flush privileges;

mysql -u A -ppassword;

mysql -u A -p

mysql -u B -p

use db1;

create table book
(
       bno char(4) NOT NULL,
       stock int NOT NULL,
       PRIMARY KEY(bno)
);

INSERT INTO book(bno,stock)
VALUES('0001',4);

SELECT * from book;

INSERT INTO book(bno,stock)
VALUES('0002',1);

SELECT * from book

SELECT * from book_view;

revoke INSERT on db1.* from 'B' @'localhost';


INSERT INTO book(bno,stock)
VALUES('0003',3);


create view book_view as select bno,stock from book;

show grants for 'B' @'localhost';
select * from mysql.user where user='A';
select * from mysql.user where user='B';