//This example shows how to serialize a type using two different 
// policies.

import vibe.data.serialization;
import vibe.data.json;
import std.stdio;
import std.conv;

struct Complex
{
 int a;
 int b;
}

template ComplexPolicy (C)
{ 
 @safe int[string] toRepresentation(Complex z)
 {
  return ["real":z.a,"imag":z.b];
 }
 
 @safe Complex fromRepresentation(int[string] x )
 {
  return Complex(x["real"],x["imag"]);
 }
}


template ComplexPolicy2 (C)
{ 
 @safe int[string] toRepresentation(Complex z)
 {
  return ["r":z.a,"i":z.b];
 }
 
 @safe Complex fromRepresentation(int[string] x )
 {
  return Complex(x["r"],x["r"]);
 }
}

void main()
{	
//   isPolicySerializable chequea que funcione construir un
// objeto con toRepresentation y desarmarlo con fromRepresentation

	static assert(isPolicySerializable!(ComplexPolicy,Complex));
	static assert(isPolicySerializable!(ComplexPolicy2,Complex));
	Complex z= Complex(1,2);
	Json json1 = serializeWithPolicy!(JsonSerializer, ComplexPolicy)(z);
	writeln(json1);
	Json json2 = serializeWithPolicy!(JsonSerializer, ComplexPolicy2)(z);
	writeln(json2);
}
