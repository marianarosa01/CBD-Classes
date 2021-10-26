package com.listUsers.lab13i;

import java.util.List;
import java.util.Set;

//reading and writing with a list

 
import redis.clients.jedis.Jedis;

public class App {
    private Jedis jedis;

    public static String USERS = "users"; // Key for users' name
    public App() {
        this.jedis = new Jedis();
    }
    public void saveUser(String username) {
        jedis.lpush(USERS, username);
        
    }
    public List<String> getUser() {
        return jedis.lrange(USERS,0,-1); //list of all users -> values
    }
    public Set<String> getAllKeys() {
        return jedis.keys("*");
    }
    public static void main(String[] args) {
        App board = new App();
        // set some users
        String[] users = { "Ana", "Pedro", "Maria", "Luis" };
        for (String user: users){
            board.saveUser(user);
        }
        board.getAllKeys().stream().forEach(System.out::println);
        board.getUser().stream().forEach(System.out::println);
        board.flushAll();

        

    }
}


    