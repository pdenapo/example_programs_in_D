
import vibe.data.serialization;
import vibe.data.json;
import std.stdio;

class MyClass
{
  int int_data;
}

void main()
{
	string my_json_string = "{\"int_data\":2}";
	Json my_json = parseJsonString(my_json_string);
	writeln(my_json);
	MyClass my_object = deserializeJson!MyClass(my_json);
	writeln("int_data=",my_object.int_data);
}
