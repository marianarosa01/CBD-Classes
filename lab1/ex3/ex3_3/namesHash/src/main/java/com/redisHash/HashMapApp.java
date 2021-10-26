package com.redisHash;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

//reading and writing with a HashMap

 
import redis.clients.jedis.Jedis;

public class HashMapApp {
    
    
    private Jedis jedis;
    public static String USERS = "users_hash"; // Key set for users' name

    public HashMapApp() {
        this.jedis = new Jedis("localhost");
    }
    public void saveUser(Map<String,String> map) {
        jedis.hmset(USERS, map);
    }
    public Map<String,String> getUser() {
        return jedis.hgetAll(USERS);
    }
    public Set<String> getAllKeys() {
        return jedis.keys("*");
    }
    public void flushAll(){
        jedis.flushAll();
    }
    
    public static void main(String[] args) {
        HashMapApp board = new HashMapApp();
        // set some users
        Map<String, String> hashmap = new HashMap<>();
        hashmap.put("User1", "Ana");
        hashmap.put("User2", "Pedro");
        hashmap.put("User3", "Maria");
        hashmap.put("User4", "Luís");

        board.saveUser(hashmap);
        System.out.println("\n Keys: \n");
        board.getAllKeys().stream().forEach(System.out::println);
        
        System.out.println("\n Users: \n");
        Map <String, String> mapa_users = board.getUser();

        for (String key: mapa_users.keySet()){
            System.out.println(mapa_users.get(key));
        }
        //Erase db 
        board.flushAll();
    }
}
   