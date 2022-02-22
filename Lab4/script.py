from neo4j import GraphDatabase

class Database:
    def __init__(self):
        self._driver = GraphDatabase.driver("bolt://localhost:7687", auth = ("neo4j", "123"))

    def close(self):
        self._driver.close()

    def inserts(self):
        data = "load csv with headers from 'file:///StudentsPerformance.csv' as row merge (s:Student {gender: row.gender, race: row.race, lunch:row.lunch}) merge (g:Grades {math: row.mathscore, reading:row.readingscore, writing: row.writingscore}) merge (prep:PreparationCourse {prepCourse:row.testpreparationcourse}) merge (p:Parents {level: row.parentaleducation}) "
        
        print("Nodes successfully inserted!")

        data += " merge (s)-[:SCORED]->(g) "
        data += " merge (s)-[:DID_PREPARATION_COURSE]->(prep)"
        data += " merge (s)-[:HAS_PARENT_WITH_EDUCATION]->(p)"
       
        print("Relations sucessfully inserted!")
        self._driver.session().run(data)
    
    def delete_all(self,connection):
        return connection.query("match (s) detach delete n")

    
    def query(self, query):
        return list(self._driver.session().run(query))
        
    
if __name__ == "__main__":

    # inicar a conexao
    connection = Database()
    f = open('./CBD_L44c_output.txt','w')


    # Inserir a info, executar apenas uma vez!
    #connection.inserts()

    q1_question ="1. Show all the students who participated in this study."
    f.write(str(q1_question))
    f.write("\n")
    q1_query="match (n) return n"
    q1 = connection.query(q1_query)
    f.write(str(q1_query))
    f.write("\n")
    f.write(str(q1))
    f.write("\n\n")

    q2_question ="2. What was the average of the Writing grades?"
    f.write(str(q2_question))
    f.write("\n")
    q2_query="match (s:Student)-[:SCORED]->(g:Grades)  return round(avg(toInteger(g.writing))*100)/100 as avgWritingExam "
    q2 = connection.query(q1_query)
    f.write(str(q2_query))
    f.write("\n")
    f.write(str(q2))
    f.write("\n\n")


    q3_question ="3. Show five female students."
    f.write(str(q3_question))
    f.write("\n")
    q3_query="match (s:Student) where s.gender='female' return s limit 5"
    q3 = connection.query(q3_query)
    f.write(str(q3_query))
    f.write("\n")
    f.write(str(q3))
    f.write("\n\n")


    q4_question =" 4. What was the average grade of Math Score between girls?"
    f.write(str(q4_question))
    f.write("\n")
    q4_query="match (s:Student) where s.gender='female' return s limit 5"
    q4 = connection.query(q4_query)
    f.write(str(q4_query))
    f.write("\n")
    f.write(str(q4))
    f.write("\n\n")



    q5_question ="5. How many girls and how many boys there are?"
    f.write(str(q5_question))
    f.write("\n")
    q5_query="match (s:Student) return s.gender, count(s.gender) as counter  order by counter desc"
    q5 = connection.query(q5_query)
    f.write(str(q5_query))
    f.write("\n")
    f.write(str(q5))
    f.write("\n\n")



    q6_question ="6. How many students don't have full lunch? Show them"
    f.write(str(q6_question))
    f.write("\n")
    q6_query="match (s:Student) where s.lunch<>'completed' return count(s) "
    q6 = connection.query(q6_query)
    f.write(str(q6_query))
    f.write("\n")
    f.write(str(q6))
    f.write("\n\n")





    q7_question ="7. How many students have parents with academic degree of high school?"
    f.write(str(q7_question))
    f.write("\n")
    q7_query="match (s:Student)-[:HAS_PARENT_WITH_EDUCATION]->(p:Parents) where p.level = 'high school' return count(s)"
    q7 = connection.query(q7_query)
    f.write(str(q7_query))
    f.write("\n")
    f.write(str(q7))
    f.write("\n\n")





    q8_question ="8.Presents the average result of the Math exam by the students who didn't do the preparation test course."
    f.write(str(q8_question))
    f.write("\n")
    q8_query="match (s:Student)-[:DID_PREPARATION_COURSE]->(p:PreparationCourse) where p.prepCourse = 'none' match(s)-[:SCORED]->(g:Grades)  return round(avg(toInteger(g.math))*100)/100 as avgMathGradeWithoutPreparation"
    q8 = connection.query(q8_query)
    f.write(str(q8_query))
    f.write("\n")
    f.write(str(q8))
    f.write("\n\n")




    q9_question ="9.Presents the average result of all the exams made by the students who did the preparation test course."
    f.write(str(q9_question))
    f.write("\n")
    q9_query="match (s:Student)-[:DID_PREPARATION_COURSE]->(p:PreparationCourse) where p.prepCourse='completed' match(s)-[:SCORED]->(g:Grades) return round(avg(toInteger(g.math))) as MathExam, round(avg(toInteger(g.writing))) as WritingExam, round(avg(toInteger(g.reading))) as ReadingExam, p.prepCourse"
    q9 = connection.query(q9_query)
    f.write(str(q9_query))
    f.write("\n")
    f.write(str(q9))
    f.write("\n\n")


    q10_question ="10. List all the students that had more than 85 on the writing score and didn't have any preparation for it. Order in a descending order."
    f.write(str(q10_question))
    f.write("\n")
    q10_query="match (s:Student)-[:DID_PREPARATION_COURSE]->(p:PreparationCourse) where p.prepCourse = 'none'  match(s)-[:SCORED]->(g:Grades) where toInteger(g.math) >= 85 return ID(s) as Student, g.math as grade order by grade desc" 
    q10 = connection.query(q10_query)
    f.write(str(q10_query))
    f.write("\n")
    f.write(str(q10))
    f.write("\n\n")



    




