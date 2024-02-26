import std.stdio;
import std.conv;

extern (C) 
{
 uint add(uint left, uint right);
 char* create_string();
 void free_string(char* p);
}

void main()
{
  char *message = create_string();
  writeln(to!string(message));
  free_string(message);
  uint result=add(2,3);
  writeln("result=",result);
  //writeln(hello());
}
