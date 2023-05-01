select 
	orders.id as order_id
	, date_trunc(orders.created_at, week) as week
	, products.category
	, customers.id
	, case when 
		count(distinct orders.id) over(partition by customers.id) > 1 then 'Returning'
		else 'New'
		end as customer_categorization
	, sum(product_prices.price / 100) as total_sales
	 from {{ source('coffee_shop', 'orders') }} as orders
left join {{ source('coffee_shop', 'order_items') }}   as order_items
	on orders.id=order_items.order_id
left join {{ source('coffee_shop', 'products') }}  as products
	on products.id=order_items.product_id
left join {{ source('coffee_shop', 'customers') }}   as customers
	on orders.customer_id=customers.id
left join {{ source('coffee_shop', 'product_prices') }}   as product_prices
  	on order_items.product_id = product_prices.product_id
  	and orders.created_at between product_prices.created_at and product_prices.ended_at
  group by 
1,2,3,4