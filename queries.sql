-- SQLite
-- SQLite


CREATE TABLE IF NOT EXISTS Users (
  user_id INTEGER PRIMARY KEY AUTOINCREMENT,
  Username varchar(50) not NULL,
  Password TEXT not NULL);


CREATE TABLE IF NOT EXISTS patients (
  ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Name VARCHAR(255) NOT NULL,
  Age INT NULL,
  Gender VARCHAR(10) NULL,
  ContactDetails VARCHAR(255) NULL,
  Address VARCHAR(255) NULL,
  MedicalHistory TEXT NULL
);

CREATE TABLE IF NOT EXISTS geographicaldata (
  Region VARCHAR(255) NOT NULL,
  District VARCHAR(255) NOT NULL,
  Locality VARCHAR(255) NOT NULL,
  PRIMARY KEY (Region, District, Locality)
);

CREATE TABLE IF NOT EXISTS covidaffectedpeople (
  PatientID INT NOT NULL,
  DateOfCOVIDDiagnosis DATE NULL,
  SeverityLevel VARCHAR(50) NULL,
  IsolationInformation TEXT NULL,
  PRIMARY KEY (PatientID),
  FOREIGN KEY (PatientID) REFERENCES patients (ID)
);

CREATE TABLE IF NOT EXISTS nonfataloutcomes (
  PatientID INT NOT NULL,
  DateOfRecovery DATE NULL,
  RecoveryStatus VARCHAR(50) NULL,
  PRIMARY KEY (PatientID),
  FOREIGN KEY (PatientID) REFERENCES patients (ID)
);

CREATE TABLE IF NOT EXISTS fatalities (
  PatientID INT NOT NULL,
  DateOfDeath DATE NULL,
  CauseOfDeath VARCHAR(255) NULL,
  HospitalWhereDeathOccurred INT NULL,
  PRIMARY KEY (PatientID),
  FOREIGN KEY (PatientID) REFERENCES patients (ID),
  FOREIGN KEY (HospitalWhereDeathOccurred) REFERENCES hospitals (ID)
);

CREATE TABLE IF NOT EXISTS hospitals (
  ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Name VARCHAR(255) NOT NULL,
  Location VARCHAR(255) NULL,
  ContactDetails VARCHAR(255) NULL,
  Capacity INT NULL,
  AvailableBeds INT NULL,
  MedicalStaffInformation TEXT NULL
);

CREATE TABLE IF NOT EXISTS tests (
  TestID INTEGER PRIMARY KEY AUTOINCREMENT,
  PatientID INT NULL,
  HospitalID INT NULL,
  TestType VARCHAR(50) NULL,
  TestDate DATE NULL,
  TestResult VARCHAR(50) NULL,
  FOREIGN KEY (PatientID) REFERENCES patients (ID),
  FOREIGN KEY (HospitalID) REFERENCES hospitals (ID)
);

CREATE TABLE IF NOT EXISTS vaccinationdata (
  PatientID INT NOT NULL,
  VaccinationDate DATE NULL,
  VaccineType VARCHAR(50) NULL,
  DoseInformation VARCHAR(255) NULL,
  PRIMARY KEY (PatientID),
  FOREIGN KEY (PatientID) REFERENCES patients (ID)
);







-- SQLite
INSERT INTO Users (Username, Password) VALUES 
('user1', 'password1'),
('user2', 'password2'),
('user3', 'password3'),
('user4', 'password4'),
('user5', 'password5');



INSERT INTO patients (Name, Age, Gender, ContactDetails, Address, MedicalHistory) VALUES 
('John Doe', 30, 'Male', '1234567890', '123 Main St', 'No significant medical history'),
('Jane Smith', 25, 'Female', '9876543210', '456 Elm St', 'Allergic to penicillin'),
('Mike Johnson', 45, 'Male', '5551234567', '789 Oak St', 'High blood pressure'),
('Emily Davis', 35, 'Female', '9998887776', '567 Pine St', 'Diabetic'),
('Michael Brown', 50, 'Male', '4443332221', '890 Maple St', 'Asthmatic'),
('Jessica Wilson', 28, 'Female', '1112223334', '678 Birch St', 'None'),
('William Taylor', 40, 'Male', '6667778885', '234 Cedar St', 'Hypertension'),
('Samantha Martinez', 32, 'Female', '5554443332', '901 Walnut St', 'Allergic to shellfish'),
('Christopher Anderson', 38, 'Male', '2223334443', '345 Oak St', 'None'),
('Ashley Garcia', 27, 'Female', '8889990008', '789 Pine St', 'None');


INSERT INTO geographicaldata (Region, District, Locality) VALUES 
('Region1', 'District1', 'Locality1'),
('Region2', 'District2', 'Locality2'),
('Region3', 'District3', 'Locality3'),
('Region4', 'District4', 'Locality4'),
('Region5', 'District5', 'Locality5'),
('Region6', 'District6', 'Locality6'),
('Region7', 'District7', 'Locality7'),
('Region8', 'District8', 'Locality8'),
('Region9', 'District9', 'Locality9'),
('Region10', 'District10', 'Locality10');



