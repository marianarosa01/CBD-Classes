/* Database de um aeroporto 
TABELAS: voo; reserva; clientes; companhias; piloto */



create table passagers (
    cc int primary key,
    passager_name    text,
    dateBirth timestamp,
    country text,
    email text,
    emergency_contacts map<text,int>);

create table flight ( 
    flight_number int,
    airplane_model text,
    airlines text,
    city_takeover text,
    city_departure text,
    flight_route list<text,text>,
    number_of_landovers int
    date_flight timestamp,
    primary key(flight_number, airplane_model)
);


create table booking (
    booking_code int primary key,
    cc_passagers int,
    flight_route_departure_arrival map<text,text>,  
    date_flight date,
);


insert into passagers (cc, passager_name, dateBirth, country, email, emergency_contacts) values (11234567, 'Susana Rocha', '1970-09-10', 'Portugal', 'susanarocha@sapo.pt', {'+351':968574112, '+351':96587414});
insert into passagers (cc, passager_name, dateBirth, country, email, emergency_contacts) values (14785269, 'Filipe Sousa', '1970-02-01', 'Portugal', 'filipesousa@sapo.pt', {'+351':968782312, '+351':91526987});
insert into passagers (cc, passager_name, dateBirth, country, email, emergency_contacts) values (11234567, 'Anita Almeida', '1975-10-20', 'Portugal', 'anita_almeida@sapo.pt', {'+351':96517845});
insert into passagers (cc, passager_name, dateBirth, country, email, emergency_contacts) values (11234561, 'Valter Rosa', '1970-10-13', 'Portugal', 'rosa@sapo.pt', {'+351':965823694});
insert into passagers (cc, passager_name, dateBirth, country, email, emergency_contacts) values (595421456, 'Nadia Oli', '2000-01-20', 'Singapore', 'nadia123@gmail.com', {'+65': 97821958})
insert into passagers (cc, passager_name, dateBirth, country, email, emergency_contacts) values (14785114, 'Maria Silva', '2001-06-10', 'Portugal', 'mariasilva@sapo.pt', {'+351':96321478})
insert into passagers (cc, passager_name, dateBirth, country, email, emergency_contacts) values (12347101, 'Pietro Fassi', '2001-12-23', 'Italy', 'pietrofassi@yahoo.com', {'+39':3486037335, '39':3703626041})
insert into passagers (cc, passager_name, dateBirth, country, email, emergency_contacts) values (74185263, 'Tchiban Melo', '1999-04-17', 'Cape Verde', 'tchiban@sapo.pt', {'238':9987734})
insert into passagers (cc, passager_name, dateBirth, country, email, emergency_contacts) values (14785203, 'Teresa Silva', '1973-12-23', 'Portugal', 'teresasilva@sapo.pt', {965186167})
insert into passagers (cc, passager_name, dateBirth, country, email, emergency_contacts) values (547515488, 'Isabel Aguiar', '1980-09-10', 'Portugal', 'isabelaguiar@sapo.pt', {968574002, 912387414})
insert into passagers (cc, passager_name, dateBirth, country, email, emergency_contacts) values (748521474, 'Sara Camara', '1971-11-05', 'Portugal', 'saracamara@sapo.pt', {968574112})
insert into passagers (cc, passager_name, dateBirth, country, email, emergency_contacts) values (128575687, 'Julia Faria', '2003-05-10', 'Portugal', 'faria_julia@sapo.pt', {968574777})


