1962 movies
1.
List the films where the yr is 1962 [Show id, title]

SELECT
    id, title
FROM
    movie
WHERE
    yr = 1962;


When was Citizen Kane released?
2.
Give year of 'Citizen Kane'.


SELECT
    yr
FROM
    movie
WHERE
    title = 'Citizen Kane';


Star Trek movies
3.
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

SELECT
    id, title, yr
FROM
    movie
WHERE
    title LIKE '%Star Trek%'
ORDER BY yr;

id for actor Glenn Close
4.
What id number does the actor 'Glenn Close' have?

SELECT
    actor.id
FROM
    actor
WHERE
    name = 'Glenn Close';

id for Casablanca
5.
What is the id of the film 'Casablanca'

SELECT
    id
FROM
    movie
WHERE
    title = 'Casablanca';

Cast list for Casablanca
6.
Obtain the cast list for 'Casablanca'.


SELECT
    name
FROM
    actor
        JOIN
    casting ON actor.id = casting.actorid
WHERE
    movieid = 11768;


Alien cast list
7.
Obtain the cast list for the film 'Alien'

SELECT
    name
FROM
    actor
        JOIN
    casting ON actor.id = casting.actorid
WHERE
    movieid = (SELECT
            movie.id
        FROM
            movie
        WHERE
            title = 'Alien');


Harrison Ford movies
8.
List the films in which 'Harrison Ford' has appeared

SELECT
    title
FROM
    movie
        JOIN
    casting ON movie.id = casting.movieid
WHERE
    actorid = (SELECT
            id
        FROM
            actor
        WHERE
            name = 'Harrison Ford');

Harrison Ford as a supporting actor
9.
List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

SELECT
    title
FROM
    movie
        JOIN
    casting ON movie.id = casting.movieid
WHERE
    ord != 1
        AND actorid = (SELECT
            id
        FROM
            actor
        WHERE
            name = 'Harrison Ford');


Lead actors in 1962 movies
10.
List the films together with the leading star for all 1962 films.

SELECT
    title, name
FROM
    movie
        JOIN
    casting ON movie.id = casting.movieid
        JOIN
    actor ON casting.actorid = actor.id
WHERE
    ord = 1 AND yr = 1962;


--------------------
/*Harder Questions*/
--------------------

Busy years for Rock Hudson
11.
Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT
    yr, COUNT(title)
FROM
    movie
        JOIN
    casting ON movie.id = movieid
        JOIN
    actor ON actorid = actor.id
WHERE
    name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

Lead actor in Julie Andrews movies
12.
List the film title and the leading actor for all of the films 'Julie Andrews' played in.

SELECT
    title, name
FROM
    movie
        JOIN
    casting ON movie.id = movieid
        JOIN
    actor ON actorid = actor.id
WHERE
    ord = 1
        AND movieid IN (SELECT
            movieid
        FROM
            casting
                JOIN
            actor ON casting.actorid = actor.id
        WHERE
            name = 'Julie Andrews');


Actors with 15 leading roles
13.
Obtain a list, in alphabetical order, of actors who have had at least 15 starring roles.

SELECT
    name
FROM
    actor
        JOIN
    casting ON id = actorid
WHERE
    ord = 1
GROUP BY name
HAVING COUNT(*) > 14
ORDER BY name;

14.
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT
    title, COUNT(actorid)
FROM
    movie
        JOIN
    casting ON casting.movieid = movie.id
        JOIN
    actor ON casting.actorid = actor.id
WHERE
    yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC , title;

15.
List all the people who have worked with 'Art Garfunkel'.

SELECT
    name
FROM
    actor
        JOIN
    casting ON actor.id = casting.actorid
        JOIN
    movie ON movie.id = casting.movieid
WHERE
    name != 'Art Garfunkel'
        AND movie.id IN (SELECT
            movie.id
        FROM
            casting
                JOIN
            movie ON movie.id = casting.movieid
                JOIN
            actor ON actor.id = casting.actorid
        WHERE
            actor.name = 'Art Garfunkel');
