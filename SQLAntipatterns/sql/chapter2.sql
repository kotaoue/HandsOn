delete table if exists Products;


-- Recreate the table from Chapter 1
create table if not exists Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50)
);

desc Products;
select * from Products;
