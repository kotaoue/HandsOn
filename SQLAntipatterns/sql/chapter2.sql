create table if not exists Accounts (
    account_id SERIAL PRIMARY KEY,
    account_name VARCHAR(20),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    email VARCHAR(100),
    password_hash CHAR(64),
    portrait_image BLOB,
    hourly_rate NUMERIC(9, 2)
);

create table if not exists Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(1000),
    account_id BIGINT UNSIGNED,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
desc Products;

insert into Accounts (account_id, account_name) values (12, 'Acme Software');
insert into Accounts (account_id, account_name) values (34, 'Globex Corporation');

insert into Products (product_id, product_name, account_id) values (DEFAULT, 'Visual TurboBuilder', 12);
select * from Products;

insert into Products (product_id, product_name, account_id) values (DEFAULT, 'Visual TurboBuilder Pro', '12,34');
select * from Products;

drop table if exists Products;
create table if not exists Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(1000),
    account_id BIGINT UNSIGNED
);
desc Products;

insert into Products (product_id, product_name, account_id) values (DEFAULT, 'Visual TurboBuilder Pro', '12,34');
select * from Products;
