-- Identify the most pizza size ordered ?

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;



-- Identify the highest - priced pizza ?


SELECT pizza_types.name, pizzas.price
FROM pizza_types JOIN pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select name, revenue from 

(SELECT 
    category, 
    name, 
    revenue,
    RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rn
FROM 
    (SELECT 
        pizza_types.category, 
        pizza_types.name,
        SUM(order_details.quantity * pizzas.price) AS revenue
     FROM 
        pizza_types
     JOIN 
        pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
     JOIN 
        order_details ON order_details.pizza_id = pizzas.pizza_id
     GROUP BY 
        pizza_types.category, pizza_types.name) AS a) as b
	where rn <= 3;
    
    
    -- List the top most ordered pizzas type 
-- along with their quantities

SELECT pizza_types.name,
       SUM(order_details.quantity) AS total_quantity
FROM pizza_types
JOIN pizzas
  ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
  ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC
LIMIT 5;




    
        
