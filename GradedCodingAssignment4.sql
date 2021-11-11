Create database if not exists TravelCompany;
use TravelCompany;

create table if not exists Passenger(
	Passenger_name varchar(50),
    category varchar(10),
    Gender varchar(5),
    Boarding_city varchar(50),
    Destination_city varchar(50),
    Distance int,
    Bus_type varchar(10)
       );
   
create table if not exists price(
	Bus_type varchar(10),
    distance int,
    price int);

insert into passenger values ( 'Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
insert into passenger values ('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
insert into passenger values ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
insert into passenger values ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
insert into passenger values ('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper');
insert into passenger values ('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');
insert into passenger values ('Hemant', 'Non-AC', 'M', 'panaji', 'Mumbai', 700, 'Sleeper');
insert into passenger values ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');
insert into passenger values ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting' );


insert into price values ('Sleeper', 350, 770);
insert into price values ('Sleeper', 500, 1100);
insert into price values ('Sleeper', 600, 1320);
insert into price values ('Sleeper', 700, 1540);
insert into price values ('Sleeper', 1000, 2200);
insert into price values ('Sleeper', 1200, 2640);
insert into price values ('Sleeper', 350, 434);
insert into price values ('Sitting', 500, 620);
insert into price values ('Sitting', 500, 620);
insert into price values ('Sitting', 600, 744);
insert into price values ('Sitting', 700, 868);
insert into price values ('Sitting', 1000, 1240);
insert into price values ('Sitting', 1200, 1488);
insert into price values ('Sitting', 1500, 1860);

#3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?

select gender, count(gender)  from passenger where distance >= 600 group by gender ;

#4) Find the minimum ticket price for Sleeper Bus.

select min(price) as Minimum_price from price where bus_type = 'sleeper';

#5) Select passenger names whose names start with character 'S'

select passenger_name from passenger where passenger_name like 'S%';

#6) Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output

select passenger_name,  Boarding_city, destination_city, p2.bus_type, p2.price 
	from passenger p1  left join price p2
    ON p1.bus_type = p2.bus_type and p1.distance = p2.distance;
    
        
#7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a distance of 1000 KM s    
    
 select p1.passenger_name, p2.price from passenger p1, price p2
	where p1.bus_type = 'Sitting' AND p1.distance >=1000;
    
#8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?    
    
select bus_type, price from price 
    where distance = (select distance from passenger
							where Boarding_City = 'panaji'AND Destination_City = 'bengaluru'
                            AND Passenger_name = 'Pallavi');
    
    
#9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.    

select distance from passenger 
	group by distance 
    having count(distance) = 1
    order by distance desc; 

#10) Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables

select passenger_name, round(((distance/(select sum(distance)from passenger)) * 100),2) as Percentage_distance 
		from passenger;

#11) Display the distance, price in three categories in table Price
#a) Expensive if the cost is more than 1000
#b) Average Cost if the cost is less than 1000 and greater than 500
#c) Cheap otherwise

select distance, price, 
		case 
        when price >1000 then 'Expensive'
        when price between 500 and 1000 then 'Average Cost'
        else 'Cheap'
        End as category
   from price;     