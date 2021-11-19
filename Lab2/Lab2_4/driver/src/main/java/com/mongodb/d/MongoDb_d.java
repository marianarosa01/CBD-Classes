package com.mongodb.d;

import com.mongodb.BasicDBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.*;

import com.mongodb.client.model.Accumulators;
import com.mongodb.client.model.Indexes;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import static com.mongodb.client.model.Aggregates.group;
import static com.mongodb.client.model.Filters.regex;

public class MongoDb_d {


    static MongoCollection<Document> collection;

    public static void main( String[] args ) throws FileNotFoundException
    {
        // Creating a File object that represents the disk file.
        PrintStream output = new PrintStream(new File("CBD_L204_98390.txt"));
        // Store current System.out before assigning a new value
        PrintStream console = System.out;
        System.setOut(output);

        // Connects
        MongoClient mongoClient = new MongoClient("localhost", 27017);
        MongoDatabase database = mongoClient.getDatabase("cbd");
        collection = database.getCollection("restaurants");


        //localidades distintas
        System.out.println("Numero de localidades distintas: " + countLocalidades());
        //restaurantes por localizaçao
       
        System.out.println("Numero de restaurantes por localidade: ");
        Map<String, Integer> map = countRestByLocalidade();
        for (String city : map.keySet()) {
            System.out.println(" -> " + city + " - " + map.get(city));
        }


        // Obter restaurantes com 'Park' no nome
        System.out.println("Nome de restaurantes contendo \"Park\" no nome: ");
        List<String> lista = getRestWithNameCloserTo("Park");
        for (String localidade : lista) {
            System.out.println(" -> " + localidade);
        }
        mongoClient.close();
    }

    
    public static int countLocalidades(){
        int count = 0;
        DistinctIterable<String> docs = collection.distinct("localidade", String.class);

        for (String d : docs){
            count++;
        }
    
        return count;
    }

    public static Map<String, Integer> countRestByLocalidade(){

        Map<String, Integer> res = new HashMap<>();

    
        AggregateIterable<Document> docs = collection.aggregate(Arrays.asList(group("$localidade", Accumulators.sum("sum",1))));

        for (Document d : docs) {
            res.put(d.get("_id").toString(), (int) (d.get("sum")));
        }

        return res;
    }



    public static List<String> getRestWithNameCloserTo(String name){
        List<String> res = new ArrayList<String>();
        FindIterable<Document> docs = collection.find(regex("nome", String.format("(%s)", name)));
        for (Document doc : docs) {
            res.add((String) doc.get("nome"));
        }
        return res;

    }



    
}

