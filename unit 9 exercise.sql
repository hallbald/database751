-- from: Kelly Haberstroh
CREATE DATABASE IF NOT EXISTS little_league_3;
USE madison_little_league_3;

-- family entity
DROP TABLE IF EXISTS family;

CREATE TABLE family
  (
     family_id     INTEGER(3)
     ,family_phone VARCHAR(12),
     PRIMARY KEY (family_id)
  )
engine=innodb
DEFAULT charset=latin1;

-- player entity
DROP TABLE IF EXISTS player;

CREATE TABLE player
  (
     player_id    INTEGER(5)
     ,family_id   INTEGER(3)
     ,team_id     INTEGER(2)
     ,coach_id    INTEGER(4)
     ,player_name VARCHAR(30) NOT NULL,
     PRIMARY KEY (player_id)
  )
engine=innodb
DEFAULT charset=latin1;

-- coach entity
DROP TABLE IF EXISTS coach;

CREATE TABLE coach
  (
     coach_id    INTEGER(4)
     ,family_id  INTEGER(3)
     ,coach_name VARCHAR(25) NOT NULL,
     PRIMARY KEY (coach_id)
  )
engine=innodb
DEFAULT charset=latin1;

-- team entity
DROP TABLE IF EXISTS team;

CREATE TABLE team
  (
     team_id    INTEGER(2)
     ,team_name VARCHAR(30) NOT NULL,
     PRIMARY KEY (team_id)
  )
engine=innodb
DEFAULT charset=latin1;

-- game entity
DROP TABLE IF EXISTS game;

CREATE TABLE game
  (
     game_id        INTEGER(6)
     ,game_location VARCHAR(30) NOT NULL,
     PRIMARY KEY (game_id)
  )
engine=innodb
DEFAULT charset=latin1;

-- schedule entity
DROP TABLE IF EXISTS schedule;

CREATE TABLE schedule
  (
     game_id  INTEGER(6)
     ,team_id INTEGER(2),
     PRIMARY KEY (game_id, team_id)
  )
engine=innodb
DEFAULT charset=latin1;

-- Add foreign keys
-- (PKs were inlined in the table create statements)
-- ------------------------- 

-- Base entities
-- Weak relationships = SET NULL on delete
ALTER TABLE player
  ADD CONSTRAINT player_family_fk FOREIGN KEY (family_id) REFERENCES family (family_id) ON UPDATE CASCADE,
  ADD CONSTRAINT player_team_fk FOREIGN KEY (team_id) REFERENCES team (team_id) ON UPDATE CASCADE,
  ADD CONSTRAINT player_coach_fk FOREIGN KEY (coach_id) REFERENCES coach (coach_id) ON UPDATE CASCADE;

ALTER TABLE coach
  ADD CONSTRAINT coach_family_fk FOREIGN KEY (family_id) REFERENCES family (family_id) ON UPDATE CASCADE;

-- Bridge entities
-- strong relationship = CASCADE deletes
ALTER TABLE schedule
  ADD CONSTRAINT team_schedule_fk FOREIGN KEY (team_id) REFERENCES team (team_id) ON DELETE CASCADE,
  ADD CONSTRAINT game_schedule_fk FOREIGN KEY (game_id) REFERENCES game (game_id) ON UPDATE CASCADE;

-- DML (Data Modification Language statements)
-- DML adds actual data to our database. It must
-- conform to entity attributes, datatypes and 
-- relational constraints defined using DDL (above)

-- Insert family values

INSERT INTO family
VALUES
(
  001,
  '6086981234'
)
;

INSERT INTO family
VALUES
(
  002,
  '6086981235'
)
;

INSERT INTO family
VALUES
(
  003,
  '6086981236'
)
;

INSERT INTO family
VALUES
(
  004,
  '6086981237'
)
;

INSERT INTO family
VALUES
(
  005,
  '6086981238'
)
;

-- Insert coach

INSERT INTO coach
VALUES
(
  0001,
  001,
  'John D'
)
;

INSERT INTO coach
VALUES
(
  0002,
  003,
  'Jean C'
)
;

INSERT INTO coach
VALUES
(
  0003,
  002,
  'Holly W'
)
;

INSERT INTO coach
VALUES
(
  0004,
  005,
  'Erin M'
)
;

INSERT INTO coach
VALUES
(
  0005,
  004,
  'Willian N'
)
;

-- Insert team 

INSERT INTO team
VALUES
(
  01,
  'Red'
)
; -- 1

INSERT INTO team
VALUES
(
  02,
  'Blue'
)
; -- 2

INSERT INTO team
VALUES
(
  03,
  'Yellow'
)
; -- 3

INSERT INTO team
VALUES
(
  04,
  'Green'
)
; -- 4

INSERT INTO team
VALUES
(
  05,
  'Black'
)
; -- 5

-- Insert game

INSERT INTO game
VALUES
(
  000001,
  'Madison'
)
; -- 1

INSERT INTO game
VALUES
(
  000002,
  'Sheboygan'
)
; -- 2

INSERT INTO game
VALUES
(
  000003,
  'Monroe'
)
; -- 3

INSERT INTO game
VALUES
(
  000004,
  'Eau Claire'
)
; -- 4

INSERT INTO game
VALUES
(
  000005,
  'Capitol'
)
; -- 5

-- Insert schedule

INSERT INTO schedule
VALUES
(
  000001,
  01
)
; -- 1

INSERT INTO schedule
VALUES
(
  000002,
  02
)
; -- 2

INSERT INTO schedule
VALUES
(
  000003,
  03
)
; -- 3

INSERT INTO schedule
VALUES
(
  000004,
  04
)
; -- 4

INSERT INTO schedule
VALUES
(
  000005,
  05
)
; -- 5

-- Insert player

INSERT INTO player
VALUES
(
  00001,
  001,
  01,
  0001,
  'Jack A'
)
; -- 1

INSERT INTO player
VALUES
(
  00002,
  002,
  02,
  0002,
  'David B'
)
; -- 2

INSERT INTO player
VALUES
(
  00003,
  003,
  03,
  0003,
  'Eric C'
)
; -- 3

INSERT INTO player
VALUES
(
  00004,
  004,
  04,
  0004,
  'Will D'
)
; -- 4

INSERT INTO player
VALUES
(
  00005,
  005,
  05,
  0005,
  'Tom E'
)
; -- 5

