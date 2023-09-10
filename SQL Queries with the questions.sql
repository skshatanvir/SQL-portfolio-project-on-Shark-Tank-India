select * from md..data

-- total episodes in the Shark Tank India

select max(epno) from md..data
select count(distinct epno) from md..data

-- total pitches pitched by the startups

select count(distinct brand) from md..data

-- total pitches which are converted into deal

select cast(sum(a.converted_not_converted) as float) /cast(count(*) as float) 
from (select amountinvestedlakhs , case when amountinvestedlakhs>0 then 1 else 0 end as converted_not_converted from md..data) a

-- total male contestants in the Shark Tank India

select sum(male) from md..data

-- total female contestants in the Shark Tank India

select sum(female) from md..data

-- gender ratio in the Shark Tank India

select sum(female)/sum(male) from md..data

-- total invested amount by all the Sharks

select sum(amountinvestedlakhs) from md..data

-- avg equity taken by all the Sharks

select avg(a.equitytakenp) from
(select * from md..data where equitytakenp>0) a

-- highest deal given by the Shark

select max(amountinvestedlakhs) from md..data 

-- highest equity taken by the Shark

select max(equitytakenp) from md..data

-- total startups having at least one women

select sum(a.female_count) startups having at least women 
from (select female,case when female>0 then 1 else 0 end as female_count from md..data) a

-- pitches converted into deal which are having at least one woman

select sum(b.female_count) 
from(select case when a.female>0 then 1 else 0 end as female_count ,a.*
from (
(select * from md..data where deal!='No Deal')) a)b

-- avg team members from all over the startups

select avg(teammembers) from md..data

-- average amount invested per deal 

select avg(a.amountinvestedlakhs) amount_invested_per_deal 
from(select * from md..data where deal!='No Deal') a

-- avg age group of contestants

select avgage,count(avgage) cnt from md..data group by avgage order by cnt desc

-- location group of contestants

select location,count(location) cnt from md..data group by location order by cnt desc

-- sector group of contestants

select sector,count(sector) cnt from md..data group by sector order by cnt desc

-- partner deals

select partners,count(partners) cnt from md..data  where partners!='-' group by partners order by cnt desc

-- making the matrix

select * from md..data

select 'Ashnner' as keyy,count(ashneeramountinvested) from md..data where ashneeramountinvested is not null

select 'Ashnner' as keyy,count(ashneeramountinvested) from md..data where ashneeramountinvested is not null AND ashneeramountinvested!=0

SELECT 'Ashneer' as keyy,SUM(C.ASHNEERAMOUNTINVESTED),AVG(C.ASHNEEREQUITYTAKENP) 
FROM (SELECT * FROM md..data  WHERE ASHNEEREQUITYTAKENP!=0 AND ASHNEEREQUITYTAKENP IS NOT NULL) C

select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from

(select a.keyy,a.total_deals_present,b.total_deals from(

select 'Ashneer' as keyy,count(ashneeramountinvested) total_deals_present from md..data where ashneeramountinvested is not null) a

inner join (
select 'Ashneer' as keyy,count(ashneeramountinvested) total_deals from md..data 
where ashneeramountinvested is not null AND ashneeramountinvested!=0) b 

on a.keyy=b.keyy) m

inner join 

(SELECT 'Ashneer' as keyy,SUM(C.ASHNEERAMOUNTINVESTED) total_amount_invested,
AVG(C.ASHNEEREQUITYTAKENP) avg_equity_taken
FROM (SELECT * FROM md..data  WHERE ASHNEEREQUITYTAKENP!=0 AND ASHNEEREQUITYTAKENP IS NOT NULL) C) n

on m.keyy=n.keyy

-- which is the startup in which the highest amount has been invested in each domain/sector

select c.* from 
(select brand,sector,amountinvestedlakhs,rank() over(partition by sector order by amountinvestedlakhs desc) rnk 

from md..data) c

where c.rnk=1
