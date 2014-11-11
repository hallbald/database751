-- Problem: find the number of times any team has played any other team.

-- Step one: 
-- Self-join matchup to matchup (same table, twice the tuples). Use aliases (AS) to be able to refer to them separately in other parts of the query.
SELECT 
	 m1.game_id
	,m1.team_id
	,m2.team_id 
FROM matchup AS m1
JOIN matchup AS m2 USING (game_id)
-- Peform the join on the game_id, to create two rows per game. A third row is produced joining a team to itself. 
WHERE
-- This can be filtered out in the WHERE clause by excluding rows with the same team_id twice.
	m1.team_id != m2.team_id
-- Don't be distracted by the fact that I pick one matchup table to access the game_id. Because they are joined, it doesn't matter. Same with the SELECt clause.
ORDER BY m1.game_id;
-- Result: If team 2 playes team 5 in game 1, produce two rows
-- game 1, team 2, team 5
-- game 1, team 5, team 2
-- Meaning: Team 2 played team 5, and team 5 played team 2. This is necessary to do the counting in the next step.

-- Step two: aggregate and count each combination
-- Same SELECT as before, except I don't return game_id because I'm aggregating (counting) it.
SELECT 
	 m1.team_id
	,m2.team_id 
	,COUNT(*)
FROM matchup m1
JOIN matchup m2 USING (game_id)
WHERE
	m1.team_id != m2.team_id
-- Without aggregation, if a team plays the same team twice, we'll see two rows duplicating the pairing.
-- E.g. if team 2 plays team 5 once (in game 1), then play again in game 2, there will be 4 rows total
-- game 1, team 2, team 5
-- game 1, team 5, team 2
-- game 2, team 2, team 5
-- game 2, team 5, team 2
-- So to count the pairings, we group by *both* team_ids, then count the games played by that pairing.
-- If we sort and reorder the results above, it becomes a bit more obvious how this will work:
-- team 2, team 5, game 1 
-- team 2, team 5, game 2
-- team 5, team 2, game 1
-- team 5, team 2, game 2
-- If we group by (team 2, team 5) we'll have 2 rows apiece, representing the games they've played.
GROUP BY m1.team_id, m2.team_id
ORDER BY m1.team_id;