INSERT INTO covidaffectedpeople (PatientID, DateOfCOVIDDiagnosis, SeverityLevel, IsolationInformation) VALUES 
(1, '2022-01-01', 'Mild', 'Self-isolating at home'),
(2, '2022-02-15', 'Moderate', 'Hospitalized'),
(3, '2022-03-10', 'Severe', 'In ICU'),
(4, '2022-04-05', 'Mild', 'Self-isolating at home'),
(5, '2022-05-20', 'Moderate', 'Hospitalized'),
(6, '2022-06-15', 'Severe', 'In ICU'),
(7, '2022-07-10', 'Mild', 'Self-isolating at home'),
(8, '2022-08-25', 'Moderate', 'Hospitalized'),
(9, '2022-09-30', 'Severe', 'In ICU'),
(10, '2022-10-12', 'Mild', 'Self-isolating at home');




INSERT INTO nonfataloutcomes (PatientID, DateOfRecovery, RecoveryStatus) VALUES 
(1, '2022-01-21', 'Recovered'),
(2, '2022-03-05', 'Recovered'),
(3, '2022-04-01', 'Recovered'),
(4, '2022-05-10', 'Recovered'),
(5, '2022-06-25', 'Recovered'),
(6, '2022-07-20', 'Recovered'),
(7, '2022-08-15', 'Recovered'),
(8, '2022-09-05', 'Recovered'),
(9, '2022-10-20', 'Recovered'),
(10, '2022-11-15', 'Recovered');


INSERT INTO fatalities (PatientID, DateOfDeath, CauseOfDeath, HospitalWhereDeathOccurred) VALUES 
(1, '2022-01-25', 'Respiratory failure', NULL),
(2, '2022-03-20', 'Pneumonia', NULL),
(3, '2022-04-10', 'Heart failure', NULL),
(4, '2022-05-15', 'Sepsis', NULL),
(5, '2022-06-30', 'Stroke', NULL),
(6, '2022-07-25', 'Organ failure', NULL),
(7, '2022-08-20', 'Hemorrhage', NULL),
(8, '2022-09-15', 'Multiple organ dysfunction syndrome', NULL),
(9, '2022-10-30', 'Cardiac arrest', NULL),
(10, '2022-11-25', 'Renal failure', NULL);


INSERT INTO hospitals (Name, Location, ContactDetails, Capacity, AvailableBeds, MedicalStaffInformation) VALUES 
('Hospital1', 'Location1', '123-456-7890', 100, 50, 'Experienced medical staff available 24/7'),
('Hospital2', 'Location2', '987-654-3210', 150, 75, 'Specialized units for critical care patients'),
('Hospital3', 'Location3', '111-222-3333', 200, 100, 'State-of-the-art facilities for surgeries'),
('Hospital4', 'Location4', '444-555-6666', 120, 60, 'Emergency department equipped with trauma center'),
('Hospital5', 'Location5', '777-888-9999', 180, 90, 'Comprehensive cancer care center'),
('Hospital6', 'Location6', '222-333-4444', 130, 65, 'Advanced imaging and diagnostic services'),
('Hospital7', 'Location7', '555-666-7777', 170, 85, 'Neonatal intensive care unit for newborns'),
('Hospital8', 'Location8', '888-999-0000', 140, 70, 'Pediatric department with child-friendly environment'),
('Hospital9', 'Location9', '333-444-5555', 160, 80, 'Rehabilitation services for post-operative care'),
('Hospital10', 'Location10', '999-000-1111', 110, 55, 'Mental health support services available');





INSERT INTO tests (PatientID, HospitalID, TestType, TestDate, TestResult) VALUES 
(1, 1, 'PCR', '2022-01-05', 'Negative'),
(2, 2, 'Antigen', '2022-03-10', 'Positive'),
(3, 3, 'PCR', '2022-04-15', 'Negative'),
(4, 4, 'Antibody', '2022-06-20', 'Positive'),
(5, 5, 'PCR', '2022-07-25', 'Negative'),
(6, 6, 'Antigen', '2022-08-30', 'Positive'),
(7, 7, 'PCR', '2022-10-05', 'Negative'),
(8, 8, 'Antibody', '2022-11-10', 'Positive'),
(9, 9, 'PCR', '2022-12-15', 'Negative'),
(10, 10, 'Antigen', '2023-01-20', 'Positive');


INSERT INTO vaccinationdata (PatientID, VaccinationDate, VaccineType, DoseInformation) VALUES 
(1, '2022-01-10', 'Pfizer', 'First dose'),
(2, '2022-03-25', 'Moderna', 'Second dose'),
(3, '2022-05-01', 'Johnson & Johnson', 'Single dose'),
(4, '2022-06-30', 'AstraZeneca', 'Second dose'),
(5, '2022-08-05', 'Pfizer', 'First dose'),
(6, '2022-09-10', 'Moderna', 'Second dose'),
(7, '2022-10-15', 'Johnson & Johnson', 'Single dose'),
(8, '2022-11-20', 'AstraZeneca', 'Second dose'),
(9, '2022-12-25', 'Pfizer', 'First dose'),
(10, '2023-01-30', 'Moderna', 'Second dose');






