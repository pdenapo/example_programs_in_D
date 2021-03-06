import std.stdio;

import ddbc;
//import std.conv;
import std.experimental.logger;

/* A database connection managed by ddbc */
Connection db_conn;
Statement db_stmt; 

void create_table()
 {
  const  string sql_stmt_1 ="DROP TABLE IF EXISTS test;"; 
  db_stmt.executeUpdate(sql_stmt_1);
  const  string sql_stmt_2 =" 
  CREATE TABLE test ( name VARCHAR(10) PRIMARY KEY NOT NULL, surname VARCHAR(10) );";
  db_stmt.executeUpdate(sql_stmt_2);
 }

void insert_data()
{
  const sql_command ="INSERT INTO test VALUES('John','Smith');"; 
  db_stmt.executeUpdate(sql_command);

}

string get_data_without_next()
 {
   writeln("get_data_without_next method");
   const string comando_sql = "SELECT * FROM test WHERE name = 'John';"; 
   auto rs = db_stmt.executeQuery(comando_sql);
   string data = rs.getString(2); // column 2
   return data;
}

string get_data_with_next()
 {
   writeln("get_data_with_next method");
   const string comando_sql = "SELECT * FROM test WHERE name = 'John';"; 
   auto rs = db_stmt.executeQuery(comando_sql);
   rs.next(); /* We get the first result, this seems to be requiered */
   string data = rs.getString(2); // column 2
   return data;
 }


int main(string[] args) {

    // provide URL for proper type of DB

    //string url = "postgresql://localhost:5432/ddbctestdb?user=ddbctest,password=ddbctestpass,ssl=true";
    //string url = "mysql://localhost:3306/ddbctestdb?user=ddbctest,password=ddbctestpass";
    //string url = "sqlite:testdb.sqlite";
    //string url = "sqlite::memory:";
	
    // creating Connection
    db_conn = createConnection(url);
    
    // creating Statement
    db_stmt = db_conn.createStatement();
   
    create_table();
    insert_data();
  
    // We should get Smith
    // sqlite driver returns 'Smith'

    // sqlite driver returns '' 
    writeln("result without next=",get_data_without_next());
    
    // mysql dirver rises an exception  
    // ddbc.core.SQLException@../../../.dub/packages/ddbc-0.5.0/ddbc/source/ddbc/drivers/mysqlddbc.d(850): No current row in result set
    // using mariaDB Ver 15.1 Distrib 10.3.17-MariaDB, for debian-linux-gnu (x86_64)
    
    writeln("result with next=",get_data_with_next());
     
    
    db_stmt.close();
    db_conn.close();
    return 0;
}
	
