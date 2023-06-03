-- all small letters - keywords
-- camelCase - variable
-- get out of safe mode: Edit -> preferences -> SQL Editor -> Safe Updates (uncheck) -> (restart)

# DATABASE
create db  - create database dbName;
use db - use dbName;
!!! drop(del) db - drop database dbName;

# TABLE
create table - create table tableName (
                    colHeadName DATATYPE, -- colHeadName = variable, header for each column
                    colHeadName DATATYPE, -- datatype = type of data: int, decimal (max size, precision), date, varchar(text)
                    colHeadName DATATYPE -- last one has no comma
                );
!!! drop table - drop table tableName;
display entire table - select * from tableName; -- to query ALL data from table
rename table - rename table oldName to newName; -- rename table workers to employees

# COLUMNS
add a new column - alter table tableName
                   add colHeadName DATATYPE; -- add phone_no varchar(10)
rename column - alter table tableName
                rename col oldColHeadName to newColHeadName; -- rename phone_no to email
alter datatype for a col - alter table tableName
                           modify column colHeadName NEWDATATYPE; -- modify email varchar(50)
change position of col to specific location- alter table tableName
                                             modify colHeadName DATATYPE
                                             after preceedingColHeadName;
change position of col to the first col in table- alter table tableName
                                                  modify colHeadName DATATYPE
                                                  first;
!!! drop col - alter tableName
               drop column colHeadName; -- drop column email

# INSERT ROWS
insert 1 row into a table - insert into tableName
                            values(value1, value2, value3); -- for data corresponding to datatype
                            --eg: (123, "spongebob", "squarepants", 29.95, "2023-01-02")
insert multiple rows - insert into tableName
                       values (valUes corresponding to DATATYPE),
                              (valUes corresponding to DATATYPE),
                              (valUes corresponding to DATATYPE);
!!! WRONG WAY to insert row with missing/partial data - insert into tableName
                                                        values(value1, value2) -- 2 values inserted out of more, gives error
                                                        -- eg: (123, "spongebob", "squarepants"), 29.95 and "2023-01-02" not given
RIGHT WAY to insert data with missing/partial data - insert into tableName (colHeadName1, colHeadName2) -- specify what cols get the data i/p
                                                     values(value1, value2) -- give input to corressponding cols
                                                     -- the missing data parts gets NULL
                                                     -- (123, "spongebob", "squarepants") gives 123, spongebob, squarepants, NULL, NULL

# SELECT DATA FROM TABLE
to query ALL data from table - select * from tableName; -- display entire table
to get 1 col data from table - select colHeadName
                               from tableName;
to get multiple cols data from table - select colHeadName1, colHeadName2 -- select fname, lname
                                       from tableName;
can change order of cols - select colHeadName2, colHeadName1 -- select lname, fname
                           from tableName;
to select base on a condition - where - select * 
                                        from tableName
                                        where condition;
                                        -- condition eg: empid = 1, fname = 'spongebob', hrpay >= 20, hiredt <= "2023-01-03"
                                        -- empid != 1 # NOT comparision
                                        -- hiredt is NULL, hiredt is not NULL # is and is not for = & !=

# UPDATE AND DEL DATA FROM TABLE

update data (1 col) in table - update tableName
                              set colHeadName = value -- eg. hrpay = 30
                              where condition; -- if necessary, eg: empid = 6
update multiple data (2 cols or more) in table - update tableName
                                                 set colHeadName1 = value1, -- eg. hrpay = 30 -> 1
                                                 colHeadName2 = value2 -- eg. hiredt = "2023-01-07" -> 2
                                                 where condition;
set data to NULL - update tableName
                   set colHeadName = NULL -- eg. hiredt = NULL
                   where condition;
!!! to update ALL data in 1 col - update tableName
                                  set colHeadName = NULL; -- eg. pay = 30.60 -> makes th pay = 30.60 for ALL the rows
!!! delete ALL rows in table (no condition is used)- delete from tableName; -- headers will remain, all data in table will be deleted
delete specific rows in table (condition is used)- delete from tableName
                                                   where condition; -- eg: where empid = 6

