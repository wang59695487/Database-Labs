
create table book
(
       bno int NOT NULL,
       title char(100) NOT NULL,
       author char(100) NOT NULL,
       year year(4) NOT NULL,
       press char(100) NOT NULL,
       price Double(10,2) NOT NULL,
       total int NOT NULL,
       stock int NOT NULL,
       PRIMARY KEY(bno)
);


create table card
(
       cno int NOT NULL,
       name char(25) NOT NULL,
       department char(100) NOT NULL,
       type enum('S','T') NOT NULL,
       PRIMARY KEY(cno)
);



create table borrow
(
       cno int NOT NULL,
       bno int NOT NULL,
       borrow_date date,
       return_date date,
       CONSTRAINT borrow_ID PRIMARY KEY (cno,bno),
       FOREIGN KEY (bno) REFERENCES book(bno) on delete cascade,
       FOREIGN KEY (cno) REFERENCES card(cno) on update cascade
       
);


INSERT INTO book (bno,title,author,YEAR,press,price,total,stock)
VALUES (1, 'Database System Concepts', 'Abraham', '2011','McGrawHill', 99.00, 5, 4),
       (2,'Modern Operating Systems','Andrew', '2009', 'Pearson',75.00,3,1), 
       (3,'Computer Network','Tanenbaum','2000','Pearson',58.00,4,3);

INSERT INTO book (bno,title,author,YEAR,press,price,total,stock)
VALUES (3, 'Solid State Physics', 'Ashcroft', '1976','Thomson Learning', 98.00, 2, 2);

INSERT INTO card (cno,name,department,type)
VALUES (1,'Jack','CS','T'),
       (2,'Lily','Art','S'), 
       (3,'John','CS','S'),
       (4,'Lucy','Physics','S'),
       (5,'Amy','Chemistry','T');


INSERT INTO card (cno,name,department,type)
VALUES (5,'Andrew','Math','K');

       
INSERT INTO borrow (cno,bno,borrow_date,return_date)
VALUES (1,1,'2018-1-1','2018-1-14'),
       (1,2,'2018-1-6','2018-1-10'),
       (2,2,'2018-2-3','2018-2-8'),
       (3,3,'2018-2-5','2018-3-1');

INSERT INTO borrow (cno,bno,borrow_date,return_date)
VALUES (5,2,'2019-3-28','2019-3-29');


ALTER TABLE book ADD CONSTRAINT book_no PRIMARY KEY(bno);

ALTER TABLE card ADD CONSTRAINT card_no PRIMARY KEY(cno);

ALTER TABLE card modify column type enum('S','T') NOT NULL;

ALTER TABLE borrow ADD CONSTRAINT book_no FOREIGN KEY(bno) REFERENCES book(bno) on delete cascade;
ALTER TABLE borrow ADD CONSTRAINT card_no FOREIGN KEY(cno) REFERENCES card(cno) on update cascade;

 delete from card where name = 'Lily';

#修改bno的名字；
update book set bno = 0003 where title = 'Computer Network';

ALTER TABLE borrow drop Foreign Key book_no;
ALTER TABLE borrow ADD CONSTRAINT book_no FOREIGN KEY(bno) REFERENCES book(bno) on delete cascade on update cascade;


DELIMITER $$
create trigger borrow_afterinsert AFTER INSERT on borrow for each row 
       begin
       declare msg char(200);
       if (new.bno not in (select bno from book)) then
            set msg = 'book does not exist';
            SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = msg;
       elseif (new.cno not in (select cno from card)) then
            set msg = 'card number does not exist';
            SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = msg;
       elseif (new.bno in (select bno from book where stock=0)) then
            set msg = 'Sorry,stock is empty';
            SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = msg;
       else 
            update book set stock = stock -1 where bno = new.bno;
       end if;
       end$$

DELIMITER ;

select * from book;

drop trigger borrow_afterinsert;

alter table borrow drop primary key;
























