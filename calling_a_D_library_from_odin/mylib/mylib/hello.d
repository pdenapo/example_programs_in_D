import std.stdio;
import core.runtime;
import std.conv;
import std.string:toStringz;


// If you want to call a library from bun, it is important to use extern (C)
// so that the D compiler uses the C linkage.

extern (C): struct Account {
   long id;
   int type;
   double balance;
}

extern (C) void hello_init()
{
  Runtime.initialize();
}

extern (C) void say_hello()
{
	writeln("Hello, World from D!");
}

extern (C) char* greeting (char* name)
{
	string result= "Hello "~ to!string(name) ~"!"; 
	return cast(char*) result.toStringz();
}

extern (C) int square(int x)
{
	return(x*x);
}

extern (C) Account create_account(long id,int type,double balance)
{
	return Account(id,type,balance);
}

extern (C) void hello_terminate()
{
  Runtime.terminate();
}