# AUTO-COMMIT, COMMIT, ROLLBACK -- = auto-save, save, restore from last checkpoint -> in gaming nomenclature
AUTO-COMMIT set to on by default, whenever a transaction is executed, it is saved
turn off autocommit - set autocommit = off; -- allows to undo (damaging) changes, each transaction has to be saved manually
create safe point - commit; -- manual saving
rollback, restore transaction at savepoint - rollback;

# GET CURRENT DATE AND/OR TIME
create date - mydate date --variable type
create time - myTime time --variable type
create date-time - myDT datetime --variable type
create date stamp for event - insert into tableName
                              values(current_date()); -- use +/- to get DAYS after/before current date
create time stamp for event - insert into tableName
                              values(current_time()); -- use +/- to get SECONDS after/before current date
create date-time stamp for event - insert into tableName
                                   values(now());

# UNIQUE CONSTRAINT
-- ensures all values are unique, gives error is duplicate data is given for insertion
insert only unique data in a col when creating a table - colHeadName DATATYPE unique -- no 2 data items can be the same
                                                         --eg: if productName = shampoo exists, a new productName = shampoo cannot be inserted
implement unique AFTER the table has been created - alter table tableName
                                                    add contrstraint
                                                    unique(colHeadName);

# NOT NULL CONSTRAINT
-- when a new row is added, the value within a col cannot be NULL
-- gives error if NULL is given as input
when creating a table - colHeadName DATATYPE not NULL
when modifying existing col - alter table tableName
                              modify colHeadName DATATYPE not NULL;
                              -- eg: (104, 'cookie', NULL) - gives error, (104, 'cookie', 0) - is acceptable, 0 is a place holder val

# CHECK CONSTRAINT
-- limit what values can be placed in a col, gives error if the check condition is violated
using check in a new table - create table tableName (
                             colHeadName DATATYPE,
                             check (condition)  -- eg: check (hrPay >= 30.60)
                             );
give the check a var name - create table tableName (
                            colHeadName DATATYPE,
                            constraint checkConstraintName check (condition) -- check (condition) will be known as checkConstraintName
                            );
                            -- eg: constraint chkHrPay check (hrPay >= 30.60)
                            -- chkHrpay refers to the checking condition, can be dropped if needed
add check to existing table - alter table tableName
                              add constraint checkConstraintName check(condition);
delete check - alter table tableName
               drop check checkConstraintName;

# DEFAULT CONSTRAINT
-- when inserting new row, if val for a col is not specified, by default, a val can be added
using default when creating a new table - create table tableName(
                                          colHeadName DATATYPE default defaultValue -- price decimal (4,2) default 0.00
                                          );
add default to existing table - alter table tableName
                                alter colHeadName set default defaultValue; -- alter price set default 0.00
adding data where default values are implemented - insert into tableName (colHeadName1, colHeadName2) -- specify what cols get the data i/p
                                                   -- eg: insert into products (prodId, prodName)
                                                   values (valUes corresponding to DATATYPE), -- (104, "fork")
                                                          (valUes corresponding to DATATYPE); -- (105, "spoon")
                                                   -- price in eg. will be set to 0.00 through default
adding timestamp as default - create table tableName(
                              colHeadName DATATYPE,
                              colHeadName DATATYPE,
                              dtStamp datetime default now()
                              );

# PRIMARY KEY CONSTRAINT
-- applied to a col, val in col should be unique and NOT null
-- unique identifier, only 1 pri key per table, no duplicates, cannot be NULL
using pri key when creating a new table - create table tableName(
                                          colHeadName DATATYPE primary key -- this col is the identifying primary key
                                          -- eg: customerId Int primary key
                                          );
add pri key to existing table - alter table tableName
                                add constraint
                                primary key(colHeadName); -- eg: primary key(customerId)
auto populate and increment pri key - create table tableName(
                                      colHeadName DATATYPE primary key auto_increment -- can be applied to primary key only
                                      -- this value does not need to be inserted, auto increments by 1
                                      -- eg: customerId int primary key auto_increment
                                      );
make pri key atart at a specific no, n - alter table tableName
                                         auto_increment = n; -- eg: auto_increment = 1000;

