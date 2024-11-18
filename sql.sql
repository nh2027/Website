-- Create the database
CREATE DATABASE `Heriot_Watt_Clubs`;

-- Use the database
USE `Heriot_Watt_Clubs`;

-- Create the User table
CREATE TABLE `User` (
    IDNumber INT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Password VARCHAR(30) NOT NULL,
    isAdmin INT NOT NULL DEFAULT 0
);

-- Create the Club table without ClubType
CREATE TABLE `Club` (
    ClubName VARCHAR(30) PRIMARY KEY,
    MemberCount INT NOT NULL DEFAULT 0,
    MaxCapacity INT NOT NULL DEFAULT 20,
    hasPresident INT NOT NULL DEFAULT 0,
    hasVicePresident INT NOT NULL DEFAULT 0
);

-- Create the User_Club table with foreign key constraints
CREATE TABLE `User_Club` (
    IDNumber INT,
    ClubName VARCHAR(30),
    isPresident INT DEFAULT 0,
    isVicePresident INT DEFAULT 0,
    PRIMARY KEY (IDNumber, ClubName),
    CONSTRAINT fk_user FOREIGN KEY (IDNumber) REFERENCES `User`(IDNumber) ON DELETE CASCADE,
    CONSTRAINT fk_club FOREIGN KEY (ClubName) REFERENCES `Club`(ClubName) ON DELETE CASCADE
);

-- Create the Timetable table with foreign key constraint
CREATE TABLE `Timetable` (
    ClubName VARCHAR(30),
    Day ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    Time ENUM('15:00', '16:00', '17:00') NOT NULL,
    CONSTRAINT unique_club_day_time UNIQUE (ClubName, Day, Time),
    CONSTRAINT fk_club_timetable FOREIGN KEY (ClubName) REFERENCES `Club`(ClubName) ON DELETE CASCADE
);

-- Insert values into User table (all 65 users)
INSERT INTO `User` (IDNumber, Name, Password, isAdmin) VALUES
(198240, 'John Smith', 'John2024!', 0),
(672345, 'Maria Garcia', 'Maria@3456', 0),
(324567, 'Ahmed Khan', 'Ahmed1234#', 0),
(413290, 'Liu Wei', 'Liu*5678', 0),
(719283, 'Emma Johnson', 'EmmaJ@2024', 0),
(361987, 'Santiago Rodriguez', 'Santi_88#', 0),
(625789, 'Aisha Malik', 'Aisha456!', 0),
(547891, 'James Lee', 'James2020$', 0),
(210987, 'Nina Petrova', 'NinaP#2024', 0),
(634512, 'David Kim', 'David88@!', 0),
(759231, 'Laura Thompson', 'Laura!555', 0),
(785123, 'Carlos Santos', 'Carlos@999', 0),
(450987, 'Fatima Yildirim', 'Fatima2023$', 0),
(903214, 'Oliver Zhang', 'Oliver_Z123', 0),
(234678, 'Ravi Patel', 'Ravi#2023', 0),
(129876, 'Sophia Brown', 'Sophia8!2024', 0),
(598324, 'Michael Carter', 'Mikey*98$', 0),
(876543, 'Emily Davis', 'Emily@987', 0),
(751234, 'Lucas Martens', 'LucasMart#2024', 0),
(783456, 'Ethan Wilson', 'Ethan@_2024', 0),
(420875, 'Chloe White', 'Chloe2024$', 0),
(634513, 'Daniel Miller', 'DanielM123', 0),
(420876, 'Olivia Scott', 'Olivia@2023', 0),
(365456, 'Isabella Harris', 'Isabella!25', 0),
(875432, 'Lucas Anderson', 'Lucas*7890', 0),
(294562, 'Sophia Young', 'Sophia_!98', 0),
(653129, 'Gabriel Moore', 'Gabriel_456', 0),
(879123, 'Ismail Hossain', 'Ismail@2023', 0),
(354867, 'Amira Nasser', 'Amira*2024', 0),
(745653, 'Omar Said', 'Omar!789', 0),
(974623, 'Jasmine Lee', 'Jasmine2024#', 0),
(832156, 'Hassan Ali', 'Hassan@456', 0),
(761459, 'Chloe White', 'ChloeW!987', 0),
(497123, 'Daniel Turner', 'DanielT#876', 0),
(361988, 'Sophia Taylor', 'Sophia1234@', 0),
(324568, 'David Brown', 'David!5678', 0),
(341258, 'Lucas Garcia', 'Lucas*7890', 0),
(768324, 'Amelia Wilson', 'Amelia@123', 0),
(541236, 'Maximilian Schmidt', 'Max!2023', 0),
(420877, 'Hassan Ibrahim', 'Hassan2023@', 0),
(530478, 'Sophia Thompson', 'SophiaT88$', 0),
(874162, 'Zara Ali', 'Zara*1234', 0),
(573201, 'Mateo Lopez', 'Mateo@456', 0),
(975321, 'Emma Moore', 'Emma!2024$', 0),
(987123, 'Adnan Ahmed', 'Adnan#123', 0),
(198235, 'Nina Lee', 'Nina@7890', 0),
(741239, 'William Clark', 'William*99', 0),
(851623, 'Maya Taylor', 'Maya!2023$', 0),
(634514, 'Elena White', 'Elena@1234', 0),
(720138, 'Luis Gonzalez', 'LuisG2024$', 0),
(159823, 'Sophia Robinson', 'Sophia@5!88', 0),
(763145, 'Oliver Green', 'Oliver@456', 0),
(294563, 'Jessica Harris', 'Jessica!2023', 0),
(753289, 'Dylan Harris', 'Dylan@_2023', 0),
(236587, 'Maria Perez', 'MariaP!2024', 0),
(754321, 'Yusuf Khan', 'Yusuf#987', 0),
(752649, 'Eve Brown', 'Eve!345', 0),
(931756, 'Zoe Johnson', 'Zoe2024#', 0),
(834756, 'Aiden Clark', 'Aiden@2023', 0),
(837952, 'Liam Scott', 'Liam!456', 0),
(862736, 'Charlie Miller', 'CharlieM!88', 0),
(495861, 'Ethan Jackson', 'Ethan@5678', 0),
(762583, 'Michael Thomas', 'MichaelT@2024', 0),
(853947, 'Anna Hill', 'Anna@7654', 0),
(956731, 'Noah Thompson', 'NoahT@876', 0),
(647283, 'Sarah Mitchell', 'Sarah_2024', 0),
(738293, 'Charlotte Taylor', 'CharlieT@456', 0),
(721238, 'William Anderson', 'William!123', 0);

