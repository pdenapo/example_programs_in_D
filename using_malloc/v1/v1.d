import std.stdio;
import core.stdc.stdlib;
import std.string;
import core.stdc.string;

struct Prueba { 

  char* pointer;
  string name;

  this(string given_name)
  {
	writeln("calling the constructor");
	pointer= cast (char*) malloc(char.sizeof*10);
  name=given_name;

	char* p= pointer;
	*p= 'a';
	p++;
	*p= 'b';
	p++;
	*p= '\n';
	p++;
	*p= '\0';
  }

  ~this()
  {
	writeln("\n calling the destructor");
	free(pointer);
  }

  void print()
  {
	printf("Using printf %s \n",pointer); 
  }

  
  string toString()
  {
	ulong len=strlen(pointer);
	return cast(string) pointer[0..len];	  
   }

}

/* El prolema no es writeln cualquier otra función que usemos produce el mismo
problema. Parece que la llamada involucra una construcción por copia. Las
clases hacen mejor lo que queremos! */

void probando(Prueba q)
{
  q.print();
}

void main()
{
  writeln("version 1");
  Prueba p=Prueba("a");
  probando(p);
}

