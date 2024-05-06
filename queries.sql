-- SQLite
CREATE TABLE IF NOT EXISTS Patients (
    ID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Age INTEGER NOT NULL,
    Gender TEXT NOT NULL,
    ContactDetails TEXT NOT NULL,
    Address TEXT NOT NULL,
    MedicalHistory TEXT NOT NULL);
    


CREATE TABLE IF NOT EXISTS Hospitals (
HospitalID INTEGER PRIMARY KEY,
Name TEXT NOT NULL,
Location TEXT NOT NULL);



CREATE TABLE IF NOT EXISTS Tests (
TestID INTEGER PRIMARY KEY,
Name TEXT NOT NULL,
Description TEXT NOT NULL);


-- SQLite
CREATE TABLE IF NOT EXISTS Users (
Username TEXT PRIMARY KEY,
Password TEXT NOT NULL);


INSERT INTO Patients (Name, Age, Gender, ContactDetails, Address, MedicalHistory) VALUES
('John Doe', 45, 'Male', '123-456-7890', '123 Main St, City, Country', 'Hypertension, Diabetes'),
('Jane Smith', 30, 'Female', '456-789-0123', '456 Elm St, City, Country', 'None'),
('Michael Johnson', 55, 'Male', '789-012-3456', '789 Oak St, City, Country', 'Asthma'),
('Emily Davis', 25, 'Female', '012-345-6789', '012 Pine St, City, Country', 'None'),
('William Brown', 35, 'Male', '234-567-8901', '234 Maple St, City, Country', 'Heart Disease'),
('Sophia Wilson', 40, 'Female', '567-890-1234', '567 Cedar St, City, Country', 'None'),
('David Martinez', 50, 'Male', '890-123-4567', '890 Birch St, City, Country', 'Diabetes'),
('Olivia Anderson', 28, 'Female', '345-678-9012', '345 Spruce St, City, Country', 'None'),
('James Taylor', 60, 'Male', '678-901-2345', '678 Walnut St, City, Country', 'High Cholesterol'),
('Emma Garcia', 32, 'Female', '901-234-5678', '901 Oak St, City, Country', 'None');



INSERT INTO Hospitals (Name, Location) VALUES
('Hospital A', 'City A'),
('Hospital B', 'City B'),
('Hospital C', 'City C'),
('Hospital D', 'City D'),
('Hospital E', 'City E'),
('Hospital F', 'City F'),
('Hospital G', 'City G'),
('Hospital H', 'City H'),
('Hospital I', 'City I'),
('Hospital J', 'City J');


INSERT INTO Tests (Name, Description) VALUES
('Test A', 'Description A'),
('Test B', 'Description B'),
('Test C', 'Description C'),
('Test D', 'Description D'),
('Test E', 'Description E'),
('Test F', 'Description F'),
('Test G', 'Description G'),
('Test H', 'Description H'),
('Test I', 'Description I'),
('Test J', 'Description J');
