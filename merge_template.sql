-- From: Yifan Zhu
DROP DATABASE IF EXISTS little_league_merged;

CREATE DATABASE little_league_merged;

USE little_league_merged;

-- DDL
CREATE TABLE family
  (
     family_id               INT (10) NOT NULL
     ,family_surname         VARCHAR (20) NOT NULL
     ,family_phone_home      VARCHAR (10) NOT NULL
     ,family_phone_cell      VARCHAR (10)
     ,family_email           VARCHAR (50)
     ,family_mailing_address VARCHAR (100) NOT NULL,
     PRIMARY KEY (family_id)
  );

CREATE TABLE game
  (
     game_id        INT (50) NOT NULL
     ,game_location VARCHAR (100)
     ,game_date     DATETIME NOT NULL
     ,winning_team  INT (10),
     PRIMARY KEY (game_id)
  );

CREATE TABLE coach
  (
     coach_id        INT (10) NOT NULL
     ,coach_fname    VARCHAR (20) NOT NULL
     ,coach_lname    VARCHAR (20) NOT NULL
     ,coach_birthday DATE
     -- You can have family_id on both coach and player, but indexes (name of fk constraint) must be different.
     ,family_id      INT (10) NOT NULL,
     PRIMARY KEY (coach_id)
  );

CREATE TABLE team
  (
     team_id    INT (10) NOT NULL
     ,team_name VARCHAR (30) NOT NULL
     --     ,team_wins INT (10) Should be a derived value
     ,coach_id  INT (10) NOT NULL,
     PRIMARY KEY (team_id)
  );

CREATE TABLE player
  (
     player_id        INT (10) NOT NULL
     ,player_fname    VARCHAR (20) NOT NULL
     ,player_lname    VARCHAR (20) NOT NULL
     ,player_nickname VARCHAR (20)
     ,player_birthday DATE NOT NULL
     ,team_id         INT (10) NOT NULL
     -- You can have family_id on both coach and player, but indexes (name of fk constraint) must be different.
     ,family_id       INT (10) NOT NULL,
     PRIMARY KEY (player_id)
  );

CREATE TABLE matchup
  (
     game_id      INT (10) NOT NULL
     ,team_id     INT (10) NOT NULL
     ,team_status ENUM ('home', 'away') NOT NULL
     ,team_score  INT (2) NOT NULL,
     PRIMARY KEY (game_id, team_id, team_status)
  );

ALTER TABLE matchup
  ADD CONSTRAINT game_id_fk FOREIGN KEY (game_id) REFERENCES game (game_id),
  ADD CONSTRAINT matchup_team_fk FOREIGN KEY (team_id) REFERENCES team (team_id);

ALTER TABLE team
  ADD CONSTRAINT team_coach_fk FOREIGN KEY (coach_id) REFERENCES coach (coach_id);

ALTER TABLE player
  ADD CONSTRAINT player_team_fk FOREIGN KEY (team_id) REFERENCES team (team_id);

ALTER TABLE coach
  ADD CONSTRAINT coach_family_fk FOREIGN KEY (family_id) REFERENCES family (family_id);

ALTER TABLE player
  ADD CONSTRAINT player_family_fk FOREIGN KEY (family_id) REFERENCES family (family_id);

INSERT INTO family
(
  family_id,family_surname,family_phone_home,family_phone_cell,family_email,family_mailing_address
)
VALUES
(
  1,
  'Neilson',
  '6086981234',
  '6086981235',
  'neilson@littleague.org',
  '123 Brown St., Madison, WI 53711'
)
,
(
  2,
  'Cucumbersalad',
  '6086981236',
  '6086981237',
  'cucumbersalad@littleleague.org',
  '456 Lake St., Madison, WI 53703'
)
,
(
  3,
  'Swanson',
  '6086981238',
  '6086981239',
  'swanson@littleleague.org',
  '789 Park St. Fitchburg, WI 54709'
)
,
(
  4,
  'Malarky',
  '6086981240',
  '6086981241',
  'malarky@littleleague.org',
  '147 University Ave. Monroe, WI 53721'
)
,
(
  5,
  'FitzGerald',
  '6086981242',
  '6086981243',
  'fitzgerald@littleleague.org',
  '258 Whitney Way, Madison, WI 53704'
)
,
(
  6,
  'Hillgartner',
  '6086981244',
  '6086981245',
  'hillgartner@littleleague.org',
  '369 Odana Rd., Madison, WI 53701'
)
,
(
  7,
  'Tripp',
  '6086981246',
  '6086981247',
  'tripp@littleleague.org',
  '159 State St., Madison, WI 53704'
)
,
(
  8,
  'Powers',
  '6086981248',
  '6086981249',
  'powers@littleleague.org',
  '487 Midvale Blvd., Mdidleton, WI 53710'
)
; -- 8 families

