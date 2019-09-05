
import vibe.data.serialization;
import vibe.data.json;
import std.stdio;

struct MyStruct
{
  int int_data;
  string string_data;
  bool boolean_data;
  // you can mark some fields in your structure as optional
  // so that they are not requiered to appear in your Json data
  @optional int optional_data;
}

void main()
{	/* A json string with different types of data */
	string my_json_string = "{\"int_data\":2,
			          \"string_data\":\"hello world!\",
			          \"boolean_data\":true }";
	/* Let's convert it to a Json representation using vibe */
	Json my_json = parseJsonString(my_json_string);
	// vibe Json objects are nicely printed
	writeln("my_json=",my_json);
	// This function authomatically converts a Json object to a D object
	MyStruct my_object = deserializeJson!MyStruct(my_json);
	// Let's check that our data are there...
	writeln("string_data=",my_object.string_data);
	writeln("int_data=",my_object.int_data);
	writeln("boolean_data=",my_object.boolean_data);
	
	// We can also use it the other way round (to generate json data
	// from a struct or class)
	MyStruct other_data= MyStruct(5,"good bye!",true,4);
	Json other_json = serializeToJson(other_data);	
	writeln(other_json);
}
