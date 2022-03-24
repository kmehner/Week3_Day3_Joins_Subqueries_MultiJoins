
-- 1. List all customers who live in Texas (use Joins) 
-- There are 5 customers who live in texas

select * from address     -- address_id 
-- district = 'texas'

select * from customer    -- address_id
-- first_name, last_name 

select customer.first_name, customer.last_name, address.district 
from customer 
full join address 
on customer.address_id = address.address_id 
where district = 'Texas'



-- 2. Get all payments above $6.99 with the Customer's full name 

select * from customer   -- customer_id

select * from payment    -- customer_id 
-- amount > 6.99

select customer.first_name, customer.last_name, payment.amount 
from customer
full join payment 
on customer.address_id = address_id 
where amount > 6.99;


-- 3. Show all customer names who have made payments over $175 (use subqueries)

select * from customer -- (customer_id)

select * from payment  -- (customer_id)
-- amount > 175


select first_name, last_name 
from customer
where customer_id in(
	select customer_id 
	from payment 
	where amount > 175
)


-- 4. List all customers who live in Argentina (use the city table)
-- There are 13 customers who live in Argentina

-- checking country (primary - country_id)
select * from country

-- checking city (primary - city_id)(foreign - country-id)
select * from city

-- checking address (primary - address_id)
select * from address 

-- checking customer (primary - customer_id)(foreign - address_id)
-- Contains first and last name 
select * from customer


-- full join customer, address, city, and country
SELECT customer.first_name,customer.last_name,country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Argentina';


-- 5. Which film category has the most movies in it? 
-- Sports has the most the most movies at 74

select * from film_category  -- (category-id)(film_id)

select * from category -- (category_id)

-- Full query
select category_id, count(category_id)
from film_category 
group by category_id  
having count(category_id) = (
select max(my_count) as total
from (select category_id, count(category_id) my_count
		from film_category
		group by category_id) as wow)

	
-- Inner query		
select max(my_count) as total
from (select category_id, count(category_id) my_count
		from film_category
		group by category_id) as wow
		
		
-- 6. What film has the most actors in it? 
-- Lambs of Cincinatti has 16 actors in it
	
select * from film_actor 
		
select film_id, count(film_id)
from film_actor
group by film_id 
having count(film_id) = (
	select max(my_count) as total
		from (select film_id, count(film_id) my_count
		from film_actor 
		group by film_id) as wow
)

-- inner query (counting how many times the film appears since actor ID appears 1 time per film)
select max(my_count) as total
from (select film_id, count(film_id) my_count
		from film_actor 
		group by film_id) as wow
		

-- 7. Which actor has been in the least movies? 
-- Emily Dee is the least at 14 movies
		
select actor_id, count(actor_id)
from film_actor
group by actor_id 
having count(actor_id) = (
	select min(my_count) as total
		from (select actor_id, count(actor_id) my_count
		from film_actor 
		group by actor_id) as wow
)
		
-- inner query 	(counting min amount of times an actor_id occurs)
select min(my_count) as total
from (select actor_id, count(actor_id) my_count
		from film_actor 
		group by actor_id) as wow
		
		
-- 8. Which country has the most cities
-- India has the most cities at 60

select country_id, count(country_id) 
from city 
group by country_id  
having count(country_id) = (
	select max(country_count) as total 
		from (select country_id, count(country_id) as country_count 
		from city
		group by country_id) as wow
)

-- inner query  (counting max times a country_id appears since each city_id appears once per country)
select max(country_count) as total 
from (select country_id, count(country_id) as country_count 
		from city
		group by country_id) as wow
		
	
-- 9. List the actors who have been in more than 3 films but less than 6
-- Thought the minimum amount an actor has been in films is 14? Didn't make it more advanced for this one.
		

select actor_id, count(actor_id) 
from film_actor 
group by actor_id 
having count(actor_id) between 3 and 6
order by actor_id desc




		
		
		
