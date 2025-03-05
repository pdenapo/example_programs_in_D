// This module implements a simple web service with a login form and two
// settings that can be changed by the logged in user.
module app;

import std.conv;
import vibe.core.core;
import vibe.core.log;
import vibe.http.fileserver;
import vibe.http.router;
import vibe.http.server;
import vibe.web.web;
import vibe.web.auth;

import mustache;

bool use_authorization = true;
const string nombre_del_programa="Example web application";

MustacheEngine!(string) mustacheEngine;

// código para incluir bootstrap en las páginas web que generamos
// incluirlo en el contexto de Mustache y usarlo con {{{bootstrap}}} 
// en las templates (las triples llaves generan unscaped html)

const string bootstrap_css = "
   <link href=\"/bootstrap/bootstrap-cerulean.min.css\" rel=\"stylesheet\" > ";

// es fundamental poner </script> para que esto funcione!
const string bootstrap_js = "
  <script src=\"/bootstrap/bootstrap.bundle.min.js\"></script>";

// Aggregates all information about the currently logged in user (if any).
static struct WebAuthInfo
{
	string userName;
}

// The methods of this class will be mapped to HTTP routes and serve as
// request handlers.
@requiresAuth static class Web_Interface
{
	string mustacheEngine_path;

	private
	{
		// stored in the session store
		SessionVar!(bool, "authenticated") user_authenticated;
		SessionVar!(string, "user_name") user_name;
		SessionVar!(string, "user_password") user_password;
	}

	this(string resources_path)
	{
		this.mustacheEngine_path = resources_path ~ "/views";
		logInfo("this.mustacheEngine_path=" ~ mustacheEngine_path);
	}

	alias MC = mustache.MustacheEngine!string.Context;

	@noRoute MC new_mustacheContext()
	{
		auto mustacheContext = new MustacheEngine!(string).Context;
		mustacheEngine.path = this.mustacheEngine_path;
		mustacheEngine.level = MustacheEngine!string.CacheLevel.no;
		mustacheContext["bootstrap_css"] = bootstrap_css;
		mustacheContext["bootstrap_js"] = bootstrap_js;
		mustacheEngine.path = this.mustacheEngine_path;
		return mustacheContext;
	}

	@noRoute WebAuthInfo authenticate(scope HTTPServerRequest req, scope HTTPServerResponse res)
	{
		if (use_authorization)
		{
			if (!user_authenticated)
				throw new HTTPStatusException(HTTPStatus.unauthorized);
			else
				return WebAuthInfo(user_name);
		}
		else
			return WebAuthInfo("anónimo");
	}

	// GET /
	@noAuth void index()
	{
		auto mustacheContext = new_mustacheContext();
		mustacheContext["nombre_del_programa"] = nombre_del_programa;

		string html;
		if ((use_authorization && user_authenticated) || !use_authorization)
		{
			html = mustacheEngine.render("home", mustacheContext);
		}
		else
		{
			html = mustacheEngine.render("login", mustacheContext);
		}
		response.writeBody(html, "text/html");
	}

	@anyAuth @path("/about") void getAbout()
	{
		auto mustacheContext = new_mustacheContext();
		mustacheContext["nombre_del_programa"] = nombre_del_programa;
		string html = mustacheEngine.render("about", mustacheContext);
		response.writeBody(html, "text/html");
	}

	@noAuth @path("/mensaje") string getMensaje()
	{
		return nombre_del_programa ~ " escuchando.";
	}

	@noAuth @path("/mensaje2") void getMensaje2()
	{
		// Si uno quiere enviar html al browser hay que hacerlo así!
		// (especificando el tipo mime!)
		response.writeBody("<html><body> " ~ nombre_del_programa ~ " escuchando.</body></html>",
			"text/html");
	}

	@headerParam("username", "username") @headerParam("password", "password")
	@noAuth @path("/login")
	void postLogin(string username, string password)
	{
		logInfo("Comenzamos el método login username=" ~ username ~ ",password=" ~ password);
		bool chequeo_de_credenciales = username == "user"
			&& password == "secret";
		logInfo("chequeo_de_crenciales=" ~ to!string(chequeo_de_credenciales));
		if (!chequeo_de_credenciales)
			throw new HTTPStatusException(HTTPStatus.unauthorized, "Invalid user name or password.");
		user_authenticated = true;
		user_name = username;
		user_password = password;

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

int main(string[] args)
{
	// Create the router that will dispatch each request to the proper handler method
	auto router = new URLRouter;
	// Register our Web_Interface class as a web interface. Each public method
	// will be mapped to a route in the URLRouter
	router.registerWebInterface(new Web_Interface("."));
	// All requests that haven't been handled by the web interface registered above
	// will be handled by looking for a matching file in the public/ folder.
	router.get("*", serveStaticFiles("public/"));

	// Start up the HTTP server
	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];
	settings.sessionStore = new MemorySessionStore;

	auto listener = listenHTTP(settings, router);

	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
	return runApplication(&args);
}
