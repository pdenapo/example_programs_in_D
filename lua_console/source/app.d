// A nice video explaining how to embed Lua into a C++ program
// This can be easily addapted to D
//  https://www.youtube.com/watch?v=4l5HdmPoynw

import std.stdio;
import std.string;
import core.stdc.stdio: printf;
// The module to use Lua
import  bindbc.lua;

import gnu.readline;

// We want to use a function not declared in the module gnu.readline
// declared in the header readline/history.h
extern (C) 
{
  void add_history (const char *);
}

void main()
{
	writeln("Lua console using bindc-lua y GNU Readline");
	lua_State* L= luaL_newstate();
	// cargamos las librerías estándard de Lua
	luaL_openlibs(L);
    
	while (true) 
	{
		char* line = readline (">");
		if (!line)
        	break; 	
		add_history (line);
		int r = luaL_dostring(L,line);

		// if r is 0, the command was excecuted successfully.
		// Otherwise, we print the error message.
		
		if (r != 0)
		{
			writeln("r=",r);
			auto error_message= lua_tostring(L,-1);

			// note that we can call the standard C printf 

			printf("%s \n",error_message);
		}
	} /* end of while loop */
}

