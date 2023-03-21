USE sakila;

# 1. List the number of films per category.
SELECT c.name AS category, COUNT(f.film_id) AS num_films 
FROM category AS c 
JOIN film_category AS f ON c.category_id = f.category_id 
GROUP BY c.name 
ORDER BY c.name;

# 2. Display the first and the last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, a.address 
FROM staff AS s
LEFT JOIN address AS a
ON s.address_id = a.address_id
ORDER BY last_name;

# 3. Display the total amount rung up by each staff member in August 2005.
SELECT s.first_name, s.last_name, SUM(p.amount) AS total_amount 
FROM staff AS s
LEFT JOIN payment AS p ON s.staff_id = p.staff_id
WHERE p.payment_date >= '2005-08-01' AND p.payment_date < '2005-09-01'
GROUP BY s.staff_id
ORDER BY s.last_name;

# If I also want to display the staff members that have not rung up any payments in August.
SELECT s.first_name, s.last_name, SUM(p.amount) AS total_amount
FROM staff AS s
LEFT JOIN payment AS p ON s.staff_id = p.staff_id 
                             AND p.payment_date >= '2005-08-01' 
                             AND p.payment_date < '2005-09-01'
GROUP BY s.staff_id
ORDER BY s.last_name;

# 4. List all films and the number of actors who are listed for each film.
SELECT f.title AS film_title, COUNT(fa.actor_id) AS num_actors 
FROM film AS f
# I also want the films that have no actors listed hence LEFT JOIN with table film on the left.
LEFT JOIN film_actor AS fa ON f.film_id = fa.film_id
GROUP BY f.title
ORDER BY num_actors;

# 5. Using the payment and the customer tables as well as the JOIN command, list the total amount 
# paid by each customer. List the customers alphabetically by their last names.
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_paid
FROM customer AS c
# I use a LEFT JOIN with table customer on the left to ensure that all customers are included in the
# results, even if they have not made any payments. 
LEFT JOIN payment AS p ON c.customer_id = p.customer_id
GROUP BY c. first_name, c.last_name
ORDER BY c.last_name;