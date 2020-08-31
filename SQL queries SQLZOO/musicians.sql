--Musicians: easy questions
1.
--Give the organiser's name of the concert in the Assembly Rooms after the first of Feb, 1997.
SELECT
    m_name
FROM
    concert
        JOIN
    musician ON musician.m_no = concert.concert_orgniser
WHERE
    concert_venue = 'Assembly Rooms'
        AND con_date > 20 / 09 / 97;

2.
--Find all the performers who played guitar or violin and were born in England.

SELECT
    m_name, instrument, place_country
FROM
    musician m
        JOIN
    performer p ON m.m_no = p.perf_no
        JOIN
    place pl ON m.born_in = pl.place_no
WHERE
    instrument IN ('guitar' , 'violin')
        AND place_country = 'England';

3.
--List the names of musicians who have conducted concerts in USA together with the towns and dates of these concerts.

SELECT
    m_name, place_town, con_date
FROM
    musician m
        JOIN
    concert c ON m.m_no = c.concert_orgniser
        JOIN
    place pl ON c.concert_in = pl.place_no
WHERE
    place_country = 'USA';


5.
--list the different instruments played by the musicians and avg number of musicians who play the instrument.

SELECT
    instrument,
    COUNT(m_no) / ((SELECT
            COUNT(m_no)
        FROM
            musician)) * 100
FROM
    musician m
        JOIN
    performer p ON m.m_no = p.perf_is
GROUP BY instrument;

--Musicians: medium questions
6.
--List the names, dates of birth and the instrument played of living musicians who play a instrument which Theo also plays.

SELECT
    m_name, born, instrument
FROM
    musician m
        JOIN
    performer p ON m.m_no = p.perf_is
WHERE
    instrument IN (SELECT
            instrument
        FROM
            musician m
                JOIN
            performer p ON m.m_no = p.perf_is
        WHERE
            m_name LIKE 'Theo%');

7.
--List the name and the number of players for the band whose number of players is greater than the average number of players in each band.

SELECT
    band_name,
    COUNT(player) as total
FROM
    band b
        JOIN
    plays_in pl ON b.band_no = pl.band_id
GROUP BY band_name
having count(player) > (SELECT
            COUNT(perf_is) / COUNT(DISTINCT band_id)
        FROM
            performer pe
                JOIN
            plays_in pl ON pe.perf_no = pl.player);

8.
--List the names of musicians who both conduct and compose and live in Britain.

SELECT
    m_name, living_in, place_country
FROM
    musician m
        JOIN
    place p ON m.living_in = p.place_no
WHERE
    m_no IN (SELECT
            comp_is
        FROM
            composer)
        AND m_no IN (SELECT
            conducted_by
        FROM
            performance)
        AND place_country IN ('England' , 'Scotland');

9.
--Show the least commonly played instrument and the number of musicians who play it.

SELECT
    count(perf_is) total, instrument
FROM
    performer
group by instrument
having count(total) = 1;

10.
--List the bands that have played music composed by Sue Little; Give the titles of the composition in each case.

SELECT
    band_name
FROM
    band
WHERE
    band_no in (SELECT
            gave
        FROM
            performance
        WHERE
            performed in (SELECT
                    c_no
                FROM
                    composition
                WHERE
                    c_in in (SELECT
                            m_no
                        FROM
                            musician
                        WHERE
                            m_name = 'Sue Little')))