INSERT INTO coach
(
  coach_id,coach_fname,coach_lname,coach_birthday,family_id
)
VALUES
(
  1,
  'Paul',
  'Neilson',
  '1978-10-09',
  1
)
,
(
  2,
  'Beignet',
  'Cucumbersalad',
  '1965-03-02',
  2
)
,
(
  3,
  'Mary Anne',
  'Swanson',
  '1971-11-11',
  3
)
,
(
  4,
  'Charity',
  'Malarky',
  '1964-06-21',
  4
)
,
(
  5,
  'Harold',
  'FitzGerald',
  '1975-06-19',
  5
)
,
(
  6,
  'Chris',
  'Powers',
  '1979-04-04',
  8
)
; -- 6 coaches

INSERT INTO team
(
  team_id,team_name,coach_id
)
VALUES
(
  1,
  'The Pirates',
  1
)
,
(
  2,
  'The Warriors',
  2
)
,
(
  3,
  'The David Bowie Experience',
  3
)
,
(
  4,
  'Team Nice Dynamite',
  4
)
,
(
  5,
  'The Venture Bros.',
  5
)
,
(
  6,
  'Tangerine Dreams',
  6
)
; -- 6 teams

INSERT INTO player
(
  player_id,player_fname,player_lname,player_nickname,player_birthday,team_id,family_id
)
VALUES
(
  1,
  'Joe',
  'Malarky',
  'Joey',
  '1992-04-09',
  4,
  4
)
,
(
  2,
  'Emily',
  'Hillgartner',
  'lizz',
  '1995-02-04',
  1,
  6
)
,
(
  3,
  'John',
  'Tripp',
  'Jo',
  '1996-03-06',
  2,
  7
)
,
(
  4,
  'Suzie',
  'FitzGerald',
  'Suz',
  '1998-07-12',
  5,
  5
)
,
(
  5,
  'Zach',
  'Powers',
  'Zac',
  '1999-04-01',
  6,
  8
)
,
<% players.each do |player| %>
(
  <%= player[:player_id] %>,
  '<%= player[:player_fname] %>',
  '<%= player[:player_lname] %>',
  '<%= player[:player_nickname] %>',
  '<%= player[:player_birthday] %>',
  <%= player[:team_id] %>,
  <%= player[:family_id] %>
)<% unless player == players.last %>,<% end %>
<% end %>
; -- <%= players.size %> players

INSERT INTO game
(
  game_id,game_location,game_date,winning_team
)
VALUES
(
  1,
  'Demetral',
  '2014-10-28',
  NULL
)
,
(
  2,
  'Burr Jones',
  '2014-10-29',
  NULL
)
,
(
  3,
  'McGaw',
  '2014-10-29',
  NULL
)
,
(
  4,
  'University Bay Field',
  '2014-10-28',
  NULL
)
,
(
  5,
  'Warner Park',
  '2014-10-28',
  NULL
)
; -- 5 games

INSERT INTO matchup
(
  game_id,team_id,team_status,team_score
)
VALUES
(
  1,
  2,
  'away',
  17
)
,
(
  1,
  5,
  'home',
  3
)
,
(
  2,
  1,
  'home',
  10
)
,
(
  2,
  3,
  'away',
  22
)
,
(
  3,
  4,
  'away',
  9
)
,
(
  3,
  6,
  'home',
  2
)
;
