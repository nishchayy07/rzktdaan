CREATE DATABASE RaktDaan;
USE RaktDaan;

CREATE TABLE Donors (
    donor_id INT PRIMARY KEY,
    name VARCHAR(50),
    phone_number BIGINT(10),
    email VARCHAR(50),
    date_of_birth DATE,
    password VARCHAR(50),
    blood_group VARCHAR(5)
);

CREATE TABLE Recipients (
    recipient_id INT PRIMARY KEY,
    name VARCHAR(50),
    phone_number BIGINT(10),
    email VARCHAR(50),
    blood_group VARCHAR(5)
);

-- Table to track blood requests between donors and recipients
CREATE TABLE BloodRequests (
    donor_id INT,
    recipient_id INT,
    FOREIGN KEY (donor_id) REFERENCES Donors(donor_id),
    FOREIGN KEY (recipient_id) REFERENCES Recipients(recipient_id)
);

-- Table to store information about blood donation organizations
CREATE TABLE Organizations (
    org_id INT PRIMARY KEY,
    contact_number BIGINT(10),
    email VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE Donations (
    donation_id INT PRIMARY KEY,
    donor_id INT,
    certificate_number BIGINT(4),
    name VARCHAR(50),
    phone_number BIGINT(10),
    email VARCHAR(50),
    date_of_birth DATE,
    blood_group VARCHAR(5),
    org_id INT,
    FOREIGN KEY (donor_id) REFERENCES Donors(donor_id),
    FOREIGN KEY (org_id) REFERENCES Organizations(org_id)
);

-- Table to store details about blood donation camps
CREATE TABLE DonationCamps (
    camp_id INT PRIMARY KEY,
    org_id INT,
    event_date DATE,
    event_time TIME,
    details VARCHAR(100),
    venue VARCHAR(100),
    organizer_name VARCHAR(50),
    FOREIGN KEY (org_id) REFERENCES Organizations(org_id)
);

-- Table to manage blood inventory
CREATE TABLE BloodInventory (
    inventory_id INT PRIMARY KEY,
    org_id INT,
    blood_type VARCHAR(5),
    collection_date DATE,
    quantity INT,
    FOREIGN KEY (org_id) REFERENCES Organizations(org_id)
);

CREATE TABLE BloodUnits (
    unit_id INT PRIMARY KEY,
    blood_type VARCHAR(5),
    collection_date DATE,
    quantity INT
);

CREATE TABLE RecipientBlood (
    recipient_id INT PRIMARY KEY,
    blood_unit_id INT,
    blood_group VARCHAR(5),
    email VARCHAR(50),
    name VARCHAR(50),
    phone_number BIGINT(10),
    FOREIGN KEY (recipient_id) REFERENCES Recipients(recipient_id),
    FOREIGN KEY (blood_unit_id) REFERENCES BloodUnits(unit_id)
);
