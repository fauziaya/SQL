/* 
 	Count the number of users per city
 */
select city, 
	   count(customer_id) number_of_users
from batch_19.customer1
group by city


/* 
 	Find female users who is using Gmail in Jakarta
 */
select customer_id, 
	   gender, 
	   email,
	   city
from batch_19.customer1
where email = 'Gmail' and city = 'Jakarta' and gender = 'Female'
order by 1 


/* 
 	Find the first user per city
 */
select c.city, 
	   min(t.created_at) first_user
from batch_19.customer1 c
left join batch_19.transaction t on c.customer_id = t.customer_id
group by 1


/* 
  	Count total sales per store
 */
select store_id, 
	   count(total) total_sales
from batch_19.transaction 
group by 1


/* 
  	Find top 5 product sold
 */
select product_id, 
	   max(quantity) number_product_sold
from batch_19.transaction
group by 1


/* 
  	Find the loyal customer
 */
select customer_id, 
	   count(total) loyal_customer_sales
from batch_19.transaction
group by 1
order by 2 desc


/* 
  	Count total sales per city
 */
select c.city, 
	   count(t.total) total_sales
from batch_19.customer1 c
left join batch_19.transaction t on c.customer_id = t.customer_id
group by 1