insert into flight (flight_number, airplane_model, airlines, city_takeover, city_departure, flight_route,number_of_landovers,date_flight) values (1, 'A321neo', 'SATA internacional', 'Porto', 'Ponta Delgada', ['Porto', 'Ponta Delgada'], 0, '2021-12-18');
insert into flight (flight_number, airplane_model, airlines, city_takeover, city_departure, flight_route,number_of_landovers,date_flight) values (2, 'A321neo', 'SATA internacional', 'Porto', 'Boston', ['Porto', 'Ponta Delgada','Boston'], 1, '2021-12-18');
insert into flight (flight_number, airplane_model, airlines, city_takeover, city_departure, flight_route,number_of_landovers,date_flight) values (3, 'A220', 'SATA internacional', 'Las Palmas', 'Lisbon', ['Las Palmas', 'Ponta Delgada', ' Lisbon'], 1, '2021-12-19');
insert into flight (flight_number, airplane_model, airlines, city_takeover, city_departure, flight_route,number_of_landovers,date_flight) values (4, 'Boeing 777', 'Emirates Airlines', 'Lisbon', 'Dubai', ['Lisbon', 'Milan', 'Budapest', 'Dubai'], 2, '2021-12-19');
insert into flight (flight_number, airplane_model, airlines, city_takeover, city_departure, flight_route,number_of_landovers,date_flight) values (5, 'A200', 'TAP Air Portugal', 'Lisbon', 'Prague', ['Lisbon', 'Prague'], 0, '2021-12-20');
insert into flight (flight_number, airplane_model, airlines, city_takeover, city_departure, flight_route,number_of_landovers,date_flight) values (6, 'Q400', 'SATA Azores Airlines', 'Santa Cruz das Flores', 'Ponta Delgada', ['Santa Cruz das Flores', 'Angra do Heroísmo', 'Ponta Delgada'], 1, '2021-12-20');
insert into flight (flight_number, airplane_model, airlines, city_takeover, city_departure, flight_route,number_of_landovers,date_flight) values (7, 'Boeing 737', 'Ryanair', 'Rome', 'Lisbon', ['Rome', 'Lisbon'], 0, '2021-12-20');
insert into flight (flight_number, airplane_model, airlines, city_takeover, city_departure, flight_route,number_of_landovers,date_flight) values (8, 'A321neo', 'SATA internacional', 'Ponta Delgada', 'Ilha do Sal - Cape Verde', ['Ponta Delgada', 'Boa Vista', 'Sal'], 1, '2021-12-20');
insert into flight (flight_number, airplane_model, airlines, city_takeover, city_departure, flight_route,number_of_landovers,date_flight) values (9, 'A320', 'SATA internacional', 'Ponta Delgada', 'Porto', ['Ponta Delgada','Porto'], 0, '2021-12-21');
insert into flight (flight_number, airplane_model, airlines, city_takeover, city_departure, flight_route,number_of_landovers,date_flight) values (10, 'Boeing 800', 'Ryanair', 'Helsinki', 'Paris', ['Helsinki', 'Paris'], 0, '2021-12-21');
insert into flight (flight_number, airplane_model, airlines, city_takeover, city_departure, flight_route,number_of_landovers,date_flight) values (11, 'Boeing 737', 'Ryanair', 'Eindhoven', 'Ponta Delgada', ['Eindhoven', 'Lisbon', 'Ponta Delgada'], 1, '2021-12-21');
insert into flight (flight_number, airplane_model, airlines, city_takeover, city_departure, flight_route,number_of_landovers,date_flight) values (12, 'A220', 'SATA internacional', 'Lisbon', 'Ponta Delgada', ['Lisbon', 'Ponta Delgada'], 0, '2021-12-21');


insert into booking (booking_code, cc_passagers,flight_route_departure_arrival, date_flight) values (1,11234567, {'Porto':'Ponta Delgada'},'2021-12-18' );
insert into booking (booking_code, cc_passagers,flight_route_departure_arrival, date_flight) values (2,14785269, {'Porto':'Boston'},'2021-12-18' );
insert into booking (booking_code, cc_passagers,flight_route_departure_arrival, date_flight) values (3,11234561, {'Las Palmas':'Lisbon'},'2021-12-19' );
insert into booking (booking_code, cc_passagers,flight_route_departure_arrival, date_flight) values (4,11234561, {'Lisbon':'Dubai'},'2021-12-19' );
insert into booking (booking_code, cc_passagers,flight_route_departure_arrival, date_flight) values (5,595421456, {'Lisbon':'Prague'},'2021-12-20' );
insert into booking (booking_code, cc_passagers,flight_route_departure_arrival, date_flight) values (7,14785114, {'Santa Cruz das Flores':'Ponta Delgada'},'2021-12-20' );
insert into booking (booking_code, cc_passagers,flight_route_departure_arrival, date_flight) values (8,12347101, {'Rome':'Lisbon'},'2021-12-20' );
insert into booking (booking_code, cc_passagers,flight_route_departure_arrival, date_flight) values (9,74185263, {'Ponta Delgada':'Ilha do Sal - Cape Verde'},'2021-12-20' );
insert into booking (booking_code, cc_passagers,flight_route_departure_arrival, date_flight) values (10,547515488, {'Helsinki':'Paris'},'2021-12-21' );
insert into booking (booking_code, cc_passagers,flight_route_departure_arrival, date_flight) values (11,748521474, {'Eindhoven':'Ponta Delgada'},'2021-12-21' );
insert into booking (booking_code, cc_passagers,flight_route_departure_arrival, date_flight) values (12,128575687, {'Lisbon':'Ponta Delgada'},'2021-12-21' );


