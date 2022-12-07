
with table1 as(
	select p.pizza_id,
		p.pizza_type_id,
		t.name,
		t.category,
		p.size,
		t.ingredients,
		p.price,
		od.quantity,
		(od.quantity * p.price) total_sales,
		od.order_details_id,
		od.order_id,
		o.date,
		o.time
	from pizzas p
	left join pizza_types t 
		on p.pizza_type_id = t.pizza_type_id
	left join pizza_order_details od 
		on p.pizza_id = od.pizza_id 
	left join pizza_orders o 
		on od.order_id = o.order_id
	order by 1
)
/*
	Count Total Quantity Ordered Per date
 */
select 
	date,
	count(quantity) quantity_ordered_per_date
from table1
group by date


/*
	Count Total Quantity Ordered Per time
 */
select 
	time,
	count(quantity) quantity_ordered_per_time
from table1
group by time


/*
	Count Total Quantity Ordered Per Pizza Category
 */
select 
	category,
	count(quantity) quantity_ordered_per_category
from table1
group by category


/*
	Count Total Orders by Pizza Type
 */
select 
	pizza_type_id,
	count(quantity) type_ordered
from table1
group by pizza_type_id


/*
	Count quantity Orders by Size
 */
select 
	size,
	sum(quantity) size_ordered
from table1
group by size


/*
	Count Total Sales Ordered Each Day
 */
select 
	date,
	sum(quantity) total_sales_per_day
from table1
group by date


/*
	Count Total Sales Per Pizza Name
 */
select 
	name,
	sum(total_sales) total_sales_per_pizza
from table1
group by name




