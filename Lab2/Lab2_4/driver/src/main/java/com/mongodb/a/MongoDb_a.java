package com.mongodb.a;



import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Updates;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import static com.mongodb.client.model.Filters.*;
import static java.util.Arrays.asList;



public class MongoDb_a {

    // Collection of documents
    static MongoCollection<Document> collection;

    public static void main( String[] args )
    { 
        Logger.getLogger("org.mongodb.driver").setLevel(Level.WARNING);

        // Connection 
        MongoClient mongoClient = new MongoClient("localhost", 27017);

        MongoDatabase database = mongoClient.getDatabase("cbd");
        collection = database.getCollection("restaurants");

        // Example inserting one restaurant
        System.out.println("\nInserting restaurant...");
        Document restaurant1 = new Document("_id", new ObjectId())
                .append("address",new Document()
                .append("building", "50")
                .append("coord", asList(-37.8167, -25.5167))
                .append("rua", "Alameda 29 de junho")
                .append("zipcode", "9600")
                )
                .append("localidade", "Ribeira Grande")
                .append("gastronomia", "Portuguesa")
                .append("grades", asList(
                        new Document("date", new Date())
                        .append("grade", "B")
                        .append("socre", 8)
                    )
                )
                .append("nome", "Tukatula")
                .append("restaurant_id", "123456");

        insertDoc(restaurant1);

        // updating document
        System.out.println("\nUpdating restaurant...");
        updateDoc(eq("nome", "Tukatula"),Updates.set("nome","Restaurante Monte Verde"));
        searchDocFilter(eq("gastronomia", "Indian"));        
        mongoClient.close();
    }

    //Insert a document into collection

    public static void insertDoc(Document docToInsert){
        try {
            collection.insertOne(docToInsert);
            System.out.println(docToInsert +  "inserted with success!");
        }catch (Exception e){
            System.err.println("ERROR: Can't insert into MongoDB collection: " + e);
        }

    }

   // Fetching a document 

    public static void searchDocFilter(Bson filter){
        try {
            FindIterable<Document> docs = collection.find(filter);
            if (docs == null) {
                System.out.println("Nothing found!");
            }
            else{
                for (Document doc : docs) {
                    System.out.println(doc.toJson());
                }
            }
            
        }catch (Exception e){
            System.err.println("ERROR: Can't read from MongoDB collection: " + e);
        }

    }

   

    // Updates a document that matches a given filter with new args passed
    
    public static void updateDoc(Bson filter, Bson updateArgs) {
        try {
            collection.updateOne(filter,updateArgs);
            System.out.println("Updated with success!");

        } catch (Exception e) {
            System.err.println("ERROR: updating on MongoDB collection: " + e);
        }
    }

}