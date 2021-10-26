package com.autocomplete.app;


import redis.clients.jedis.Jedis;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;
import java.util.Set;
import java.util.TreeSet;
//alínea a)
public class AutocompleteProg 
{
    private Jedis jedis;
    public String USERS = "names";
    
    public AutocompleteProg() {
        this.jedis = new Jedis("localhost");
    }
    
    public void addUser(String user) {
        jedis.zadd(USERS,0, user);
        //vamos usar sets para os nomes serem únicos
    }

    public Set <String> getUser (String searchedName){
        Set <String> namesResult = new TreeSet<>();
        namesResult = jedis.zrangeByLex(USERS, "[" + searchedName, "["+ searchedName + (char)0xFF);
        return namesResult;
    }  

    public Set<String> getAllKeys() {
        return jedis.keys("*");
    }
    public void flushAll(){
        jedis.flushAll();
    }      
    public static void main( String[] args) throws IOException 
    {
        
        //a)
        AutocompleteProg rList = new AutocompleteProg();

        
        try {
            File txtnames = new File("./names.txt");
            Scanner sc = new Scanner(txtnames);
            while (sc.hasNextLine()){
                rList.addUser(sc.nextLine());
            }
            sc.close();
        }catch(FileNotFoundException e){
            e.printStackTrace();
        }

        System.out.println( "Search for ('Enter' for quit): \n");
        Scanner sc = new Scanner (System.in);
        while (true) {
            System.out.println("Search for ('Enter' for quit): ");
            String input = sc.nextLine();

            if (input.length() == 0){
                break;
            }
            Set<String> filter = rList.getUser(input);
            System.out.println(input);
            for (String filtredName : filter){
                System.out.println(filtredName);
            }

        }

        sc.close();

    }
    
}
    

