-- from: Kelly Haberstroh
DROP DATABASE IF EXISTS little_league_3;
CREATE DATABASE little_league_3;
USE madison_little_league_3;

-- DDL

-- family entity
CREATE TABLE family
  (
     family_id     INTEGER(3)
     ,family_phone VARCHAR(12)
     ,PRIMARY KEY  (family_id)
  )
engine=innodb
DEFAULT charset=latin1;

-- player entity
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
CREATE TABLE team
  (
     team_id    INTEGER(2)
     ,team_name VARCHAR(30) NOT NULL,
     PRIMARY KEY (team_id)
  )
engine=innodb
DEFAULT charset=latin1;

-- game entity
CREATE TABLE game
  (
     game_id        INTEGER(6)
     ,game_location VARCHAR(30) NOT NULL,
     PRIMARY KEY (game_id)
  )
engine=innodb
DEFAULT charset=latin1;

-- schedule entity
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
  1,
  '6086981234'
)
;

INSERT INTO family
VALUES
(
  2,
  '6086981235'
)
;

INSERT INTO family
VALUES
(
  3,
  '6086981236'
)
;

INSERT INTO family
VALUES
(
  4,
  '6086981237'
)
;

INSERT INTO family
VALUES
(
  5,
  '6086981238'
)
;

-- Insert coach

INSERT INTO coach
VALUES
(
  1,
  1,
  'John D'
)
;

INSERT INTO coach
VALUES
(
  2,
  3,
  'Jean C'
)
;

INSERT INTO coach
VALUES
(
  3,
  2,
  'Holly W'
)
;

INSERT INTO coach
VALUES
(
  4,
  5,
  'Erin M'
)
;

INSERT INTO coach
VALUES
(
  5,
  4,
  'Willian N'
)
;

-- Insert team

INSERT INTO team
VALUES
(
  1,
  'Red'
)
; -- 1

INSERT INTO team
VALUES
(
  2,
  'Blue'
)
; -- 2

INSERT INTO team
VALUES
(
  3,
  'Yellow'
)
; -- 3

INSERT INTO team
VALUES
(
  4,
  'Green'
)
; -- 4

INSERT INTO team
VALUES
(
  5,
  'Black'
)
; -- 5

-- Insert game

INSERT INTO game
VALUES
(
  1,
  'Madison'
)
; -- 1

INSERT INTO game
VALUES
(
  2,
  'Sheboygan'
)
; -- 2

INSERT INTO game
VALUES
(
  3,
  'Monroe'
)
; -- 3

INSERT INTO game
VALUES
(
  4,
  'Eau Claire'
)
; -- 4

INSERT INTO game
VALUES
(
  5,
  'Capitol'
)
; -- 5

-- Insert schedule

INSERT INTO schedule
VALUES
(
  1,
  1
)
; -- 1

INSERT INTO schedule
VALUES
(
  2,
  2
)
; -- 2

INSERT INTO schedule
VALUES
(
  3,
  3
)
; -- 3

INSERT INTO schedule
VALUES
(
  4,
  4
)
; -- 4

INSERT INTO schedule
VALUES
(
  5,
  5
)
; -- 5

-- Insert player

INSERT INTO player
VALUES
(
  1,
  1,
  1,
  1,
  'Jack A'
)
; -- 1

INSERT INTO player
VALUES
(
  2,
  2,
  2,
  2,
  'David B'
)
; -- 2

INSERT INTO player
VALUES
(
  3,
  3,
  3,
  3,
  'Eric C'
)
; -- 3

INSERT INTO player
VALUES
(
  4,
  4,
  4,
  4,
  'Will D'
)
; -- 4

INSERT INTO player
VALUES
(
  5,
  5,
  5,
  5,
  'Tom E'
)
; -- 5