# FOREIGN KEY CONSTRAINT
-- foreign key is the pri key of another table used to establish link between the 2 tables
-- prevents actions that would destroy the link between 2 tables linked through foreign key
-- not all rows have foreign key, not all rows from table 2 are linked to table 1 through foreign key
-- eg: not all customers have customerId, not all customers with customerId have made purchases
create a link between 2 tables through foreign key - create table tableName1( -- create table transactions
                                                     colHeadNamePKeyT1 DATATYPE primary key auto_increment, -- eg: transactionId int primary key auto_increment
                                                     colHeadNameFKeyT1 DATATYPE, -- eg: customerId1 int
                                                     foreign key (colHeadNameFKeyT1) references tableName2 (colHeadNamePKeyT2)
                                                     -- eg: foreign key (customerId1) references customers (customerId2)
                                                     );
                                                     create table tableName2( -- create table customers
                                                     colHeadNamePKeyT2 DATATYPE primary key auto_increment -- eg: customerId2 int primary key auto_increment
                                                     );
drop foreign key - alter table tableName
                   drop foreign key colHeadName; -- eg: drop foreign key customerId;
give foreign key unique name - alter table tableName1
                               add constraint newConstraintName
                               foreign key (colHeadNameFKeyT1) references tableName2 (colHeadNamePKeyT2);

# JOIN -- inner(A AND B), left(A), right(B)
-- a clause used to combine rows 2 or more tables based on a related col between them, such as a foreign key
inner joint 2 tables - select *
                       from leftTable inner join rightTable -- from transactions inner join customers
                       on leftTable.foreignKeyCol = rightTable.priKeyCol; -- on transactions.cutomerId = customers.customerId;
                       -- select all rows on the 2 tables with matching customerId
display only required cols from inner join - select colHeadName1, colHeadName2, ... -- eg: select transactionId, amount, fName, lName
left join - select *
            from leftTable left join rightTable
            on leftTable.foreignKeyCol = rightTable.priKeyCol;
            -- pulls in all relevant data from leftTable, even if there is no matching data in rightTable
right left join - select *
                  from leftTable right join rightTable
                  on leftTable.foreignKeyCol = rightTable.priKeyCol;
                  -- pulls in all relevant data from rightTable, even if there is no matching data in leftTable

# FUNCTIONS
count, -- count the number of relevant rows
       select count(colHeadName) from tableName;
eg: count(amount) from transactions;
       can use alias with as, eg:  count(amount) as "today's transactions" from transactions;
min, -- get min, select min(colHeadName) from tableName;
       eg: min(amount) from transactions;
       with alias: count(amount) as minAmt from transactions;
max, -- get max, select max(colHeadName) from tableName;
       eg: max(amount) from transactions;
       with alias: count(amount) as maxAmt from transactions;
avg, -- get avg, select avg(colHeadName) from tableName;
       eg: avg(amount) from transactions;
       with alias: count(amount) as avgAmt from transactions;
sum, -- get sum, select sum(colHeadName) from tableName;
       eg: sum(amount) from transactions;
       with alias: count(amount) as sumAmt from transactions;
concat, -- concatenate 2 cols
       select concat(colHeadName1, colHeadName2) as aliasName from tableName;
       select concat(fName, lName) as fullName from employees;

# LOGICAL OPERATORS -- and, or, not, between, in
-- used with where clause
and - where condition1 and condition2
or - where condition1 or condition2
not - where not condition
between - where colHeadName between condition1 and condition2
in - find values within a set - where colheadName in (set);

# WILD CARD CHARACTERS - % _
% - used for %{char} or {char}%, returns all rows where the col matches
       eg: where colHeadName like %s -> awds, sees, qwetys -> endswith
       where colHeadName like s% -> awds,sqwerty, sass -> startswith

_ - used for any possible char in place of _ followed or preceeded by specific char.s
       where colHeadName like _s -> as,bs,cs,ds
       where colHeadName like s_ -> sa,sb,sc,sd
       where colHeadName like _s_ -> asb, csd
       where colHeadName like 19_3 -> 1903, 1923, 1993 -> dates
       where colHeadName like 20__-01-__ -> 2001-01-01, 2009-03-21, 2022-01-11

can combine _ and % -> _{char}% or %{char}_
-- eg: _a% -> manager, cashier, janitor

# ORDERING -- order by acs desc
ascending order - order by colheadName; = order by colHeadName asc;
descending order - order by colHeadName desc

