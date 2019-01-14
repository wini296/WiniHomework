USE sakila;
SELECT * FROM actor;
#1a. Display the first and last names of all actors from the table `actor`.
SELECT first_name, last_name 
FROM actor;

#1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.

SELECT CONCAT (first_name, ' ', last_name) as 'Actor Name'
FROM actor;

#2a.You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?

SELECT actor_id, first_name, last_name FROM actor 
WHERE first_name = "Joe";

# 2b. Find all actors whose last name contain the letters `GEN`:

SELECT * FROM actor 
WHERE last_name LIKE '%GEN%';

# 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:

SELECT last_name, first_name, actor_id, last_update FROM actor 
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

# 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:

SELECT country_id, country 
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

#3a You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table `actor` 
# named `description` and use the data type `BLOB` (Make sure to research the type `BLOB`, as the difference between it and `VARCHAR` are significant).
ALTER TABLE actor
ADD description BLOB NOT NULL;

#3b Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.

ALTER TABLE actor 
DROP COLUMN description;

#4a List the last names of actors, as well as how many actors have that last name.

SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name;

#4b List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
HAVING COUNT(last_name)  > 1;

#4c The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
SELECT * FROM actor WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

UPDATE actor 
SET first_name = "HARPO"
WHERE actor_id = 172;

# 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.

SELECT * FROM actor WHERE first_name = "HARPO" AND last_name = "WILLIAMS";

UPDATE actor
SET first_name = "GROUCHO"
WHERE actor_id = 172;

SELECT * FROM actor WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

#5a You cannot locate the schema of the `address` table. Which query would you use to re-create it?
SHOW CREATE TABLE actor;

SELECT * FROM sakila.staff;

#6a Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
SELECT staff.first_name, staff.last_name, address.address
FROM staff
LEFT JOIN address
ON staff.address_id = address.address_id;

#6b Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.

SELECT first_name, last_name, SUM(payment.amount) AS "Total Amount"
FROM staff
LEFT JOIN payment
ON staff.staff_id = payment.staff_id
AND payment_date like '2005-08%'
GROUP BY staff.staff_id;

#6c List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.

SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM actor;

select count(b.actor_id) as 'number of actors', a.title
from film a 
inner join film_actor b on a.film_id = b.film_id
group by a.title;



SELECT title, (SELECT COUNT(*) FROM inventory WHERE film.film_id = inventory.film_id ) AS 'Number of Copies'
FROM film;


#6d.
#How many copies of the film `Hunchback Impossible` exist in the inventory system?

SELECT * FROM film WHERE title = "Hunchback Impossible";

#6e
#Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT * FROM customer;
SELECT * FROM payment;

select b.first_name, b.last_name, sum(a.amount) as 'Total Amount Paid' 
from payment a 
inner join customer b on a.customer_id = b. customer_id
group by b.last_name;


#7a
#The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
#As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. 
#Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.
select * from film;
select * from language;

SELECT title 
from film
where title like 'k%' or title like 'Q%'
and language_id in 
(
select language_id 
from language
where name = 'english'
);


#7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
SELECT first_name, last_name 
FROM actor
WHERE actor_id IN
	(
	SELECT actor_id 
    FROM film_actor
	WHERE film_id IN
		(
		SELECT actor_id 
        FROM film 
		WHERE title = "Alone Trip"
		)
	);

#7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. 
#Use joins to retrieve this information.

select * from country;
select * from customer;
select * from address;
select * from city;

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
INNER JOIN address  ON customer.customer_id = address.address_id
INNER JOIN city on address.address_id = city.city_id
INNER JOIN country on country.country_id = country.country_id
WHERE country.country = "Canada";

#7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.
select * from film;
select * from film_category;
select * from category;

SELECT title
FROM film 
WHERE film_id IN
  (
   SELECT film_id 
   FROM film_category
   WHERE category_id IN
    (
     SELECT category_id 
     FROM category
     WHERE name = 'Family'
     )
	);
    
#7e Display the most frequently rented movies in descending order.

SELECT title, rental_duration 
FROM film
ORDER BY rental_duration DESC;

#7f. Write a query to display how much business, in dollars, each store brought in.
select * from store;
select * from staff;
select * from payment;
inventory

SELECT SUM(payment.amount) AS sales, store.store_id
FROM payment
JOIN staff
USING (staff_id)
JOIN store
USING (store_id)
GROUP BY store_id;

#7g. Write a query to display for each store its store ID, city, and country.
SELECT * FROM store;
SELECT * FROM city; 
SELECT * FROM country;


SELECT store.store_id, city.city, country.country
FROM store
JOIN address
USING (address_id)
JOIN city 
USING (city_id)
JOIN country 
USING (country_id);

#7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM inventory;
SELECT * FROM payment;
SELECT * FROM rental;

select category.name as genres, sum(payment.amount) as total
from payment
join rental
using(rental_id)
join inventory
using(inventory_id)
join film_category
using(film_id)
join category
using(category_id)
group by category.name
order by total desc
limit 5;

#8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
#Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.

create view top_five_genres as select category.name as genres, sum(payment.amount) as total
from payment
join rental
using(rental_id)
join inventory
using(inventory_id)
join film_category
using(film_id)
join category
using(category_id)
group by category.name
order by total desc
limit 5;



#8b. How would you display the view that you created in 8a?
SELECT * FROM top_five_genres;

#8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.
drop view top_five_genres;

