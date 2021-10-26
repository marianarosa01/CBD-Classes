package com.autocompletepop;



import redis.clients.jedis.Jedis;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;
import java.util.Set;
import java.util.TreeSet;
//alínea b)

public class AutocompletePop 
{
    private Jedis jedis;
    public String USERS = "names";
    
    public AutocompletePop() {
        this.jedis = new Jedis("localhost");
    }
    
    public void addUser(String user, int score) {
        jedis.zadd(USERS,score, user);
        //vamos usar sorted sets para os nomes serem únicos e ordenados
    }

    public Set <String> getUser (String searchedName){
        Set <String> namesResult = new TreeSet<>();
        namesResult = jedis.zrevrange(USERS,0,-1);
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
        
        
        AutocompletePop csvList = new AutocompletePop();

      
        BufferedReader csvReader = new BufferedReader(new FileReader(new File("../nomes-pt-2021.csv")));
        String row;
        while ((row = csvReader.readLine()) != null) {
            String[] data = row.split(";");
            csvList.addUser(data[0], Integer.parseInt(data[1]));
        }
        csvReader.close();
            
       

        Scanner sc = new Scanner (System.in);
        while (true) {
            System.out.println("Search for ('Enter' for quit): ");
            String input = sc.nextLine();

            if (input.length() == 0){
                break;
            }
            Set<String> filter = csvList.getUser(input);
            System.out.println(input);
            for (String name : filter){
                String lower_name = name.toLowerCase();
                if (lower_name.matches(input +"(.*)")){ //se o que o utilizador introduziu corresponde a algum nome (ou começo deste)
                    System.out.println(lower_name);
                }
                
            }

        }

        sc.close();

    }
    
}
    

