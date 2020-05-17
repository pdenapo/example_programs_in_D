/* An example showing how to call a C library (in this case GNU libmatheval)
  from a D program */

import std.stdio;
import std.string;

/* Declarations taken form the C header matheval.h */
extern (C) 
{
 void *evaluator_create(char* s);
 void evaluator_destroy(void *evaluator);
 double evaluator_evaluate_x(void *evaluator, double x);
}

const BUFFER_SIZE=256;

void main()
{
	string buffer="x*2+3";
	char* c_buffer= cast (char*)std.string.toStringz(buffer);
	void *evaluator = evaluator_create (c_buffer);
	double resultado = evaluator_evaluate_x(evaluator, 5);
	writeln("Resultado=",resultado);
	evaluator_destroy(evaluator);
}
