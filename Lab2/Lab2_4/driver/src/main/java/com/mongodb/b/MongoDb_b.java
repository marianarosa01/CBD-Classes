package com.mongodb.b;

import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Indexes;

import org.bson.Document;
import org.bson.conversions.Bson;

import java.util.logging.Level;
import java.util.logging.Logger;

import static com.mongodb.client.model.Filters.*;


public class MongoDb_b {

    static MongoCollection<Document> collection;


    public static void main( String[] args )
    {
        // Connection 
        MongoClient mongoClient = new MongoClient("localhost", 27017);
        MongoDatabase database = mongoClient.getDatabase("cbd");
        collection = database.getCollection("restaurants");

        //Exemplo de fetching sem indexes
        System.out.println("\n--------------WITHOUT INDEXES--------------");
        System.out.println("\nSearching all Japanese restaurants located in Queens...");
        long startTime = System.nanoTime();
        searchDocsFilter(and(eq("gastronomia", "Japanese"), eq("localidade", "Queens")));
        long stopTime = System.nanoTime();
        System.out.println("Search Time without indexes: " + (stopTime - startTime));

        // Example de fetching com indexes
        System.out.println("\n--------------WITH INDEXES--------------");
        createIndex("gastronomia");
        createIndex("localidade");
        createIndexByText("nome");
        startTime = System.nanoTime();
        System.out.println("\nSearching all Japanese restaurants located in Queens...");
        searchDocsFilter(and(eq("gastronomia", "Japanese"), eq("localidade", "Queens...")));
        stopTime = System.nanoTime();
        System.out.println("Search Time with indexes: " + (stopTime - startTime));

        mongoClient.close();


}


    public static void searchDocsFilter(Bson filter) {
        try {
            FindIterable<Document> docs = collection.find(filter);
            
        } catch (Exception e){
            System.err.println("ERROR: " + e);
        }
    }
    public static void createIndex(String filedName) {
        try {
            collection.createIndex(Indexes.ascending(filedName));
        } catch (Exception e) {
            System.err.println("ERROR: "+  e);
        }
    }

    public static void createIndexByText(String filedName) {
        try {
            collection.createIndex(Indexes.text((filedName)));
        } catch (Exception e) {
            System.err.println("ERROR: "+  e);
        }
    }
}
