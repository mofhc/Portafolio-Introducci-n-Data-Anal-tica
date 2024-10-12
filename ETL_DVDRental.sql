select count(*)
from actor

select count(*)
from rental r 

select *
from country c 
inner join city cy on c.country_id = cy.country_id 


#analizar la información y proponer esas entidades... de la tabla de hechos.


#Rentas de peliculas
--Rental fct
--cliente
--Direccion
--Pelicula
--Actor
--Categoria
--Lenguaje
--Stock, inventario
--Staff, personal
--Tienda
--Pago


#Cliente, dim_customer
select c.customer_id , c.store_id, c.first_name , c.last_name , c.email, c.activebool , c.create_date  as create_date_customer, 
	   c.active , c.last_update 
from customer c 

#Dirección, dim_adress
select a.address_id ,a.address , a.address2 , a.district , a.postal_code , a.phone, a.last_update as last_update_address, 
	   cty.city , cty.last_update as last_update_city,
	   co.country, co.last_update as last_update_country
from address a 
inner join city cty on a.city_id = cty.city_id 
inner join country co on cty.country_id = co.country_id 

#Película, dim_film
select f.film_id , f.title , f.description , f.release_year, f.rental_duration , f.rental_rate, f.length, f.replacement_cost, f.rating ,
       f.last_update, f.special_features, f.fulltext, l."name" as language_film, l.last_update as lst
from film f 
inner join "language" l on f.language_id = l.language_id 

#Actor, dim_actor
select *
from actor act

#Categoria, dim_category
select *
from category c 

#Lenguaje, dim_languaje
select *
from "language" l 

#Inventario, dim_inventory
select inv.inventory_id , inv.film_id , f.title, 
	   st.*
from inventory inv 
inner join film f on inv.film_id = f.film_id 
inner join store st on st.store_id = inv.store_id 

#Staff, dim_staff
select *
from staff s 

#Tienda, dim_store
select st.store_id , s.first_name, s.last_name, 
	   a.address, a.district, a.city_id, 
	   st.last_update 
from store st 
left join staff s on st.store_id  = s.staff_id 
inner join address a on a.address_id = s.address_id 

#Pagos, payment
select p.payment_id , p.rental_id , c.first_name, c.last_name , concat(s.first_name, s.last_name) as staff_name , p.amount , p.payment_date 
from payment p 
inner join customer c on c.customer_id = p.customer_id 
inner join staff s on s.staff_id  = p.staff_id 


#Tabla de hechos, fct_rental
select r.rental_id , r.customer_id, r.inventory_id , r.staff_id, 
	   1 as film_id, 1 as store_id, 1 as payment_id,
	   r.rental_date , r.return_date, r.last_update
from rental r 

