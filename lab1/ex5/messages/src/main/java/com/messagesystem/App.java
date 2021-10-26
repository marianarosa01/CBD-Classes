package com.messagesystem;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;


import redis.clients.jedis.Jedis;

public class App 
{
    private Jedis jedis;
    
    public App() {
        this.jedis = new Jedis("localhost");
    }

    public static void main( String[] args )
    {
        // podemos ter varios formatos de mensagem

        PostSet set_post = new PostSet();
        PostList list_post= new PostList();
        PostHash hash_post = new PostHash();

        int numUsers= 0;

        Map<String, String> users = new HashMap<String, String>();
        List<String> subscribers_list = new ArrayList<String>();
        Map<String, String> user_subscriptions = new HashMap<String, String>();

        Scanner sc = new Scanner(System.in);

        //MENU
        while (true) {
            System.out.println("----------- MESSAGE SYSTEM -----------\n" + 
            "----------- please choose your option -----------\n"+
            "1 -> Create User \n" +
            "2 -> Send a message \n" +
            "3 -> Add a friend \n" +
            "4 -> Check your friend's messages \n" +
            "5 -> EXIT \n");

            int op = sc.nextInt();

            switch (op) {
                case 1:

                    Scanner sc_user = new Scanner (System.in);
                    System.out.println("Please, type your username: ");
                    String username = sc_user.nextLine();

                    if (users.containsKey(username)) {
                        System.out.println("Ups! This user already exists. Try another name. \n");
                    }
                    else {
                        users.put("user nº " + String.valueOf(numUsers+1), username);
                        hash_post.addUser(users);
                        //Se der merda falta aqui algo
                    }
                    break;
            
            
                case 2:
                    Scanner sc_message_to = new Scanner(System.in);
                    Scanner sc_user_message = new Scanner(System.in);

                    System.out.println("To which user do you want to chat with? \n " + hash_post.getUserSet());
                    String user = sc_message_to.nextLine();

                    System.out.println("What's your message?");
                    String message = sc_user_message.nextLine();

                    list_post.saveMessage(user, message);
                    System.out.println(list_post.getMessageSet(user));
                    break;

                case 3:

                    Scanner own_user= new Scanner(System.in);
                    Scanner user_to_subscribe = new Scanner(System.in);

                    System.out.println(hash_post.getUserSet());

                    System.out.printf("Who are you? ");
                    String currentUser = own_user.nextLine();

                    System.out.println(hash_post.getUserSet());

                    System.out.println("Who do you wanna be friends with?  ");
                    String add_which_friend = user_to_subscribe.nextLine();

                    set_post.addFollower(currentUser, add_which_friend);
                    break;

                case 4:
                    Scanner own_user_2 = new Scanner(System.in);

                    System.out.printf("Who are you? ");
                    String currentUser_2 = own_user_2.nextLine();

                    Set<String> friends = set_post.getFollowerSet(currentUser_2);
                    if (friends.size() == 0)
                        System.out.println("You are not friends with anyone :( Please add someone! ");
                    else {
                        for (String f : friends) {
                            System.out.println("Message from " + f + ":");
                            List<String> messages = list_post.getMessageSet(f);
                            for(String m: messages)
                                System.out.println(m);
                        }
                    }

                    break;
                
            } while (sc.nextInt() != 5); 


        }

    }
}
