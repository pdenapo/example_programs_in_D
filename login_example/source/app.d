

// Author: Pablo De Nápoli <pdenapo@gmail.com>
// License: MIT

import vibe.vibe;
import vibe.web.auth;
import vibe.web.web;
import vibe.http.server;

// In a real application the user credentials should not be hard coded on the source!

const string required_username= "user";
const string required_password= "secret";

static struct WebAuthInfo {
	string userName;
 }


@requiresAuth
static class Web_Interface 
{
    private {
		// stored in the session store
	SessionVar!(bool, "authenticated") user_authenticated;
	SessionVar!(string, "user_name") user_name;
	SessionVar!(string, "user_password") user_password;
	}
	

	@safe @noRoute WebAuthInfo authenticate(scope HTTPServerRequest req, scope HTTPServerResponse res)
	{
	  if (!user_authenticated) 
		throw new HTTPStatusException(HTTPStatus.unauthorized);
	  else 
		return WebAuthInfo(user_name);
	}
	
   // GET /
   @noAuth void index()
	{
	string nombre_del_programa="Login example";
	string descripcion="Example of a minimal login application using vibe-d"; 

	if (!user_authenticated)
	{
		
		render!("login.dt",nombre_del_programa,descripcion);
	}
	else 
		render!("private.dt",nombre_del_programa,descripcion);
  }
	

    @headerParam("username", "username") @headerParam("password", "password")
    @noAuth @path("/login") 
    void postLogin(string username, string password)
	{
	logInfo("Comenzamos el método login username=" ~ username ~ ",password=" ~ password);
	bool chequeo_de_credenciales = username == required_username && 
											   password == required_password ;
	logInfo("chequeo_de_crenciales=" ~ to!string(chequeo_de_credenciales));
	if (!chequeo_de_credenciales)
		throw new HTTPStatusException(HTTPStatus.unauthorized,"Invalid user name or password.");
	user_authenticated = true;
	user_name = username;
	user_password =  password;
	
	redirect("/");
   }
   

    @anyAuth @path("/logout") 
	void getLogout()
	{
		user_authenticated = false;
		terminateSession();
		redirect("/");
	}


}


void main()
{
	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["127.0.0.1"];
	settings.sessionStore = new MemorySessionStore;
	
	auto router = new URLRouter;
    router.registerWebInterface(new Web_Interface);
	
	listenHTTP(settings, router);

	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
	runApplication();
}

