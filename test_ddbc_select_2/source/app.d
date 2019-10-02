/* Test example for my bug report in odbc, now with a separated
 createStatement for each sql command */

import std.stdio;

import ddbc;
//import std.conv;
import std.experimental.logger;

/* A version creating  a new statement for sql invocation
 * as suggested by Samael */

/* A database connection managed by ddbc */
Connection db_conn;

void update_sql(string sql)
{
 Statement db_stmt = db_conn.createStatement();
 db_stmt.executeUpdate(sql);
 db_stmt.close();	
} 
	
void create_table()
 {
  const  string sql_stmt_1 ="DROP TABLE IF EXISTS test;"; 
  const  string sql_stmt_2 =" 
  CREATE TABLE test ( name VARCHAR(10) PRIMARY KEY NOT NULL, surname VARCHAR(10) );";
  update_sql(sql_stmt_1);
  update_sql(sql_stmt_2);
 }

void insert_data()
{
  const sql_command ="INSERT INTO test VALUES('John','Smith');"; 
  update_sql(sql_command);

}


string get_data_without_next()
 {
   writeln("get_data_without_next method");
   const string comando_sql = "SELECT * FROM test WHERE name = 'John';"; 
   Statement db_stmt = db_conn.createStatement();
   ResultSet rs = db_stmt.executeQuery(comando_sql);	
   string data = rs.getString(2); // column 2
   db_stmt.close();
   return data;
}

string get_data_with_next()
 {
   writeln("get_data_with_next method");
   const string comando_sql = "SELECT * FROM test WHERE name = 'John';"; 
   Statement db_stmt = db_conn.createStatement();
   ResultSet rs = db_stmt.executeQuery(comando_sql);	
   rs.next(); /* We get the first result, this seems to be requiered */
   string data = rs.getString(2); // column 2
   db_stmt.close(); // have to do that after using the data
   return data;
}


int main(string[] args) {

    // provide URL for proper type of DB

    //string url = "postgresql://localhost:5432/ddbctestdb?user=ddbctest,password=ddbctestpass,ssl=true";
    //string url = "mysql://localhost:3306/ddbctestdb?user=ddbctest,password=ddbctestpass";
    // string url = "mysql://127.0.0.1:3306/prueba?user=pablo,password=prueba";

    string url = "sqlite:testdb.sqlite";
    //string url = "sqlite::memory:";
	
	writeln("Test using a separated createStatement for each sql statament");
	
    // creating Connection
    db_conn = createConnection(url);
    
    // creating Statement
   
    create_table();
    insert_data();
  
    // We should get Smith
    // sqlite driver returns 'Smith'

    // sqlite driver returns '' 
    // writeln("result without next=",get_data_without_next());
    
    // mysql dirver rises an exception  
    // ddbc.core.SQLException@../../../.dub/packages/ddbc-0.5.0/ddbc/source/ddbc/drivers/mysqlddbc.d(850): No current row in result set
    // using mariaDB Ver 15.1 Distrib 10.3.17-MariaDB, for debian-linux-gnu (x86_64)
    
    writeln("result with next=",get_data_with_next());
     
    db_conn.close();
    return 0;
}
	
