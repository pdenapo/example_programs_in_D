//import std.stdio;
import vibe.d;

// Test with
// curl -X GET http://127.0.0.1:8083/prueba? -i
// curl -X GET http://127.0.0.1:8083/prueba2? -i
// curl -X GET http://127.0.0.1:8083/api/mensaje -i


interface API_Interface
{
  string getMensaje();
}

class API : API_Interface{

    @safe override string getMensaje()
    {
        logInfo("Método getMensaje llamado");
        return "hola mundo!\n";
    }
}

// Doing it by hand!
void prueba_handler(HTTPServerRequest req, HTTPServerResponse res)
{
    res.headers["Access-Control-Allow-Origin"] = "*";
    res.writeBody("Hello, World with CORS: " ~ req.path~"\n");
 
}


void add_CORS_handler(HTTPServerRequest req, HTTPServerResponse res)
{
    res.headers["Access-Control-Allow-Origin"] = "*";
}


void prueba2_handler(HTTPServerRequest req, HTTPServerResponse res)
{
    res.writeBody("Hello, World 2 with CORS: " ~ req.path ~"\n");

}



// https://github.com/vibe-d/vibe.d/issues/1327

/*
HTTPServerRequestHandler addLogger(HTTPServerRequestDelegate handler)
{
    return (req, res) {
        logInfo("Start handling request %s", req.requestURL);
        handler(req, res);
        logInfo("Finished handling request.");
    };
}*/

void main()
{
	auto router = new URLRouter;
    string my_url= "http://127.0.0.1:8083";

    auto rest_settings = new RestInterfaceSettings();
	rest_settings.baseURL= URL(my_url ~ "/api");
    rest_settings.allowedOrigins=["127.0.0.1"];

	API my_api = new API();
 
    // Esto es lo primero que hay que hacer porque la documentación de Vibe dice Matching ends as soon as a route
    // handler writes a response using `res.writeBody()` or similar means.

       
    // CORS
    router.get("/api/*", delegate void(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        logInfo("hola");
        res.headers["Access-Control-Allow-Origin"] = "*";
    });

    router.registerRestInterface(my_api,rest_settings);

 
 
 	router.get("/prueba",&prueba_handler);

    router.get("/prueba2",&add_CORS_handler);

 
    router.get("/prueba2",&prueba2_handler);

   

    listenHTTP("127.0.0.1:8083", router);
    runApplication();
}