package com.messagesystem;

import redis.clients.jedis.Jedis;
import java.util.Map;
import java.util.Set;

public class PostHash {
    private Jedis jedis;
    public static String USERS = "users";

    public PostHash() { 
        this.jedis = new Jedis("localhost"); 
    }

    public void addUser (Map<String, String> m) {
        jedis.hmset(USERS, m); 
    }

    public Map<String, String> getUserSet() { 
        return jedis.hgetAll(USERS); 
    }

    public Set<String> getAllKeys() {
        return jedis.keys("*"); 
    }
}
