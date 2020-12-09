/* 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
2.	Display the number of matches conducted at each stadium with stadium name, city from the database.
3.	In a given stadium, what is the percentage of wins by a team which has won the toss?
4.	Show the total bids along with bid team and team name.
5.	Show the team id who won the match as per the win details.
6.	Display total matches played, total matches won and total matches lost by team along with its team name.
7.	Display the bowlers for Mumbai Indians team.
8.	How many all-rounders are there in each team, Display the teams with more than 4 
all-rounder in descending order */

-- 1

with win as (
select BIDDER_ID, 
sum(case when BID_STATUS like '%won%' then 1 else null end) as won 
from `ipl_bidding_details` group by BIDDER_ID)
select a.BIDDER_ID, 
(win.won/count(a.BID_STATUS))*100 as win_percentage 
from ipl_bidding_details a 
join win on a.BIDDER_ID = win.BIDDER_ID 
group by a.BIDDER_ID 
order by win_percentage desc;

-- 2

select b.STADIUM_ID, a.STADIUM_NAME, a.city, 
count(b.STATUS) as no_of_matches from ipl_stadium a 
join ipl_match_schedule b on a.stadium_id = b.stadium_id 
where b.STATUS like '%Completed%' group by 
a.STADIUM_NAME, a.city;

-- 3

with wins as(
select MATCH_ID from ipl_match 
where TOSS_WINNER = MATCH_WINNER),
total as (
select STADIUM_ID, 
count(MATCH_ID)cnt 
from ipl_match_schedule group by STADIUM_ID)
select a.STADIUM_ID, 
(count(a.MATCH_ID)/total.cnt)*100 as win_percent 
from ipl_match_schedule a 
join wins on a.MATCH_ID = wins.MATCH_ID
join total on a.STADIUM_ID= total.STADIUM_ID 
group by a.STADIUM_ID;

-- 4

select b.BID_TEAM, c.TEAM_NAME, 
count(a.NO_OF_BIDS) total_bids 
from ipl_bidder_points a join 
ipl_bidding_details b 
on a.BIDDER_ID = b.BIDDER_ID 
join ipl_team c on b.BID_TEAM = c.TEAM_ID
group by BID_TEAM;

-- 5

select a.TEAM_ID,a.TEAM_NAME, b.WIN_DETAILS
from ipl_team a
join ipl_match b
on substring(b.WIN_DETAILS, 6, 2) = substring(a.REMARKS, 1, 2);

-- 6

with won as (
select case when MATCH_WINNER = 1 then TEAM_ID1 else TEAM_ID2 end as teams, count(*) matches_won from ipl_match group by teams),
ma1 as (
select TEAM_ID1, count(TEAM_ID1) as onee from ipl_match group by TEAM_ID1),
ma2 as (
select TEAM_ID2, count(TEAM_ID2) as two from ipl_match group by TEAM_ID2)
select won.teams, c.TEAM_NAME, ma1.onee + ma2.two as total_matches, won.matches_won, (ma1.onee + ma2.two) - won.matches_won as lost
from ma1 join ma2 on ma1.TEAM_ID1 = ma2.TEAM_ID2 join won on ma2.TEAM_ID2  = won.teams join ipl_team c on won.teams = c.TEAM_ID;

-- 7 
select a.PLAYER_ID, b.PLAYER_NAME from ipl_team_players a join ipl_player b on a.PLAYER_ID = b.PLAYER_ID where a.PLAYER_ROLE like '%Bowler%' and substring(a.REMARKS,8,2) = 'MI';

-- 8 
select a.TEAM_ID, b.TEAM_NAME, count(PLAYER_ID) all_rounders from ipl_team_players a join ipl_team b on a.TEAM_ID = b.TEAM_ID
where PLAYER_ROLE like '%round%' group by TEAM_ID having all_rounders> 4 order by all_rounders desc ;

-- tables
select * from `ipl_bidder_details`;
select * from `ipl_bidder_points`;
select * from `ipl_bidding_details`;
select * from `ipl_match`;
select * from `ipl_match_schedule`;
select * from `ipl_player`;
select * from `ipl_stadium`;
select * from `ipl_team`;
select * from `ipl_team_players`;
select * from `ipl_team_standings`;
select * from `ipl_tournament`;
select * from `ipl_user`;








