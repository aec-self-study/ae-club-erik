with customer_orders as (
    select
        customer_id, 
        count(*) as number_of_orders,
        min(created_at) as first_order_at
        from `analytics-engineers-club.coffee_shop.orders` as orders
)


select 
    customers.id as customer_id
    customers.name,
    customers.email,
    customers_orders.first_order_at,
    customer_orders.number_of_orders
from `analytics-engineers-club.customers` as customers
left join customer_orders
    on customers.id = customer_orders.customer_id