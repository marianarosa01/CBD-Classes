package com.cbd3;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Session;
import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.*;

import java.util.Scanner;

public class App {
    public static void main(String[] args) {
        try (
            Cluster cluster = Cluster.builder().addContactPoint("127.0.0.1").build();
            Session sesssion = cluster.connect("videos");
            CqlSession session = CqlSession.builder().withKeyspace("cbd2").build()) {
            System.out.println("Opções" +
                    "\n 0 - Inserir um utilizador" +
                    "\n 1 - Editar um utilizador" +
                    "\n 2 - Pesquisar por um utilizador através de um username" +
                    "\n 3 - Os últimos 3 comentários introduzidos para um vídeo: " +
                    "\n 4 - Vídeos partilhados por determinado utilizador (maria1987, por exemplo) num determinado período de tempo (Agosto de 2017, por exemplo): " +
                    "\n 5 - Todos os seguidores (followers) de determinado vídeo: " +
                    "\n 6 - Lista de tags de vídeos específicos"); 

            Scanner scn1 = new Scanner(System.in);

            int input = scn1.nextInt();

            scn1.close();

            switch (input) {


                case 0:
                    
                    Scanner scannerInsert = new Scanner(System.in);
                    System.out.println("Nome: ");
                    String username = scannerInsert.nextLine();
                    System.out.println("Username: ");
                    String name = scannerInsert.nextLine();
                    System.out.println("Email: ");
                    String email = scannerInsert.nextLine();
                    scannerInsert.close();
                    
                    insertUser(session, username,name,email);

                    break;

                case 1:
                    
                    Scanner scUpdate = new Scanner(System.in);
                    System.out.println("Que utilizador gostaria de alterar? Digite o seu username.");
                    String usernameChange = scUpdate.nextLine();
                    System.out.println("Insira o novo nome: ");
                    String newName = scUpdate.nextLine();
                    System.out.println("Insira o novo email: ");
                    String newEmail = scUpdate.nextLine();
                    scUpdate.close();
                    

                    updateUser(session, usernameChange, newName, newEmail);

                    break;

                case 2:
                    
                    Scanner search = new Scanner(System.in);
                    System.out.println("Insira o username a pesquisar: ");
                    String uname = search.nextLine();
                    search.close();
                    

                    searchUser(session, uname);

                    break;


                case 3:
                    searchVideosByAuthor(session, "ppaulo");

                    break;

                case 4:
                    searchCommentsByUser(session, "bernas01");

                    break;

                case 5:
                    followers(session, 1);

                    break;

                case 6:
                    tagsList(session, 1);
            }
        }
    }


    private static void insertUser(CqlSession session, String username, String name, String email) {
        session.execute(
                SimpleStatement.builder("insert into user (username, name, email) values (?, ?, ?)")
                .addPositionalValues(username, name, email)
                .build()
        );
    }

    private static void updateUser(CqlSession session, String username, String email, String name) {
        session.execute(
                SimpleStatement.builder("update user set name=? where username=? and email=?")
                .addPositionalValues(username, name, email)
                .build()
        );
    }

    private static void searchUser(CqlSession session, String username) {
        try {
            ResultSet result = session.execute(
                    SimpleStatement.builder("select * from user where username=?")
                    .addPositionalValue(username)
                    .build()
            );

            Row r = result.one();
            System.out.format("User: " + r.getString("username"));
            System.out.format("\nNome: " + r.getString("name"));
            System.out.format("\nEmail: " + r.getString("email"));

        } catch (Exception QueryExecutionException) {
            System.out.println("ERRO: Este utilizador não existe!");
        }
    }


    private static void searchVideosByAuthor(CqlSession session, String author) {
        try {
            ResultSet result = session.execute(
                    SimpleStatement.builder("select * from video where author=? allow filtering")
                            .addPositionalValue(author)
                            .build()
            );

            for (Row r : result) {
                System.out.format("id: %d | timestamp: %s | author: %s | description: %s | name: %s | tags: %s \n",
                        r.getInt("id"),
                        r.getObject("upload_share_date"),
                        r.getString("share_authorauthor"),
                        r.getString("description"),
                        r.getString("name"),
                        r.getList("tags", String.class)
                );
            }

        } catch (Exception QueryExecutionException) {
            System.out.println("ERRO: Utilizador não existe!");
        }
    }

    private static void searchCommentsByUser(CqlSession session, String user) {
        try {
            ResultSet result = session.execute(
                    SimpleStatement.builder("select * from comments_video where author=? allow filtering")
                            .addPositionalValue(user)
                            .build()
            );

            for (Row r : result) {
                System.out.format("author: %s | timestamp: %s | comment: %s | video_id: %d \n",
                        r.getString("author"),
                        r.getObject("comment_date"),
                        r.getString("comment"),
                        r.getInt("video_id")
                );
            }

        } catch (Exception QueryExecutionException) {
            System.out.println("ERRO: Utilizador não existe! ");
        }
    }

    private static void followers(CqlSession session, int id_video) {
        
        try {
            ResultSet result = session.execute(
                    SimpleStatement.builder("select * from followers where id_video=? ")
                            .addPositionalValue(id_video)
                            .build()

            );
        

            for (Row r : result) {
                System.out.format("ID: %s | users: %s \n",
                        r.getString("id_video"),
                        r.getObject("users")
                       
                );
            }

        } catch (Exception QueryExecutionException) {
            System.out.println("ERRO: Vídeo não existe!");
        }
    }

    private static void tagsList(CqlSession session, int id_video) {
        try {
            ResultSet result = session.execute(
                    SimpleStatement.builder("select tags from video where id_video=?")
                            .addPositionalValue(id_video)
                            .build()
            );

            Row r = result.one();
            System.out.println("Tags: " + r.getList("tags", String.class));

        } catch (Exception QueryExecutionException) {
            System.out.println("ERRO: Este vídeo não existe!");
        }
    }
}