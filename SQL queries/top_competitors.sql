-- Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard!
-- Write a query to print the respective hacker_id and name of hackers who achieved full scores
-- for more than one challenge. Order your output in descending order by the total number of challenges
-- in which the hacker earned a full score.
-- If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

select h.hacker_id, h.name
from submissions s
join challenges ch
    on s.challenge_id = ch.challenge_id
join difficulty d
    on ch.difficulty_level = d.difficulty_level
join hackers h
    on s.hacker_id = h.hacker_id
where s.score = d.score
    and ch.difficulty_level = d.difficulty_level
group by h.hacker_id, h.name
    having count(s.hacker_id) > 1
order by count(s.hacker_id) desc, s.hacker_id asc;