# LIMIT
-- limit the no. of rec.s queried
-- used when working with a lot of data
-- used to display large no. of data on pages (pagination)
defualt limit selector - no. of rows displayed in current arranged format - select * from tablename
                                                                            limit n;
order then limit - order by colHeadName limit n;
              OR   order by colHeadName desc limit n;

offset - limit offset, n;

# UNIONS
combines the results of 2 or more select
union - select colHeadName1, colHeadName2 from tableName1
        union -- no duplicates
        select colHeadName, colHeadName2 from tableName2;

union all - select colHeadName1, colHeadName2 from tableName1
            union all -- allows duplicates
            select colHeadName, colHeadName2 from tableName2;

# SELF JOINS
join a copy of the table to itself, compare rows of the same table, helps to display heirarchy of data
inner join table to itself - select * -- select all(*) or required cols with alias1.colHeadNameM and alias2.colHeadNameN
                             from tableName as alias1 -- original
                             inner join tableName as alias2 -- copy
                             on alias1.colHeadName2 = alias2.colHeadName1;

# VIEWS
virtual table, not a real table, can behave and be interacted with as if it was real table
create view of table - create view viewName as
                       select colHeadName1, colHeadName2
                       from tableName;
view the view - select * from viewName;
drop view - drop view viewName;

# INDEXES (somehow not indices) -- Binary Search Tree
type of data structure, finds val in specific col faster
better than searching sequentially, updating takes longer time
show index of table - show indexes from tableName;
create index - create index idxName
               on tableName(colHeadName);
drop idx - alter table tableName
           drop index idxName;
multi col idx - create index idxName
                on tableName(colHeadName1, colHeadName2); -- list the col.s in order, the order is important
                -- mySQL has left-most prefix, eg: lName, fName
search by multi col idx - select * from tableName
                          where colHeadName1 = value and colHeadName2 = value;

# SUBQUERIES
a query within a query
outter query (inner query)

# DISTINCT
prevents repeats - select distinct colHeadName
                   from tableName
                   where condition;

# GROUP BY
aggregate all rows by a specific col - group by colHeadName;
often used with sum, min, max, avg, count - select sum/min/max/avg/count(colHeadName1),colHeadName2
                                            from tableName
                                            group by colHeadName2;
group by - having -> to use where AFTER group by - select sum/min/max/avg/count(colHeadName1),colHeadName2
                                                   from tableName
                                                   group by colHeadName2
                                                   having codition(s);


# ROLLUP
extention of group by, super-aggregate v alues, like grand total
using rollup - select sum/min/max/avg/count(colHeadName1),colHeadName2
               from tableName
               group by colHeadName2 with rollup;
# ON DELETE
on del set null - if foreign key is del, replace with null
on del cascade - if foreign key is del, del row 

odsn when creating table - create table tableName(
                           -- variables
                           -- foregin keys
                           on delete set null
                           );
add odsn / odc constraint when updating existing table - alter table tableName drop foreign key foreighnKeyName; -- drop existing foreign key
                                                         alter table tableName1
                                                         add constraint constraintName
                                                         foreign key (colHeadName1) references tableName2(colHeadName2) -- recreate the foreign key
                                                         on delete set null/cascade; -- and set the constraint

# STORED PROCEDURES - sp
prepared sql code that can be saved, like a macro
needs delimeter to be changed
creating sp - delimiter // -- change delimiter to //
              create procedure procedureName (in inputParameterName datatype) -- in is optional,
              -- depending on requirements, () if no input required, may need more
              -- same as a function in python, c++, etc.
              begin
                     statements -- macro statements
              end // -- use // to end the sp statements
              delimiter ; -- change delimiter back to ;
invoke sp - call procedureName(); -- give input in () if required
drop sp - drop procedure procedureName;

# TRIGGERS
when an event occurs, do something (insert, update, delete) -> event
checks data, handle errors, audit tables
create new trigger - create trigger triggerName
                     (before, after) (insert, update, delete) on tableName1
                     for each row -- or other parameters
                     update tableName2 -- if necessary for trigger change on another table
                     set action(s) on trigger -- eg: new.salary = (new.hrPay * 2080);
                     where condition; -- if necessary
display triggers - show triggers;