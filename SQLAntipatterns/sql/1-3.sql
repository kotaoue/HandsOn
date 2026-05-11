create table Accounts (
    account_id SERIAL PRIMARY KEY,
    account_name VARCHAR(20),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    email VARCHAR(100),
    password_hash CHAR(64),
    portrait_image BLOB,
    hourly_rate NUMERIC(9, 2)
);

create table BugStatus (
    status VARCHAR(20) PRIMARY KEY
);
