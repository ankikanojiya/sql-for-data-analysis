-- Fitness Management System

-- Scenario: You have been assigned to develop a comprehensive fitness management system that caters to multiple gyms or fitness centers. The system should allow users to track their workouts, manage gym memberships, and generate reports for gym owners.

-- Database Schema:
-- - Table: Gyms
--   - Columns: gym_id, name, address, city, state, country

-- - Table: Users
--   - Columns: user_id, gym_id, name, age, height, weight

-- - Table: Exercises
--   - Columns: exercise_id, name, description

-- - Table: Memberships
--   - Columns: membership_id, user_id, start_date, end_date

-- - Table: Workouts
--   - Columns: workout_id, user_id, exercise_id, duration, calories_burned, workout_date

-- SQL Queries:

USE projsql;

CREATE DATABASE fittrack;

-- Create Tables:

CREATE TABLE Gyms (
  gym_id INT PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255),
  city VARCHAR(255),
  state VARCHAR(255),
  country VARCHAR(255)
);

CREATE TABLE Users (
  user_id INT PRIMARY KEY,
  gym_id INT,
  name VARCHAR(255),
  age INT,
  height FLOAT,
  weight FLOAT,
  FOREIGN KEY (gym_id) REFERENCES Gyms(gym_id)
);

CREATE TABLE Exercises (
  exercise_id INT PRIMARY KEY,
  name VARCHAR(255),
  description VARCHAR(255)
);

CREATE TABLE Memberships (
  membership_id INT PRIMARY KEY,
  user_id INT,
  start_date DATE,
  end_date DATE,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Workouts (
  workout_id INT PRIMARY KEY,
  user_id INT,
  exercise_id INT,
  duration INT,
  calories_burned FLOAT,
  workout_date DATE,
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (exercise_id) REFERENCES Exercises(exercise_id)
);


-- Insert Data into Tables:

INSERT INTO Gyms (gym_id, name, address, city, state, country)
VALUES
  (1, 'Fitness Center A', '123 Main St', 'New York', 'NY', 'USA'),
  (2, 'Fitness Center B', '456 Elm St', 'Los Angeles', 'CA', 'USA'),
  (3, 'Fitness Center C', '789 Oak St', 'Chicago', 'IL', 'USA'),
  (4, 'Fitness Center D', '321 Pine St', 'Houston', 'TX', 'USA'),
  (5, 'Fitness Center E', '654 Maple St', 'Miami', 'FL', 'USA');


INSERT INTO Users (user_id, gym_id, name, age, height, weight)
VALUES
  (1, 1, 'John Doe', 30, 175, 80),
  (2, 2, 'Jane Smith', 25, 160, 60),
  (3, 3, 'Michael Johnson', 35, 180, 85),
  (4, 4, 'Emily Davis', 28, 165, 55),
  (5, 5, 'David Lee', 32, 170, 75);

INSERT INTO Exercises (exercise_id, name, description)
VALUES
  (1, 'Running', 'Cardiovascular exercise'),
  (2, 'Weightlifting', 'Strength training exercise'),
  (3, 'Yoga', 'Mind-body exercise'),
  (4, 'Cycling', 'Low-impact cardio exercise'),
  (5, 'Swimming', 'Full-body workout in water');

INSERT INTO Memberships (membership_id, user_id, start_date, end_date)
VALUES
  (1, 1, '2023-01-01', '2023-12-31'),
  (2, 2, '2023-02-01', '2023-11-30'),
  (3, 3, '2023-03-01', '2023-10-31'),
  (4, 4, '2023-04-01', '2023-09-30'),
  (5, 5, '2023-05-01', '2023-08-31');

INSERT INTO Workouts (workout_id, user_id, exercise_id, duration, calories_burned, workout_date)
VALUES
  (1, 1, 1, 30, 300, '2023-05-10'),
  (2, 2, 2, 45, 200, '2023-05-11'),
  (3, 3, 3, 60, 250, '2023-05-12'),
  (4, 4, 4, 40, 400, '2023-05-13'),
  (5, 5, 5, 50, 350, '2023-05-14');


-- Retrieve Gym Information:

SELECT * FROM Gyms;


-- Search for Users:

SELECT * FROM Users WHERE name = 'John Doe';


-- Log a Workout:

INSERT INTO Workouts (workout_id, user_id, exercise_id, duration, calories_burned, workout_date)
VALUES (6, 1, 2, 60, 400, '2023-05-12');


-- Update User Information:

UPDATE Users SET weight = 75 WHERE user_id = 1;

-- Number of users with age above 25:

SELECT COUNT(*) FROM Users
WHERE age>25;

-- Getting gym and city names where the users' height is not 160:

SELECT name, city FROM Gyms 
WHERE gym_id IN (SELECT gym_id FROM Users
WHERE height<>160);

-- View Workout History for a User:

SELECT w.workout_id, e.name, w.duration, w.calories_burned, w.workout_date
FROM Workouts w
JOIN Exercises e ON w.exercise_id = e.exercise_id
WHERE w.user_id = 1;


-- Generate Membership Reports:

SELECT m.membership_id, u.name, m.start_date, m.end_date
FROM Memberships m
JOIN Users u ON m.user_id = u.user_id
WHERE m.start_date <= '2023-05-16' AND m.end_date >= '2023-05-16';

-- Dropping tables:

DROP TABLE Gyms;

DROP TABLE Users;

DROP TABLE Exercises;

DROP TABLE Memberships;

DROP TABLE Workouts;
