/* ex2.1
 */
create table user (
    username text primary key,
    name text,
    email text,
    date timestamp);



create table  video(
    id int primary key,
    share_author text,
    name text,
    description text,
    tag set <text>,
    upload_share_date timestamp);


create table comments (
    id_comment int primary key,
    id_video int,
    author text,
    date timestamp,
    text text);

create table comments_time( /* pesquisa de comentarios por user data*/
	user text,
	id_video int,
	comment text,
	date timestamp,
	primary key(user, date)) with clustering order by (date desc);

create table comments_video ( /* pesquisa de comentarios por video*/
    id_video int,
    date timestamp,
    comment text,
    author text,
    primary key (id_video, date)) with clustering order by (date desc);

create table followers (
      id_video int primary key,
      users set<text>);

create table event (
    id_video int,
    author text,
    type text, /*play,pause,stop*/
    date timestamp,
    time_now timestamp,
    primary key  (id_video, author, date,time_now));

create table rating(
    id_video int,
    rating_value int, /*de 1 a 5*/
    primary key ( id_video, rating_value ));

create table avg_rating( /*idk*/
    id_rating int,
    id_video int,
    rating_value int, /*de 1 a 5*/
    avg_score int,
    primary key ( id_rating, rating_value ));


insert into user(username, name,email, date) values ('marianarosa', 'Mariana Rosa', 'marianarosa@ua.pt', toTimestamp(now));
insert into user(username, name,email, date) values ('ppaulo', 'Paulo Pereira', 'pp@ua.pt', toTimestamp(now));
insert into user(username, name,email, date) values ('arturomao', 'Artur Romao', 'artur_romao@ua.pt', toTimestamp(now));
insert into user(username, name,email, date) values ('bernas01', 'Bernardo Faria', 'bernas@ua.pt', toTimestamp(now));
insert into user(username, name,email, date) values ('evaPomposo', 'Eva Pomposo', 'eva@ua.pt', toTimestamp(now));
insert into user(username, name,email, date) values ('sobralations', 'Pedro Sobral', 'pedrosobral@ua.pt', toTimestamp(now));
insert into user(username, name,email, date) values ('broth02', 'Nuno Fahla', 'fahla@ua.pt', toTimestamp(now));
insert into user(username, name,email, date) values ('martaF', 'Marta Fradique', 'martafradique@ua.pt', toTimestamp(now));
insert into user(username, name,email, date) values ('reis', 'Jo??o Reis', 'joaoreis@ua.pt', toTimestamp(now));
insert into user(username, name,email, date) values ('dx', 'Diogo Cruz', 'dx@ua.pt', toTimestamp(now));

insert into video (id, share_author, name, description, tag, upload_share_date) values (1, 'marianarosa', 'A minha vida dava um filme', 'Descricao', {'dia a dia', 'lifestyle'}, '31-10-2001');
insert into video (id, share_author, name, description, tag, upload_share_date) values (2, 'ppaulo', 'Andar sem parar!','descricao2', {'joke', 'funny'}, '10-02-2020');
insert into video (id, share_author, name, description, tag, upload_share_date) values (3, 'arturomao', 'Benfica ?? vida!', 'descricao3', {'futebol'}, '10-02-2019');
insert into video (id, share_author, name, description, tag, upload_share_date) values (4, 'evaPomposo','Ctrl c + ctl v', 'descricao4', {'informatica'}, '10-09-2019');
insert into video (id, share_author, name, description, tag, upload_share_date) values (5, 'sobralations','Porto ?? vida!', 'descricao5', {'futebol'}, '10-01-2019');
insert into video (id, share_author, name, description, tag, upload_share_date) values (6, 'broth02','Python ?? a linguagem mais fixe', 'descricao6', {'informatica'}, '9-09-2019');
insert into video (id, share_author, name, description, tag, upload_share_date) values (7, 'martaF','Cooking with me', 'descricao7', {'culinaria'}, '11-02-2021');
insert into video (id, share_author, name, description, tag, upload_share_date) values (8, 'reis','A??ores: uma viagem inesquec??vel', 'descricao8', {'viajar'}, '08-09-2021');
insert into video (id, share_author, name, description, tag, upload_share_date) values (9, 'dx','Os putos nao sabem o meu nome', 'descricao9', {'faina'}, '10-11-2021');
insert into video (id, share_author, name, description, tag, upload_share_date) values (10, 'bernas01','Campia e jeropiga', 'descricao10', {'culinaria'}, '06-11-2021');


