import std.stdio;

import std.array : array;
import std.variant;
import mysql;

void main(string[] args)
{
	// Connect
	auto connectionStr = "host=localhost;port=3306;user=pablo;pwd=prueba;db=prueba";
	if(args.length > 1)
		connectionStr = args[1];
	Connection conn = new Connection(connectionStr);
	scope(exit) conn.close();
	
	ulong rowsAffected = conn.exec("DROP TABLE IF EXISTS test;");
	writeln("rowsAffected=",rowsAffected);
	
	ulong rowsAffected2 = conn.exec("CREATE TABLE test ( name VARCHAR(10) PRIMARY KEY NOT NULL, surname VARCHAR(10) );");
	writeln("rowsAffected2=",rowsAffected2);

	ulong rowsAffected3 = conn.exec("INSERT INTO test VALUES('John','Smith');");
	writeln("rowsAffected3=",rowsAffected3);

	// Query
	ResultRange range = conn.query("SELECT * FROM test WHERE name = 'John';");
	Row row = range.front;
	writeln("name=",row[0]);
	writeln("surname",row[1]);
}
	

