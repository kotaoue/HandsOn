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

create table if not exists BugStatus (
    status VARCHAR(20) PRIMARY KEY
);

create table if not exists Bugs (
    bug_id SERIAL PRIMARY KEY,
    data_reported DATE NOT NULL DEFAULT (CURRENT_DATE),
    summary VARCHAR(80),
    description VARCHAR(1000),
    resolution VARCHAR(1000),
    reported_by BIGINT UNSIGNED NOT NULL,
    assigned_to BIGINT UNSIGNED,
    verified_by BIGINT UNSIGNED,
    status VARCHAR(20),
    priority VARCHAR(20),
    hours NUMERIC(9, 2),
    FOREIGN KEY (reported_by) REFERENCES Accounts(account_id),
    FOREIGN KEY (assigned_to) REFERENCES Accounts(account_id),
    FOREIGN KEY (verified_by) REFERENCES Accounts(account_id),
    FOREIGN KEY (status) REFERENCES BugStatus(status)
);

show tables;
