-- Example Relational Database Schema

CREATE TABLE Table1 (
    e1_id INT PRIMARY KEY,
    e2 VARCHAR(255),
    e3 VARCHAR(255),
    e4 VARCHAR(255)
);

CREATE TABLE Table2 (
    e5 INT PRIMARY KEY,
    e2_id INT,
    e3 VARCHAR(255),
    FOREIGN KEY (e2_id) REFERENCES Table1(e1_id)
);