-- Insert values into Club table
INSERT INTO `Club` (ClubName, MemberCount, MaxCapacity, hasPresident, hasVicePresident) VALUES
('Chess Club', 10, 20, 1, 0),
('Gaming Club', 15, 20, 1, 0),
('Music Club', 12, 20, 1, 1),
('Drama Club', 15, 20, 1, 1),
('Debate Club', 20, 20, 1, 1),
('Fashion Club', 8, 20, 1, 0),
('Football Club', 20, 20, 1, 0),
('Media Club', 10, 20, 1, 1),
('Basketball Club', 20, 20, 1, 0);

-- Insert values into User_Club table (assigning users to clubs)
INSERT INTO `User_Club` (IDNumber, ClubName, isPresident, isVicePresident) VALUES
(198240, 'Chess Club', 1, 0),
(672345, 'Gaming Club', 1, 0),
(324567, 'Music Club', 1, 0),
(413290, 'Drama Club', 1, 0),
(719283, 'Debate Club', 1, 0),
(361987, 'Fashion Club', 1, 0),
(625789, 'Football Club', 1, 0),
(547891, 'Media Club', 1, 0),
(210987, 'Basketball Club', 1, 0),
(634512, 'Music Club', 0, 1),
(759231, 'Drama Club', 0, 1),
(785123, 'Debate Club', 0, 1),
(450987, 'Media Club', 0, 1),
(903214, 'Chess Club', 0, 0),
(234678, 'Gaming Club', 0, 0),
(129876, 'Music Club', 0, 0),
(598324, 'Drama Club', 0, 0),
(876543, 'Debate Club', 0, 0),
(751234, 'Fashion Club', 0, 0),
(783456, 'Football Club', 0, 0),
(420875, 'Media Club', 0, 0),
(634513, 'Basketball Club', 0, 0),
(420876, 'Chess Club', 0, 0),
(365456, 'Gaming Club', 0, 0),
(875432, 'Music Club', 0, 0);

-- Insert values into Timetable table
INSERT INTO `Timetable` (ClubName, Day, Time) VALUES
('Chess Club', 'Monday', '16:00'),
('Gaming Club', 'Tuesday', '16:00'),
('Music Club', 'Wednesday', '17:00'),
('Drama Club', 'Thursday', '15:00'),
('Debate Club', 'Friday', '16:00'),
('Fashion Club', 'Thursday', '16:00'),
('Football Club', 'Wednesday', '15:00'),
('Media Club', 'Monday', '15:00'),
('Basketball Club', 'Friday', '15:00');
