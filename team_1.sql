-- from: Katie Fox
DROP DATABASE IF EXISTS little_league_1;
CREATE DATABASE little_league_1;
USE little_league_1;

-- DDL

CREATE TABLE family
  (
     family_id                INT PRIMARY KEY
     ,family_surname          VARCHAR (45)
     ,family_street_address   VARCHAR (45)
     ,family_city             VARCHAR (45)
     ,family_state            VARCHAR (45)
     ,family_zip_code         INT
     ,family_phone            INT
     ,family_emergency_number INT
  );

CREATE TABLE game
  (
     game_id         INT PRIMARY KEY
     ,game_date      DATE
     ,game_time      TIME
     ,game_location  VARCHAR (45)
     ,game_home_team VARCHAR (45)
     ,game_away_team VARCHAR (45)
     ,game_score     INT
  );


CREATE TABLE coach
  (
     coach_id         INT PRIMARY KEY
     ,coach_lastname  VARCHAR(45)
     ,coach_firstname VARCHAR(45)
     ,coach_birthday  DATE
     ,family_id       INT,
     FOREIGN KEY (family_id) REFERENCES family (family_id)
  );


CREATE TABLE team
  (
     team_id    INTEGER PRIMARY KEY
     ,team_name VARCHAR(45)
     ,coach_id  INT
     ,player_id INT
     ,FOREIGN KEY (coach_id) REFERENCES coach (coach_id)
--     ,FOREIGN KEY (player_id) REFERENCES player (player_id)
  );

-- ALTER TABLE team
--  DROP FOREIGN KEY player_id; /*This is getting an error even though the syntax is correct*/


CREATE TABLE player
  (
     player_id           INT PRIMARY KEY
     ,player_lastname    VARCHAR(45)
     ,player_firstname   VARCHAR(45)
     ,player_birthday    DATE
     ,player_skill_level VARCHAR(10)
     ,family_id          INT,
     FOREIGN KEY (family_id) REFERENCES family (family_id)
  );

ALTER TABLE player
  ADD team_id INT,
  ADD FOREIGN KEY (team_id) REFERENCES team (team_id);

CREATE TABLE meet
  (
     meet_id  INT PRIMARY KEY
     ,team_id INT
     ,game_id INT
     ,FOREIGN KEY (team_id) REFERENCES team (team_id)
     ,FOREIGN KEY (game_id) REFERENCES game (game_id)
  );

-- DML
-- family
INSERT INTO family
(
  family_id,family_surname,family_street_address,family_city,family_state,family_zip_code,family_phone,family_emergency_number
)
VALUES
(
  121,
  'Dodd',
  '12211 Evergreen Terrace',
  'Madison',
  'Wisconsin',
  53703,
  123456789,
  911
)
;

INSERT INTO family
(
  family_id,family_surname,family_street_address,family_city,family_state,family_zip_code,family_phone,family_emergency_number
)
VALUES
(
  111,
  'Cranberry',
  '12011 Evergreen Terrace',
  'Madison',
  'Wisconsin',
  53703,
  123445789,
  911
)
;

INSERT INTO family
(
  family_id,family_surname,family_street_address,family_city,family_state,family_zip_code,family_phone,family_emergency_number
)
VALUES
(
  311,
  'Davis',
  '12011 Pine Terrace',
  'Madison',
  'Wisconsin',
  53703,
  123440089,
  911
)
;

INSERT INTO family
(
  family_id,family_surname,family_street_address,family_city,family_state,family_zip_code,family_phone,family_emergency_number
)
VALUES
(
  161,
  'Bratwurst',
  '01011 Pinewood Terrace',
  'Madison',
  'Wisconsin',
  53703,
  1223440089,
  911
)
;

INSERT INTO family
(
  family_id,family_surname,family_street_address,family_city,family_state,family_zip_code,family_phone,family_emergency_number
)
VALUES
(
  301,
  'Bratbest',
  '01011 Pinewood Terrace',
  'Madison',
  'Wisconsin',
  53703,
  0223440089,
  911
)
;

-- coach
INSERT INTO coach
VALUES
(
  1,
  'Davis',
  'John',
  '1978-10-27',
  111
)
;

INSERT INTO coach VALUES (
  2,
  'Roberts',
  'Robert',
  '1969-05-13',
  121
  );
INSERT INTO coach
VALUES
(
  3,
  'Cranberry',
  'Sandra',
  '1980-12-24',
  311
)
;

INSERT INTO coach
VALUES
(
  4,
  'Michaels',
  'Michael',
  '1983-07-07',
  301);

INSERT INTO coach
VALUES
(
  5,
  'Bratwurst',
  'Rodger',
  '1976-07-04',
  NULL
)
;

-- team
INSERT INTO team
(
  team_id,team_name,coach_id
)
VALUES
(
  1,
  'The Hoboes',
  3
)
;

INSERT INTO team
(
  team_id,team_name,coach_id
)
VALUES
(
  2,
  'The Warriors',
  2
)
;

INSERT INTO team
(
  team_id,team_name,coach_id
)
VALUES
(
  3,
  'The David Bowie Experience',
  5
)
;

INSERT INTO team
(
  team_id,team_name,coach_id
)
VALUES
(
  4,
  'Team Nice Dynamite',
  1
)
;

INSERT INTO team
(
  team_id,team_name,coach_id
)
VALUES
(
  5,
  'The Venture Bros.',
  4
)
;


-- player

INSERT INTO player
VALUES
(
  1,
  'Davis',
  'David',
  '1990-12-12',
  'medium',
  301,
  1
)
;

INSERT INTO player
VALUES
(
  2,
  'Pemberry',
  'Peter',
  '1990-12-13',
  'excellent',
  161,
  2
)
;

INSERT INTO player
VALUES
(
  3,
  'Cranberry',
  'Craig',
  '1990-12-13',
  'bad',
  311,
  3
)
;

INSERT INTO player
VALUES
(
  4,
  'Applesauce',
  'Adam',
  '1990-12-15',
  'bad',
  311,
  4
)
;

INSERT INTO player
VALUES
(
  5,
  'Bratwurst',
  'Benny',
  '1990-12-16',
  'great',
  111,
  5
)
;
