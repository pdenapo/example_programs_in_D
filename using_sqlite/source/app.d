import std.stdio;
import d2sqlite3;

class MyDb
{
 Database db;
 
 void abrir()
 {
   //	auto db = Database(":memory");
    // OJO: no ponerlo en el constructor porque genera problemas con el recolector de basura

   writeln("hola");
   db = Database("./prueba.db");
 }
 
 void cerrar()
 {
   db.close();
 }
 
 void insertar_datos()
 {
	db.execute("INSERT INTO person (id,name,score) VALUES (1,'Pablo',8)");
	db.execute("INSERT INTO person (id,name,score) VALUES (2,'Luis',3.5)");
	db.execute("INSERT INTO person (id,name,score) VALUES (3,'Pablo',4.5)");	
 }
 
 void crear_tablas()
 {
	 db.run("DROP TABLE IF EXISTS person;
        CREATE TABLE person (
          id    INTEGER PRIMARY KEY,
          name  TEXT NOT NULL,
          score FLOAT
        )");

 }

 ResultRange obtener_datos()
 {
	ResultRange salida= db.execute("SELECT * FROM person WHERE name == 'Pablo';");
	return salida;
 }
 
}

void main()
{
	auto my_db = new MyDb();
	
	my_db.abrir();
	my_db.crear_tablas();
	my_db.insertar_datos();
	writeln(my_db.obtener_datos());
	my_db.cerrar();
			
}
