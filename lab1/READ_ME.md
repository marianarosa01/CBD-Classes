# P1 - 14.10.2021


# Lab. 1 Bases de Dados Chave-Valor

Mariana Rosa, 98390

## 1.1 Redis (REmote DIctionary Service)

Um dos mais populares repositórios do tipo chave-valor em memória.
Pode ser utilizado como base de dados, como cache de dados, ou como sistema de
mensagens (message broker).

*nota: a*tentar em : escrita e leitura, persistência, TTL, tipos

***redis-cli:*** comando para enviar ao servidor pedidos

Nota → as chaves podem e devem ter semanticas (.,..,:)) → estruturas nas proprias chaves

Exemplo: C: A: Aveiro

### Ex. 4

 **Sorted Set:** junção de lista com sets, tal como uma lista os membros são ordenados e tal como um set têm uma ordem.

## Ex. 5

Vamos usar a metodologia de Publish/Subscribe, ou seja um padrão de comunicação entre sistemas, muito simples e uma alternative aos si.

Vamos ter 3 entidades: o publisher, o canal e o subscriber. O Subscriber vai subscrever ao canal onde ele vai receber as mensagens. Assim vamos ter diversos subscribers e um publisher. 

Há várias implementações possíveis, utilizar o Redis é uma delas.

### **Estruturas criadas**

- **class App**: menu dos sistemas da mensagem.
- **class PostSet**: manipulação da base de dados do sistema de subscrições, utilizando para a mesma sets em Redis.
- **class PostList**: manipulação da base de dados das mensagens, usando listas em Redis.
- **class PostHash**: manipulação da base de dados dos utilizadores, usando hash em Redis.