insert into comments (id_comment, id_video,author, date, text) values (1,2,'Eva Pomposo', toTimestamp(now), 'Adorei!');
insert into comments (id_comment, id_video, author, date, text) values (2,2,'Paulo Pereira', toTimestamp(now), '5 estrelas!!!');
insert into comments (id_comment, id_video, author, date, text) values (3,3,'Artur Romao', toTimestamp(now), 'Podia ser melhor!');
insert into comments (id_comment, id_video,author, date, text) values (4,4,'Nuno Fahla', toTimestamp(now), 'Um bom passatempo!');
insert into comments (id_comment, id_video, author, date, text) values (5,5,'Marta Fradique', toTimestamp(now), 'Razoavel!');
insert into comments (id_comment, id_video, author, date, text) values (6,6,'Pedro Sobral', toTimestamp(now), 'Esperava mais...!');
insert into comments (id_comment, id_video, author, date, text) values (7,7,'Bernardo Farias', toTimestamp(now), 'Amei!');
insert into comments (id_comment, id_video, author, date, text) values (8,8,'Diogo Cruz', toTimestamp(now), '4/10');
insert into comments (id_comment, id_video, author, date, text) values (9,9,'Jo??o Reis', toTimestamp(now), '3/5');
insert into comments (id_comment, id_video, author, date, text) values (10,10,'Mariana Rosa', toTimestamp(now), 'Nao fez o meu genero!');

create table comments_time( /* pesquisa de comentarios por user data*/
	user text,
	id_video int,
	comment text,
	comment_date timestamp,
	primary key(user, comment_date)) with clustering order by (comment_date desc);

create table comments_video ( /* pesquisa de comentarios por video*/
    id_video int,
    comment_date timestamp,
    comment text,
    author text,
    primary key (id_video, comment_date)) with clustering order by (comment_date desc);


insert into comments_time  (user, id_video, comment, comment_date) values ('Eva Pomposo', 5, 'Meh', toTimestamp(now()));
insert into comments_time  (user, id_video, comment,comment_date) values ('Nuno Fahla', 9, 'Okay', toTimestamp(now()));
insert into comments_time  (user, id_video, comment,comment_date) values ('Diogo Cruz', 4, 'Razoavel', toTimestamp(now()));
insert into comments_time  (user, id_video, comment,comment_date) values ('Mariana Rosa', 1, 'Incrivel', toTimestamp(now()));
insert into comments_time  (user, id_video, comment,comment_date) values ('Joao Reis', 2, 'Adorei', toTimestamp(now()));
insert into comments_time  (user, id_video, comment,comment_date) values ('Joao Farias', 10, 'Mind blowing', toTimestamp(now()));
insert into comments_time  (user, id_video, comment,comment_date) values ('Paulo Pereira', 6, 'Podia ser melhor', toTimestamp(now()));
insert into comments_time  (user, id_video, comment,comment_date) values ('Artur Romao', 7, 'Muito bom!', toTimestamp(now()));
insert into comments_time  (user, id_video, comment,comment_date) values ('Marta Fradique', 3, 'Nice', toTimestamp(now()));
insert into comments_time  (user, id_video, comment,comment_date) values ('Pedro Sobral', 8, 'Aceitavel', toTimestamp(now()));


insert into comments_video  (id_video, comment_date, comment, author) values ('Paulo Pereira', 5, 'Faz push', toTimestamp(now()));
insert into comments_video  (id_video, comment_date, comment, author) values ('Nuno Fahla', 10, 'Razoavel', toTimestamp(now()));
insert into comments_video  (id_video, comment_date, comment, author) values ('Mariana Rosa', 1, 'Nice!', toTimestamp(now()));
insert into comments_video  (id_video, comment_date, comment, author) values ('Diogo Cruz', 8, '5/5', toTimestamp(now()));
insert into comments_video  (id_video, comment_date, comment, author) values ('Marta Fradique', 2, 'Esperava mais', toTimestamp(now()));
insert into comments_video  (id_video, comment_date, comment, author) values ('Artur Romao', 4, 'Nao acredito, muito bom!', toTimestamp(now()));
insert into comments_video  (id_video, comment_date, comment, author) values ('Eva Pomposo', 7, 'Top!', toTimestamp(now()));
insert into comments_video  (id_video, comment_date, comment, author) values ('Joao Farias', 6, '10/10', toTimestamp(now()));
insert into comments_video  (id_video, comment_date, comment, author) values ('Pedro Sobral', 9, 'Incrivel', toTimestamp(now()));
insert into comments_video  (id_video, comment_date, comment, author) values ('Joao Reis', 3, 'Ta top', toTimestamp(now()));


insert into followers (id_video, users) values (1, {'dx', 'evaPomposo', 'marianarosa'});
insert into followers (id_video, users) values (2, {'dx', 'ppaulo', 'reis', 'sobralations'});
insert into followers (id_video, users) values (3, {'marianarosa','sobralations'});
insert into followers (id_video, users) values (4, {'broth02', 'martaF'});
insert into followers (id_video, users) values (5, {'dx', 'ppaulo'});
insert into followers (id_video, users) values (6, {'arturomao','dx','reis'});
insert into followers (id_video, users) values (7, {'bernas01', 'broth02', 'evaPomposo', 'marianarosa', 'martaF'});
insert into followers (id_video, users) values (8, {'broth02', 'ppaulo'});
insert into followers (id_video, users) values (9, {'dx', 'marianarosa', 'ppaulo'});
insert into followers (id_video, users) values (10, {'marianarosa', 'sobralations'});



