-- calculate age for each player
SELECT 
	player_fname, 
	player_lname,
	TIMESTAMPDIFF(YEAR,
        player_birthday,
        CURDATE()) AS average_age
FROM player
ORDER BY average_age DESC;

-- calculate average age per team
SELECT 
    team_name,
    AVG(TIMESTAMPDIFF(YEAR,
        player_birthday,
        CURDATE())) AS average_age
FROM
    team NATURAL JOIN player
GROUP BY team_id
ORDER BY average_age DESC;

-- what games have teams played?
SELECT 
	game_location,
	game_date,
	team_name,
	team_status
FROM game 
NATURAL JOIN matchup
NATURAL JOIN team;

-- How many players in each family (note, does not include coaches!)
SELECT 
	family_surname,
	COUNT(*)
FROM 
	family
NATURAL JOIN 
	player
GROUP BY
	family_id;