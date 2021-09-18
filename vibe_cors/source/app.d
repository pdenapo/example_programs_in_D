//import std.stdio;
import vibe.d;

interface API_Interface
{
  string getMensaje();
}

class API : API_Interface{

    @safe override string getMensaje()
    {
        logInfo("Método getMensaje llamado");
        return "hola mundo!";
    }
}

// Doing it by hand!
void prueba_handler(HTTPServerRequest req, HTTPServerResponse res)
{
    res.headers["Access-Control-Allow-Origin"] = "*";
    res.writeBody("Hello, World with CORS: " ~ req.path);
 
}

void prueba2_handler(HTTPServerRequest req, HTTPServerResponse res)
{
    res.writeBody("Hello, World 2 with CORS: " ~ req.path);
 
}


void main()
{
	auto router = new URLRouter;
    string my_url= "http://127.0.0.1:8083";


    auto rest_settings = new RestInterfaceSettings();
	rest_settings.baseURL= URL(my_url ~ "/api");
    rest_settings.allowedOrigins=["127.0.0.1"];

	API my_api = new API();
	router.registerRestInterface(my_api,rest_settings);
     

 	router.get("/prueba",&prueba_handler);
    
    router.get("/prueba2",&prueba2_handler);

    // CORS
    router.get("/prueba2", delegate void(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        logInfo("hola");
        res.headers["Access-Control-Allow-Origin"] = "*";
    });

    listenHTTP("127.0.0.1:8083", router);
    runApplication();
}