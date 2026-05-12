drop table if exists BugProducts;
drop table if exists Products;

create table if not exists Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(1000),
    account_id BIGINT UNSIGNED,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
desc Products;

insert into Accounts (account_id, account_name) values (12, 'Acme Software');

insert into Products (product_id, product_name, account_id) values (DEFAULT, 'Visual TurboBuilder', 12);


select * from Products;


-- Recreate the table from Chapter 1
drop table if exists Products;

create table if not exists Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50)
);

create table if not exists BugProducts (
    bug_id BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (bug_id, product_id),
    FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

desc Products;
select * from Products;
desc BugProducts;
select * from BugProducts;
