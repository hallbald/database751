CREATE DATABASE little_league;

USE little_league;

CREATE TABLE coach
(
    coach_id INT (10) NOT NULL, 
    coach_fname VARCHAR (20) NOT NULL, 
    coach_lname VARCHAR (20) NOT NULL, 
    coach_family_id INT (10) NOT NULL,
    PRIMARY KEY (coach_id)
);

CREATE TABLE team
(
    team_id INT (10) NOT NULL,
    team_name VARCHAR (20) NOT NULL,
    team_wins INT (10),
    coach_id INT (10) NOT NULL,
    PRIMARY KEY (team_id)
);

CREATE TABLE player
(
    player_id INT (10) NOT NULL,
    player_fname VARCHAR (20) NOT NULL,
    player_lname VARCHAR (20) NOT NULL,
    player_nickname VARCHAR (20),
    player_dob DATE NOT NULL,
    team_id INT (10) NOT NULL,
    player_family_id INT (10) NOT NULL,
    PRIMARY KEY (player_id)
);

CREATE TABLE family
(
    family_id INT (10) NOT NULL,
    family_name VARCHAR (20) NOT NULL,
    contact_phone_home INT (10) NOT NULL,
    contact_phone_cell INT (10),
    contact_email VARCHAR (50),
    contact_address VARCHAR (100) NOT NULL,
    PRIMARY KEY (family_id)
);

CREATE TABLE game
(
    game_id INT (50) NOT NULL,
    game_location VARCHAR (100),
    game_date DATETIME NOT NULL, 
    PRIMARY KEY (game_id)
);


CREATE TABLE matchup
(
    game_id INT (10) NOT NULL,
    team_id INT (10) NOT NULL,
    team_status ENUM ('home', 'away') NOT NULL,
    team_score INT (2) NOT NULL,
    PRIMARY KEY (game_id, team_id, team_status)
);


ALTER TABLE matchup
   ADD CONSTRAINT game_id_fk
       FOREIGN KEY (game_id)
       REFERENCES game (game_id);
       
ALTER TABLE team
    ADD CONSTRAINT team_team_fk
        FOREIGN KEY (coach_id) 
        REFERENCES coach (coach_id);

ALTER TABLE player
    ADD CONSTRAINT player_team_fk
        FOREIGN KEY (team_id) 
        REFERENCES team (team_id);
    
ALTER TABLE coach 
    ADD CONSTRAINT coach_family_fk
        FOREIGN KEY (coach_family_id) 
        REFERENCES family (family_id);

ALTER TABLE player 
    ADD CONSTRAINT player_family_fk
        FOREIGN KEY (player_family_id) 
        REFERENCES family (family_id);

INSERT INTO family VALUES 
    (1, 'Neilson', 1234567890, 9876543210, 'neilson@littleague.org', '123 Brown St.'),
    (2, 'Cucumbersalad', 4567891230, 7891234560, 'cucumbersalad@littleleague.org', '456 Lake St.'),
    (3, 'Swanson', 1472583690, 2583691470, 'swanson@littleleague.org', '789 Park St.'),
    (4, 'Malarky', 3692581470, 7418529630, 'malarky@littleleague.org', '147 University Ave.'),
    (5, 'FitzGerald', 9638527410, 8529637410, 'fitzgerald@littleleague.org', '258 Whitney Way'),    
    (6, 'Hillgartner', 9516238470, 7849516230, 'hillgartner@littleleague.org', '369 Odana Rd.'),
    (7, 'Tripp', 1576320489, 5204630478, 'tripp@littleleague.org', '159 State St.'),
    (8, 'Powers', 3456784105, 6248951247, 'powers@littleleague.org', '487 Midvale Blvd.');  
   
INSERT INTO coach VALUES 
    (5001, 'Paul', 'Neilson', 1),
    (5002, 'Beignet', 'Cucumbersalad', 2),
    (5003, 'Mary Anne', 'Swanson', 3),
    (5004, 'Charity', 'Malarky', 4),
    (5005, 'Harold', 'FitzGerald', 5),
    (5006, 'Chris', 'Powers', 8);
    
INSERT INTO team VALUES 
    (101, 'pirates', 5, 5001), 
    (102, 'giants', 3, 5002),
    (103, 'chocolates', 9, 5003),
    (104, 'green peace', 1, 5004),
    (105, 'tigers', 7, 5005); 
    (106, 'tangerines', 2, 5006);
    
INSERT INTO player VALUES
    (101, 'Joe', 'Malarky', 'Joey' '1992-04-09', 104, 4),
    (102, 'Emily', 'Hillgartner', 'lizz', '1995-02-04', 101, 6),
    (103, 'John', 'Tripp', 'Jo', '1996-03-06', 102, 7),
    (104, 'Suzie', 'FitzGerald', 'Suz', '1998-07-12', 105, 5),
    (105, 'Zach', 'Powers','Zac', '1999-04-01', 106, 8);

INSERT INTO game VALUES 
    (1, 'Demetral', '2014-10-28'),
    (2, 'Burr Jones', '2014-10-29'),
    (3, 'McGaw', '2014-10-29'),
    (4, 'University Bay Field', '2014-10-28'),
    (5, 'Warner Park', '2014-10-28');
   
INSERT INTO matchup VALUES
    (1, 102, 'away', 17),
    (1, 105, 'home', 3),
    (2, 101, 'home', 10),
    (2, 103, 'away', 22),
    (3, 104, 'away', 9),
    (3, 106, 'home', 2);

   