create table airlines (
    id int primary key,
    name text,
    airplanes list <text>
);


insert into airlines (id, name, airplanes) values (1, 'SATA internacional', ['A321neo', 'A320','A220']);
insert into airlines (id, name, airplanes) values (2, 'SATA Azores Airlines', ['Q400', 'Q200']);
insert into airlines (id, name, airplanes) values (3, 'TAP Air Portugal', ['A321neo', 'A320','A220']);
insert into airlines (id, name, airplanes) values (4, 'Ryanair', ['Boeing 737', 'Boeing 800']);
insert into airlines (id, name, airplanes) values (5, 'Emirates Airlines', ['Boeing 777', 'A380']);
insert into airlines (id, name, airplanes) values (6, 'American Airlines', ['Boeing 777', 'Airbus 321 neo','Boeing 737']);
insert into airlines (id, name, airplanes) values (7, 'Delta', ['Boeing 777', 'A380']);

create table pilot (
    id_license int primary key, 
    pilot_name text,
    works_to_aircompany text,
    work_days set<text>
);

insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (1, 'João Rodrigues', 'TAP Air Portugal', {'Monday', 'Wednesday', 'Saturday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (2, 'Elthon John', 'Emirates Airlines', {'Monday', 'Tuesday', 'Saturday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (3, 'Maria João Porteiro', 'SATA Azores Airlines', {'Tuesday', 'Wednesday', 'Friday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (4, 'Vasco Machado', 'SATA internacional', {'Monday', 'Thursday', 'Sunday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (5, 'João Matos', 'SATA Azores Airlines', {'Thursday', 'Friday', 'Saturday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (6, 'Luís Silva', 'TAP Air Portugal', {'Monday', 'Thursday', 'Saturday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (7, 'Gisela Leal', 'TAP Air Portugal', {'Thurday', 'Friday', 'Saturday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (8, 'Zendaya Cannes', 'American Airlines', {'Monday', 'Tuesday', 'Saturday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (9, 'John Cena', 'American Airlines', {'Monday', 'Wednesday', 'Sunday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (10, 'Mary Cruz', 'American Airlines', {'Tuesday', 'Friday', 'Sunday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (11, 'Ricardo Rodriguez', 'Emirates Airlines', {'Monday', 'Tuesday', 'Wednesday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (12, 'Ed Mosby', 'Ryanair', {'Monday', 'Wednesday', 'Saturday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (13, 'Zack Simpson', 'Ryanair', {'Tuesday', 'Wednesday', 'Friday'});
insert into pilot (id_license, pilot_name, works_to_aircompany, work_days) values (14, 'Brandon Michell', 'Ryanair', {'Monday', 'Tuesday', 'Sunday'});

--- Create index on table pilots in column 'Pilot_name'
create index pilots on pilot(pilot_name);

-- Create index on table airlines in column 'airplanes'
create index fleet on airlines(airplanes) 

-- UPDATES (5)

update pilot set works_to_aircompany 

-- DELETES (5)

-- QUERIES (10)

-- 1. Get the portuguese passagers
select * from passagers where country='Portugal';

--2. What aircrafts American Airlines has?

select airplanes from airlines where name='American Airlines';

-- What pilots work to SATA?

select * from pilots where works_to_aircompany='SATA Azores Airlines' or works_to_aircompany='SATA internacional';