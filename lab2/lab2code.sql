mysql -u root -p //进入数据库
exit//退出
show databases;//展示数据库；
use database NO3170100186;//使用数据库

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
       CONSTRAINT borrow_ID PRIMARY KEY (cno,bno,borrow_date),
       FOREIGN KEY (bno) REFERENCES book(bno) on delete cascade,
       FOREIGN KEY (cno) REFERENCES card(cno) on update cascade
       
);


INSERT INTO book (bno,title,author,YEAR,press,price,total,stock)
VALUES (1, 'Database System Concepts', 'Abraham', '2011','McGrawHill', 99.00, 5, 4),
       (2,'Modern Operating Systems','Andrew', '2009', 'Pearson',75.00,3,1), 
       (3,'Computer Network','Tanenbaum','2000','Pearson',58.00,4,3);

INSERT INTO card (cno,name,department,type)
VALUES (1,'Jack','CS','T'),
       (2,'Lily','Art','S'), 
       (3,'John','CS','S'),
       (4,'Lucy','Physics','S'),
       (5,'Amy','Chemistry','T');
       
       
INSERT INTO borrow (cno,bno,borrow_date,return_date)
VALUES (1,1,'2018-1-1','2018-1-14'),
       (1,2,'2018-1-6','2018-1-10'),
       (2,2,'2018-2-3','2018-2-8'),
       (3,3,'2018-2-5','2018-3-1');

 select distinct title from book natural join borrow;
 //最大值

with max_stock(value) as
(select max(stock) from book)
select title,bno from book,max_stock
where book.stock=max_stock.value;

select max(stock) as max_stock from book;

select bno,title,stock from book t1
where t1.stock in (select max(t2.stock) as max_stock from book t2);

alter table book add column category char(100);
alter table book drop column category ;

//添加字段

alter table borrow change column Cno cno;
alter table table_test add index index_test1(name) ;
create index index_test2 on table_test(age)
drop index name on table_test ;

create view book_view as select bno,title,press,year,price from book;

update card
set type = 'T'
Where name = 'Lucy';

 delete from card where name = 'Amy';

 select count(*),department from card group by department;

 //9
 select * from book_view where press='Pearson';
 //10
 update book_view
 set year = '2011'
 Where title = 'Modern Operating Systems';


 //4.9

create table manager
(
 employee_name char(20) not null,
 manager_name  char(20) not null,
 primary key (employee_name) ,
 foreign key (manager_name) references manager on delete cascade);


 INSERT INTO manager(employee name, manager name)
 VALUES ('a','a1'),
 VALUES ('b','b1');
                                                                                                                                    