import std.stdio;
import core.runtime;
import std.conv;
import std.string:toStringz;
import core.stdc.stdlib : malloc, free;
import core.stdc.string : strcpy, strlen;


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

extern (C) char* greeting(char* name)
{
    // Construir el string en D
    string result = "Hello " ~ to!string(name) ~ "!";

    // Convertir a C-string temporal (memoria del GC)
    auto tmp = result.toStringz();
    size_t len = strlen(tmp) + 1;

    // Copiar a memoria que el llamador controla
    char* buf = cast(char*) malloc(len);
    if (buf is null)
        return null;

    strcpy(buf, tmp);
    return buf;   // el llamador debe hacer free()
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
