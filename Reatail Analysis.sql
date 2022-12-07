/*
	count the number of users per country
*/
SELECT country, 
	   COUNT(userid) number_of_user
FROM user_tab_Users_Sales
GROUP BY country


/*
	count the number of orders per country
*/
select u.country, 
	   count(distinct o.orderid) number_of_order
from user_tab_Users_Sales u
left join order_tab_Users_Sales o 
on u.userid = o.userid 
group by 1
order by 1 desc


/* 
	find the first order date of each user
*/
select userid, 
	   min(order_time) first_order_time
from order_tab_Users_Sales
group by 1
order by 2 


/* 
	find the number of users who made their first order 
	in each country and each day
*/
select o.first_order_time, 
	   u.country, 
	   count(distinct o.userid) total_users
from (
	select userid, min(order_time) first_order_time
	from order_tab_Users_Sales
	group by 1
	) o
left join user_tab_Users_Sales u 
on o.userid = u.userid 
group by 1,2
order by 1,2


/* 
	find the first order GMV of each user. 
	If there is a tie, use the order with the lower orderid
*/
select userid,
	   gmv 
from (
	select userid, 
	gmv,
	min(order_time) first_order_time, 
	min(orderid) first_order_id
	from order_tab_Users_Sales
	group by 1,2
	order by 2
	) o

	
/* 
	count total gmv per country
*/
select u.country,
count(o.gmv) total_gmv
from user_tab_Users_Sales u
left join order_tab_Users_Sales o 
on u.userid = o.userid
group by 1
order by 2 desc


/* 
	count the number of item have 1 price tag
*/
select count(distinct itemid)
from (
	select itemid
	from (
		select itemid, gmv
		from order_tab_Users_Sales
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
from user_tab_Users_Sales u
left join order_tab_Users_Sales o 
on u.userid = o.userid 
where o.order_time < u.register_time 

*/ There are many users buy before register */


/* 
	count the user buy before register
*/
select count(distinct o.userid)
from user_tab_Users_Sales u
right join order_tab_Users_Sales o 
on u.userid = o.userid 

*/ There are 10.181 users exsist in order tab but did not in user tab */

