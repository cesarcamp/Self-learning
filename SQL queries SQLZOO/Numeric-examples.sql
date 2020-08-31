--1.
--Show the the percentage who STRONGLY AGREE

SELECT
    A_STRONGLY_AGREE
FROM
    nss
WHERE
    question = 'Q01'
        AND institution = 'Edinburgh Napier University'
        AND subject = '(8) Computer Science';

--Calculate how many agree or strongly agree
--2-.
--Show the institution and subject where the score is at least 100 for question 15.

SELECT
    institution, subject
FROM
    nss
WHERE
    question = 'Q15' AND score >= 100;

-- Unhappy Computer Students
-- 3.
-- Show the institution and score where the score for '(8) Computer Science' is less than 50 for question 'Q15'

SELECT
    institution, score
FROM
    nss
WHERE
    question = 'Q15' AND score < 50
        AND subject = '(8) Computer Science';

-- More Computing or Creative Students?
-- 4.
-- Show the subject and total number of students who responded to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.

SELECT
    subject, SUM(response)
FROM
    nss
WHERE
    question = 'Q22'
        AND subject IN ('(8) Computer Science' , '(H) Creative Arts And Design')
GROUP BY subject;

-- Strongly Agree Numbers
-- 5.
-- Show the subject and total number of students who A_STRONGLY_AGREE to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.

SELECT
    subject, SUM(response * A_STRONGLY_AGREE / 100)
FROM
    nss
WHERE
    question = 'Q22'
        AND subject IN ('(8) Computer Science' , '(H) Creative Arts and Design')
GROUP BY subject;

-- Strongly Agree, Percentage
-- 6.
-- Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject '(8) Computer Science' show the same figure for the subject '(H) Creative Arts and Design'.

SELECT
    subject,
    ROUND(SUM(response * A_STRONGLY_AGREE / 100) / SUM(response) * 100,
            0)
FROM
    nss
WHERE
    question = 'Q22'
        AND subject IN ('(8) Computer Science' , '(H) Creative Arts and Design')
GROUP BY subject;

Scores for Institutions in Manchester
-- 7.
-- Show the average scores for question 'Q22' for each institution that include 'Manchester' in the name.
--
-- The column score is a percentage - you must use the method outlined above to multiply the percentage by the response and divide by the total response. Give your answer rounded to the nearest whole number.

SELECT
    institution,
    ROUND(SUM(response * score / 100) / SUM(response) * 100,
            0) AS score
FROM
    nss
WHERE
    question = 'Q22'
        AND (institution LIKE '%Manchester%')
GROUP BY institution
ORDER BY institution;

-- Number of Computing Students in Manchester
-- 8.
-- Show the institution, the total sample size and the number of computing students for institutions in Manchester for 'Q01'.
-- SELECT
    institution,
    SUM(sample),
    SUM(CASE
        WHEN subject = '(8) Computer Science' THEN sample
        ELSE 0
    END) AS comp
FROM
    nss
WHERE
    question = 'Q01'
        AND (institution LIKE '%Manchester%')
GROUP BY institution;
