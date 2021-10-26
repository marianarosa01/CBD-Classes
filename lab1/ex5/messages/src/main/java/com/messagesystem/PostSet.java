package com.messagesystem;

import redis.clients.jedis.Jedis;
import java.util.Set;

class PostSet {
    private Jedis jedis;
    public static String FOLLOWERS = "followers";

    public PostSet() {
        this.jedis = new Jedis("localhost");
    }

    public void addFollower (String username, String following_user) {
        jedis.sadd("following:" + username, following_user);
    }

    public Set<String> getFollowerSet(String username) {
        return jedis.smembers("following:" + username);
    }

    public Set<String> getAllKeys() {
        return jedis.keys("*");
    }
}
