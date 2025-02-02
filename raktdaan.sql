CREATE DATABASE RaktDaan;
USE RaktDaan;

-- Table for blood donors
CREATE TABLE Donors (
    donor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    phone_number BIGINT UNIQUE,
    email VARCHAR(50) UNIQUE,
    date_of_birth DATE,
    password VARCHAR(255),
    blood_group VARCHAR(5) NOT NULL
);

-- Table for blood recipients
CREATE TABLE Recipients (
    recipient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    phone_number BIGINT UNIQUE,
    email VARCHAR(50) UNIQUE,
    blood_group VARCHAR(5) NOT NULL
);

-- Table to track blood requests between donors and recipients
CREATE TABLE BloodRequests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    donor_id INT,
    recipient_id INT,
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (donor_id) REFERENCES Donors(donor_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES Recipients(recipient_id) ON DELETE CASCADE
);

-- Table for blood donation organizations
CREATE TABLE Organizations (
    org_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_number BIGINT,
    email VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50),
    address VARCHAR(255)
);

-- Table for blood donations by donors
CREATE TABLE Donations (
    donation_id INT AUTO_INCREMENT PRIMARY KEY,
    donor_id INT,
    certificate_number VARCHAR(10) UNIQUE,
    org_id INT,
    donation_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (donor_id) REFERENCES Donors(donor_id) ON DELETE CASCADE,
    FOREIGN KEY (org_id) REFERENCES Organizations(org_id) ON DELETE SET NULL
);

-- Table for blood donation camps
CREATE TABLE DonationCamps (
    camp_id INT AUTO_INCREMENT PRIMARY KEY,
    org_id INT,
    event_date DATE,
    event_time TIME,
    details VARCHAR(255),
    venue VARCHAR(255),
    organizer_name VARCHAR(50),
    FOREIGN KEY (org_id) REFERENCES Organizations(org_id) ON DELETE CASCADE
);

-- Table for blood inventory management (location-based)
CREATE TABLE BloodInventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    org_id INT,
    state VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    blood_type VARCHAR(5) NOT NULL,
    collection_date DATE DEFAULT CURRENT_DATE,
    quantity INT NOT NULL CHECK (quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (org_id) REFERENCES Organizations(org_id) ON DELETE CASCADE
);

-- Table for individual blood units (linked to BloodInventory)
CREATE TABLE BloodUnits (
    unit_id INT AUTO_INCREMENT PRIMARY KEY,
    inventory_id INT,
    blood_type VARCHAR(5) NOT NULL,
    collection_date DATE DEFAULT CURRENT_DATE,
    quantity INT CHECK (quantity >= 0),
    FOREIGN KEY (inventory_id) REFERENCES BloodInventory(inventory_id) ON DELETE CASCADE
);

-- Table for recipients receiving blood units
CREATE TABLE RecipientBlood (
    recipient_id INT,
    blood_unit_id INT,
    blood_group VARCHAR(5) NOT NULL,
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (recipient_id) REFERENCES Recipients(recipient_id) ON DELETE CASCADE,
    FOREIGN KEY (blood_unit_id) REFERENCES BloodUnits(unit_id) ON DELETE CASCADE
);
