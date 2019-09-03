
// Fixed is a module for fixed point arithmetic in D

import jaypha.fixed;
import std.conv;

import vibe.data.serialization;
import vibe.data.json;
import std.stdio;

alias number= Fixed!2;

struct MyStruct
{
  @optional string string_data;
 number fixed_data;
}

void main()
{	
	// We want to be sure that we are using serializable verion of fixed
	static assert(isStringSerializable!number);
	// Let's create a variable with 2 decimal places using the new fromString method
	Fixed!2 a = Fixed!2.fromString("2.5");
	writeln("a=",a);
	
	/* A json string with different types of data */
	string my_json_string = "{\"int_data\":2,
			          \"string_data\":\"hello world!\",
			          \"boolean_data\":true, 
			          \"fixed_data\":\"2.5\" }";
	/* Let's convert it to a Json representation using vibe */
	Json my_json = parseJsonString(my_json_string);
	// vibe Json objects are nicely printed
	writeln("my_json=",my_json);
	// This function authomatically converts a Json object to a D object
	MyStruct my_object = deserializeJson!MyStruct(my_json);
	// Let's check that our data are there...
	writeln("string_data=",my_object.string_data);
	writeln("fixed_data=",my_object.fixed_data);
}
