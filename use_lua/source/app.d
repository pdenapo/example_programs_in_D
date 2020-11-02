// A nice video explaining how to embed Lua into a C++ program
//  https://www.youtube.com/watch?v=4l5HdmPoynw

// import std.stdio;
import std.string;
// La librería para usar Lua
import luad.all;

void main()
{
	string cmd = "print(\"hola desde Lua!\")";
	auto lua = new LuaState;
	lua.openLibs();

	lua.doString(cmd);
}

