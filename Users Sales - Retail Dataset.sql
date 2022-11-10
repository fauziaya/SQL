/*
	count the number of users per country
*/
SELECT country, 
	COUNT(userid) number_of_user
	FROM batch_19.fafa_usertab
GROUP BY country


/*
	count the number of orders per country
*/
select  u.country, count(distinct o.orderid) number_of_order
from batch_19.fafa_usertab u
left join batch_19.fafa_ordertab o on u.userid = o.userid 
group by 1	



/* 
	find the first order date of each user
*/
select userid, min(order_time) first_order_time
from batch_19.fafa_ordertab
group by 1


/* 
	find the number of users who made their first order in each country and each day
*/
select 
	u.country, 
	o.order_time, 
	count(*) number_of_user
from batch_19.fafa_usertab u 
inner join (
  select userid, 
  min(order_time) order_time 
  from batch_19.fafa_ordertab o
  group by userid
	) 
	o on o.userid = u.userid
group by u.country, o.order_time


/* 
	find the first order GMV of each user. If there is a tie, use the order with the lower orderid
*/
select 
	u.userid,
	u.register_time,
	(select o.gmv
        from batch_19.fafa_ordertab o
        where o.userid = u.userid
        order by order_time, orderid
        limit 1
       )
from batch_19.fafa_usertab u


/* 
	count the number of item have 1 price tag
*/
select count(distinct itemid)
from (
	select itemid
	from (
		select itemid, gmv
		from batch_19.fafa_ordertab
		group by 1,2
	) o
	group by 1
	having count(gmv) > 1
) o 

*/ There are 56 items have more than 1 price tag */


/* 
	find the user buy before register
*/
select u.userid
from batch_19.fafa_usertab u
left join batch_19.fafa_ordertab o on u.userid = o.userid 
where o.order_time < u.register_time 

*/ There are many users buy before register */


/* 
	count the user buy before register
*/
select count(distinct o.userid)
from batch_19.fafa_usertab u
right join batch_19.fafa_ordertab o on u.userid = o.userid 

*/ There are 10.181 users exsist in order tab but did not in user tab */