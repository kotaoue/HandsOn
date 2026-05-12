delete table if exists Products;
create table if not exists Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(1000),
    account_id BIGINT UNSIGNED,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
desc Products;

insert into products (product_name, account_id) values (DEFAULT, 'Visual TurboBuilder', 12);

select * from Products;


-- Recreate the table from Chapter 1
create table if not exists Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50)
);

desc Products;
select * from Products;