insert into events (id_video, author, date_event, type_) values (1, 'dx', 'pause', toTimestamp(now()), toTimestamp(now()));
insert into events (id_video, author, date_event, type_) values (2, 'ppaulo', 'stop', toTimestamp(now()), toTimestamp(now()));
insert into events (id_video, author, date_event, type_) values (3, 'marianarosa', 'play', toTimestamp(now()), toTimestamp(now()));
insert into events (id_video, author, date_event, type_) values (4, 'broth02', 'play', toTimestamp(now()), toTimestamp(now()));
insert into events (id_video, author, date_event, type_) values (5, 'sobralations', 'pause', toTimestamp(now()), toTimestamp(now()));
insert into events (id_video, author, date_event, type_) values (6, 'reis', 'play', toTimestamp(now()), toTimestamp(now()));
insert into events (id_video, author, date_event, type_) values (7, 'martaF', 'stop', toTimestamp(now()), toTimestamp(now()));
insert into events (id_video, author, date_event, type_) values (8, 'martaF', 'play', toTimestamp(now()), toTimestamp(now()));
insert into events (id_video, author, date_event, type_) values (9, 'dx', 'play', toTimestamp(now()), toTimestamp(now()));
insert into events (id_video, author, date_event, type_) values (10, 'marianarosa', 'play', toTimestamp(now()), toTimestamp(now()));




insert into rating (id_video, rating_value) values (1, 3);
insert into rating (id_video, rating_value) values (1, 4);
insert into rating (id_video, rating_value) values (1, 5);
insert into rating (id_video, rating_value) values (2, 1);
insert into rating (id_video, rating_value) values (2, 2);
insert into rating (id_video, rating_value) values (3, 5);
insert into rating (id_video, rating_value) values (4, 4);
insert into rating (id_video, rating_value) values (5, 2);
insert into rating (id_video, rating_value) values (5, 5);
insert into rating (id_video, rating_value) values (6, 1);
insert into rating (id_video, rating_value) values (6, 2);
insert into rating (id_video, rating_value) values (7, 2);
insert into rating (id_video, rating_value) values (7, 5);
insert into rating (id_video, rating_value) values (8, 1);
insert into rating (id_video, rating_value) values (8, 2);
insert into rating (id_video, rating_value) values (10, 5);
insert into rating (id_video, rating_value) values (10, 4);



create table rating(
    id_video int,
    rating_value int, /*de 1 a 5*/
    primary key ( id_video, rating_value ));


--- JSON
select json * from user;
select json * from video;
select json * from comment;
select json * from comments_time;
select json * from comments_video;
select json * from followers;
select json * from events;
select json * from rating;

----- c)

--- 7. Permitir a pesquisa de todos os v??deos de determinado autor;
select * from video where author='dx' allow filtering;

---8. Permitir a pesquisa de coment??rios por utilizador, ordenado inversamente pela data;
select * from comments_time where author='marianarosa';

---9. Permitir a pesquisa de coment??rios por v??deos, ordenado inversamente pela data;
select * from comments_video where id_video=1;

--- 10. Permitir a pesquisa do rating m??dio de um v??deo e quantas vezes foi votado;> select avg(rating) as avg_rating, count(rating) as number_votes from rating where videoid=1;
select avg(rating) as avg_rating, count(rating) as votes from rating where id_video = 5;

---d)
--- 1. Os ??ltimos 3 coment??rios introduzidos para um v??deo;
select * from comments_video where id_video=2 limit 3;

--- 2. Lista das tags de determinado v??deo;
select name, tag from video where id=1;

--- 3 Todos os v??deos com a tag Aveiro;
select * from video where tag contains 'Aveiro' allow filtering;

--- 4 Os ??ltimos 5 eventos de determinado v??deo realizados por um utilizador;
select * from events where author='martaF' and id_video=8 limit 5;

--- 5 V??deos partilhados por determinado utilizador (maria1987, por exemplo) num determinado per??odo de tempo (Agosto de 2017, por exemplo);
select * from video where author='ppaulo' and upload_date > '31-10-2001' and upload_date < '10-02-2020'  allow filtering;

--- 6. Os ??ltimos 10 v??deos, ordenado inversamente pela data da partilhada;
--N??o d?? sem uma partition key n??o conseguimos ordenar as colunas.
--- 7. Todos os seguidores (followers) de determinado v??deo;

--- 8. Todos os coment??rios (dos v??deos) que determinado utilizador est?? a seguir (following);
--N??o d?? pois seria necess??rio fazer join entre coment??rios e followers, algo que n??o ?? poss??vel em Cassandra;

--- 9. Os 5 v??deos com maior rating;
--N??o d?? pois Cassandra n??o permite global querying

---10. Uma query que retorne todos os v??deos e que mostre claramente a forma pela qual est??o ordenados;
?? 

--- 11. Lista com as Tags existentes e o n??mero de v??deos catalogados com cada uma delas;
-- N??o d??, mesmo motivo da 8