import std.stdio;
import std.process : environment;
import vibe.db.mongo.mongo;
import vibe.db.mongo.client;
import core.stdc.stdlib : exit;

struct User{
  string name;
  int age;
}

void main()
{
   MongoClient 	cliente_mongo;
  
  const mongodb_uri = environment.get("MONGODB_URI", "");
  //string mongo_db_uri = Luca.mi_configuración.configuraciones_string["mongodb_uri"];
  if (mongodb_uri.length == 0)
    throw new Exception("Debe configurar la variable de entorno MONGODB_URI");
  writeln("mongodb_uri=", mongodb_uri);
  const db_name = environment.get("MONGODB_DB", "");
  //string db_name = Luca.mi_configuración.obtener_configuración_string("mongodb_db");
  writeln("db_name=", db_name);
  if (db_name.length == 0)
    throw new Exception("Debe configurar la variable de entorno MONGODB_DB");
  try
  {
    cliente_mongo = connectMongoDB(mongodb_uri);

    //auto db = cliente_mongo.getDatabase(db_name);
  }
  catch (Exception e)
  {
    writeln(e.msg);
    exit(1);
  }
  auto coll = cliente_mongo.getCollection(db_name~".users");
  auto Peter= User("Peter",20);
  auto Paul= User("Paul",30);
  // We clean the collection so that we always get the same result
  coll.drop();

  coll.insertOne(Peter);
  coll.insertOne(Paul);

  writeln("All records");
  // Show all the documents in the collection
  foreach (doc; coll.find())
		writeln(doc.toJson());

  writeln("\nRecords with name=Peter");
  // Show all the documents in the collection with name Peter
    foreach (doc; coll.find(["name":"Peter"]))
		writeln(doc.toJson());
  

  // Avoids leaking the event handler
  cliente_mongo.cleanupConnections();
}
