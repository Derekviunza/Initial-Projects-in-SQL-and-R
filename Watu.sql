-- Creating the tables

-- Loan Table
CREATE TABLE client (
  client_id INTEGER PRIMARY KEY,
  first_name TEXT NOT NULL,
  middle_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  date_of_birth DATE
);

INSERT INTO client VALUES (33, 'Susan', 'Mapenzi', 'Marigu', '1974-06-11');
INSERT INTO client VALUES (35, 'Paul', ' ', 'Pobga', '1993-03-15');
INSERT INTO client VALUES (36, 'Hafsa', 'Wangui', 'Munga', '1987-05-07');
INSERT INTO client VALUES (37, 'Everlyne', ' ', 'Matenge', '1973-02-27');
INSERT INTO client VALUES (38, 'Barack', ' ', 'Obama', '1961-08-04');
INSERT INTO client VALUES (39, 'Prudence', 'Salim', 'Okeyo', '1985-02-16');
INSERT INTO client VALUES (40, 'Rosemary', 'Pauline', 'Kinyua', '1977-01-27');
INSERT INTO client VALUES (42, 'Elizabeth', ' ', 'Mbaji', '1975-10-03');
INSERT INTO client VALUES (43, 'Johny', 'Paul', 'Orengo', '1971-07-29');
INSERT INTO client VALUES (44, 'Merceline', 'Lucy', 'Njenga', '1982-04-21');

-- Displaying the client table, we can use simple select  statement with an astrick
SELECT * FROM client;
-- create a loan table
CREATE TABLE loan (
  loan_id INTEGER,
  client_id INTEGER,
  vehicle_id INTEGER,
  principal_amount INTEGER,
  submitted_on_date DATE
);

INSERT INTO loan VALUES (75676, 40784, 24, 106500, '2019-05-02');
INSERT INTO loan VALUES (75659, 40760, 26, 108400, '2020-12-05');
INSERT INTO loan VALUES (75685, 40807, 27, 101500, '2019-05-02');
INSERT INTO loan VALUES (75657, 40796, 28, 271482, '2019-06-21');
INSERT INTO loan VALUES (75662, 40803, 29, 114400, '2019-05-02');
INSERT INTO loan VALUES (75660, 40737, 30, 95300, '2019-05-02');
INSERT INTO loan VALUES (75656, 40815, 31, 78500, '2019-05-02');
INSERT INTO loan VALUES (75666, 40834, 32, 111800, '2019-05-02');
INSERT INTO loan VALUES (75658, 40811, 33, 107050, '2019-05-02');
INSERT INTO loan VALUES (75663, 40840, 34, 101800, '2019-05-02');

-- Displaying the loan table, we can use simple select  statement with an astrick
SELECT * FROM loan;
-- create a table
CREATE TABLE vehicle (
  vehicle_id INTEGER,
  make TEXT NOT NULL,
  model_name TEXT
);

INSERT INTO vehicle VALUES (24, 'Haojin', 'HJ 150CC-11A');
INSERT INTO vehicle VALUES (26, 'Honda', 'Ace CB 125CC ES');
INSERT INTO vehicle VALUES (27, 'TVS', 'HLX 125CC ES');
INSERT INTO vehicle VALUES (29, 'TVS', 'HLX 150CC X');
INSERT INTO vehicle VALUES (30, 'TVS', 'HLX 100CC KS');
INSERT INTO vehicle VALUES (31, 'Haojin', 'HJ 125CC-A');
INSERT INTO vehicle VALUES (32, 'Boxer', 'BM 150CC (4)');
INSERT INTO vehicle VALUES (33, 'Ferrari', 'Enzo 6000CC');
INSERT INTO vehicle VALUES (34, 'Boxer', 'BM 150cc-2');
INSERT INTO vehicle VALUES (35, 'Boxer', 'BM 150cc-3');


-- Displaying the vehicle table, we can use simple select  statement with an astrick
SELECT * FROM vehicle;

-- Using the tables above, please write the SQL code that would answer each of the following questions (write the code below each of them).

-- Question 1 -- Select all the clients called Paul in first_name or middle_name and who are more than 25 years old.
   -- In the results, create a column with the client's age in years. 
   -- Order them from older to younger.
   -- Answer------------------------------
   SELECT *, TIMESTAMPDIFF(YEAR, date_of_birth,now()) AS Age
        FROM client
        WHERE first_name = 'Paul' or middle_name = 'Paul' 
        ORDER BY Age Desc;
    
-- Question Two
-- Add a column to the table from question (1) that contains the number of loans each customer made.
   -- If there is no loan, this column should show 0.
SELECT 
client.client_id, 
client.first_name, 
client.middle_name,
 client.last_name, 
 TIMESTAMPDIFF(YEAR, client.date_of_birth,now()) AS Age,
 loan.loan_id, loan.client_id, 
COUNT(distinct loan.loan_id) AS `number_of_loans_made` 
FROM client
	LEFT JOIN loan
	ON client.client_id = loan.client_id
    ;


-- 3. -- Select the 100cc, 125cc and 150cc bikes from the vehicle table.
   -- Add an engine_size column to the output (that contains the engine size).
   
SELECT *,model_name AS engine_size FROM vehicle
         WHERE model_name LIKE '%100cc%'
                OR model_name LIKE '%125cc%'
                OR model_name LIKE '%150cc%'; 
-- 4. -- Calculate the total principal_amount per client full name (one column that includes all the names for each client) and per vehicle make.
SELECT loan.principal_amount, vehicle.make,
 client.first_name OR ' ' OR client.middle_name OR ' ' OR client.last_name AS full_name 
	FROM client, loan, vehicle
	WHERE client.client_id = loan.client_id AND loan.vehicle_id = vehicle.vehicle_id;
-- 5. -- Select the loan table and add an extra column that shows the chronological loan order for each client based on the submitted_on_date column: 
   -- 1 if it's the client's first sale, 2 if it's the client's second sale etc.
   -- Call it loan_order
   SELECT *
	FROM loan join
	(SELECT MIN(submitted_on_date) as loan_order
	FROM loan
	GROUP BY date(submitted_on_date)
	  ) as first_sale
	ON loan.submitted_on_date = loan_order;

