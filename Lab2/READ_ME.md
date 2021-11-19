# Lab2 - MongoDB

Completed: No

## MongoDB

O MongoDB é uma base de dados orientada a documentos desenvolvida em código aberto.

Representa os documentos em estruturas JSON, armazenadas no seu formato binário, BSON.

*Notas:*

MongoDaemon → servidor

Comandos → mongod

mongod --dbpath /home/mariana/Desktop/CBD/CBD-Classes/Mongo_db vai iniciar a nossa db

## Modelo de dados

O MongoDB apresenta uma estrutura composta por **documentos** (com ID único) que se vão agrupar em **coleções** *["Collections are analogous to tables in relational databases."],* que se agrupam em **base de dados.** 

*Chave primária →* definida pela chave ***id*** e identifica de forma única um documento dentro de uma coleção.

Nota → Se na criação de um documento o ID não for definido, é atribuído um ID automaticamente.

O Mongo consegue lidar de forma bastante eficiente com relações ***one-to-one*** e ***one-to-many***, pois um documento pode incorporar outros. Tanto em leituras como em escritas faz as operações sobre o conjunto de dados diretamente, sem necessidade de fazer várias consultas ou dividir os dados. Também tem os seus aspectos negativos como a duplicação de dados, então utiliza-se **referências**, tal como as Foreign Keys em SQL para evitar a situação.

As referências fazem-se  através do campo $id, cujo valor é o id do documento a que nos queremos referir. Esta característica permite a existência de relações ***many-to-many***.

```
bottles : [
    { "$id": "1" }
]

```

### Executar servidor

Para iniciar a nossa BD:

```jsx
$ mongod --dbpath /home/mariana/Desktop/CBD/CBD-Classes/Mongo_db 

```

### Executar o cliente

```jsx
$ mongo [--username <user> --password <pass> --host <host> --port <portN>]
```

## Comandos CRUD

Create, read, update, delet

### Insert

Para inserir dados temos o insert, usar insertOne or insertMany, não usar o insert.

Se quisermos modificar temos de dar update. 

### Read/Find

Depois de inserir, fazemos select com **db.nomeColecao.find.**

**Nota**: se quiseremos uma pesquisa + complexa → select 

```jsx
find({zona onde pesquisamos elementos semelhantes, selecao, restricao},
{onde especificamos o que queremos ver exemplo "nome:1,_id:0}

Nota: Também podemos só por um desses campos.
{nome:0,_id:0} → significa que quero ver tudo excepto estes, se tiver a 1 mostra-se, se tiver tudo a zero mostra tudo menos esse
O id é o unico que não podemos por 0. Se quisermos que não apareça um certo campo, simplesmente omitimos o  nome da coluna.
```

**Exemplos:**

```jsx
> db.movies.find( { }, { "title": 1, "directors": 1, "year": 1, _id:0 } );
{ "title" : "Titanic", "year" : 1997, "directors" : [ "James Cameron" ] }
{ "title" : "The Dark Knight", "year" : 2008, "directors" : [ "Christopher Nolan" ] }
{ "title" : "Spirited Away", "year" : 2001, "directors" : [ "Hayao Miyazaki" ] }
{ "title" : "Casablanca", "directors" : [ "Michael Curtiz" ], "year" : 1942 }
> db.movies.find( { }, { "title": 1, "directors": 1 } );
{ "_id" : ObjectId("617aa0e3bfcf8afbcdc857ca"), "title" : "Titanic", "directors" : [ "James Cameron" ] }
{ "_id" : ObjectId("617aa0e3bfcf8afbcdc857cb"), "title" : "The Dark Knight", "directors" : [ "Christopher Nolan" ] }
{ "_id" : ObjectId("617aa0e3bfcf8afbcdc857cc"), "title" : "Spirited Away", "directors" : [ "Hayao Miyazaki" ] }
{ "_id" : ObjectId("617aa0e3bfcf8afbcdc857cd"), "title" : "Casablanca", "directors" : [ "Michael Curtiz" ] }
>
```

```jsx
j
db.cbd.find()
{ "_id" : ObjectId("617a9b40bfcf8afbcdc857c9"), "teste" : "mariana" }
```

[Condições de filtragem](https://www.notion.so/a4de051951144e6a872211a652147f6a)

**Links úteis:**

[https://docs.mongodb.com/manual/introduction/](https://docs.mongodb.com/manual/introduction/)

[https://docs.mongodb.com/manual/reference/sql-comparison/](https://docs.mongodb.com/manual/reference/sql-comparison/)

[https://docs.mongodb.com/manual/](https://docs.mongodb.com/manual/)

## Ex.2

Respostas na pasta do exercício.

## Ex.3

Nota: Para usar as funções

```jsx
use tests; load("functions.js"); functions()
```

## Ex. 4 - MongoDB - Driver (Java)

O MongoDB tem vários *drivers* para aceder de forma programática através de diferentes linguagens de programação.  Para resolver este exercício acedi a várias documentações úteis sobre Drivers em Java e incorporar os comandos utilizados no MongoDb.

**Links úteis:**

[https://docs.mongodb.com/ecosystem/drivers](https://docs.mongodb.com/ecosystem/drivers)

[https://mongodb.github.io/mongo-java-driver/3.4/driver/getting-started/quick-start/](https://mongodb.github.io/mongo-java-driver/3.4/driver/getting-started/quick-start/)

[https://www.programcreek.com/java-api-examples/?api=com.mongodb.client.model.Sorts](https://www.programcreek.com/java-api-examples/?api=com.mongodb.client.model.Sorts)

**Nota:** Tal como vimos na unidade curricular Base de Dados, os índices melhoram (e muito) o desempenho dos programas. 

*Output do exercício b)*

```jsx
--------------WITHOUT INDEXES--------------

Searching all Japanese restaurants located in Queens...
Search Time without indexes: 4514249

--------------WITH INDEXES--------------

Searching all Japanese restaurants located in Queens...
Search Time with indexes: 244017
```