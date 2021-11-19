package com.mongodb.c;

import com.mongodb.BasicDBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.*;

import com.mongodb.client.model.Accumulators;
import com.mongodb.client.model.Indexes;
import com.mongodb.client.model.Sorts;

import org.bson.Document;
import org.bson.conversions.Bson;


import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import static com.mongodb.client.model.Aggregates.group;
import static com.mongodb.client.model.Filters.regex;
import static com.mongodb.client.model.Filters.and;



public class MongoDb_c {

    static MongoCollection<Document> collection;


    public static void main( String[] args )
    {
        // Connection 
        MongoClient mongoClient = new MongoClient("localhost", 27017);
        MongoDatabase database = mongoClient.getDatabase("cbd");
        collection = database.getCollection("restaurants");
    
        System.out.println("\n Reimplementation of exercise 2.2 with Java: ");

        System.out.println("\n 4. Indique o total de restaurantes localizados no Bronx. ");
        System.out.println("R: " + countByLocalidade("Bronx"));
        System.out.println("------------------------------------------------");


        System.out.println("\n 5. Apresente os primeiros 15 restaurantes localizados no Bronx, ordenados por ordem crescente de nome.");
        findSortedRest("Bronx",15);
        System.out.println("------------------------------------------------");


        System.out.println("\n 10. Liste o restaurant_id, o nome, a localidade e gastronomia dos restaurantes cujo nome começam por \"Will\".. ");
        getRestaurantNameLike("Wil");
        System.out.println("------------------------------------------------");


        System.out.println("\n Conte quantas localidades diferentes existem. ");
        System.out.println("\n R: " + countAllLocalidades());

   
        System.out.println("------------------------------------------------");
        System.out.println("\n 21. Indique os restaurantes que têm gastronomia \"Portuguese\"");
        restByGastronomia("Portuguese");


        mongoClient.close();


}


    public static void searchDocsFilter(Bson filter) {
        try {
            FindIterable<Document> docs = collection.find(filter);
            
        } catch (Exception e){
            System.err.println("ERROR: " + e);
        }
    }

    
    public static int countByLocalidade(String localidade){

        FindIterable<Document> docs = collection.find(regex("localidade", String.format("(%s)", localidade)));
        int count = 0;
            for (Document doc : docs) {
                count++;
            }
        
        return count;
    }
    public static void restByGastronomia(String gastronomia){

        ArrayList<Object> docs = collection.find(regex("gastronomia", String.format("(%s)", gastronomia))).into(new ArrayList<>());
      
        for (int i=0; i < docs.size(); i++) {
            System.out.println(docs.get(i));
        }
    
        
    }
    public static void findSortedRest(String localidade, int count){

        ArrayList<Object> docs = collection.find(regex("localidade", String.format("(%s)", localidade))).sort(Sorts.ascending("nome")).into(new ArrayList<>());
      
            for (int i=0; i < count; i++) {
                System.out.println(docs.get(i));
            }
        
    }
    public static int countAllLocalidades(){
        int count = 0;
        DistinctIterable<String> docs = collection.distinct("localidade", String.class);
        for (String d:docs){
            count++;
        }
        return count;
    }

    public static void getRestaurantNameLike(String name){

        List<String> res = new ArrayList<String>();
      
        FindIterable<Document> docs = collection.find(regex("nome", String.format("(%s)", name)));
        for (Document doc : docs) {
            res.add((String) doc.get("nome"));
        }

        for (String value : res) {
            System.out.println(value);
        }

    }
   
}


