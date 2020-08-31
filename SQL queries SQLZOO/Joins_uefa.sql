1.
--The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

--Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'

SELECT
    matchid, player
FROM
    goal
WHERE
    teamid LIKE 'GER';

2.
--From the previous query you can see that Lars Bender`s scored a goal in game 1012. Now we want to know what teams were playing in that match.

--Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.

--Show id, stadium, team1, team2 for just game 1012

SELECT
    id, stadium, team1, team2
FROM
    game
WHERE
    id = 1012;

3.

--Show the player, teamid, stadium and mdate for every German goal.

SELECT
    player, teamid, stadium, mdate
FROM
    game
        JOIN
    goal ON (id = matchid)
WHERE
    teamid = 'GER';

4.

--Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT
    team1, team2, player
FROM
    game
        JOIN
    goal ON (id = matchid)
WHERE
    player like "Mario%"

5.
--The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id

--Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT
    player, teamid, coach, gtime
FROM
    goal
        JOIN
    eteam ON goal.teamid = eteam.id
WHERE
    gtime <= 10;

6.

--List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT
    g.mdate, e.teamname
FROM
    game g
        JOIN
    eteam e ON g.team1 = e.id
WHERE
    coach = 'Fernando Santos'

7.
--List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT
    g.player
FROM
    goal g
        JOIN
    game ga ON g.matchid = ga.id
WHERE
    ga.stadium = 'National Stadium, Warsaw'

8.

--Show the name of all players who scored a goal against Germany.

SELECT DISTINCT
    player
FROM
    goal g
        JOIN
    game ga ON g.matchid = ga.id
WHERE
    teamid != 'GER'
        AND (team1 = 'GER' OR team2 = 'GER');

9.
--Show teamname and the total number of goals scored.

SELECT
    e.teamname, COUNT(g.teamid) AS goals_scored
FROM
    eteam e
        JOIN
    goal g ON e.id = g.teamid
GROUP BY g.teamid
ORDER BY e.teamname;

10.
--Show the stadium and the number of goals scored in each stadium.

SELECT
    ga.stadium, COUNT(go.teamid) AS goals_per_stadium
FROM
    game ga
        JOIN
    goal go ON ga.id = go.matchid
GROUP BY ga.stadium;

11.
--For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT
    go.matchid, ga.mdate, COUNT(go.teamid) AS goals_scored
FROM
    game ga
        JOIN
    goal go ON go.matchid = ga.id
WHERE
    (ga.team1 = 'POL' OR ga.team2 = 'POL')
GROUP BY go.matchid;

12.
--For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT
    matchid, mdate, COUNT(teamid) AS germany_goals
FROM
    game
        JOIN
    goal ON game.id = goal.matchid
WHERE
    goal.teamid = 'GER'
GROUP BY matchid;


13.
--List every match with the goals scored by each team


SELECT
    ga.mdate,
    team1,
    SUM(CASE
        WHEN go.teamid = ga.team1 THEN 1
        ELSE 0
    END) AS score1,
    ga.team2,
    SUM(CASE
        WHEN go.teamid = ga.team2 THEN 1
        ELSE 0
    END) AS score2
FROM
    game ga
        LEFT JOIN
    goal go ON go.matchid = ga.id
GROUP BY ga.id , ga.mdate , ga.team1 , ga.team2
ORDER BY ga.mdate , go.matchid , ga.team1 , ga.team2;
