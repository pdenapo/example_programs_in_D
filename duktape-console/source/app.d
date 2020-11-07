// This program shows how to embed duketape into your D program

import std.stdio;
import std.string;
import core.stdc.stdio: printf;
// The modules to use duketape
import duktape;
// This module contains the low-level C API
// import etc.c.duktape;

import gnu.readline;

// We want to use a function not declared in the module gnu.readline
// declared in the header readline/history.h
extern (C) 
{
  void add_history (const char *);
}

static void print(string msg)
{
    writeln(msg);
}

int main()
{
	writeln("Duketape console using d-duktape y GNU Readline");

	duk_context *ctx = duk_create_heap_default();
    if (!ctx) {
        writeln("Failed to create a Duktape heap.");
        return 1;
    }

    scope(exit) duk_destroy_heap(ctx);
	
    duk_push_global_object(ctx);
    //duk_print_alert_init(ctx, 0);
	
	while (true) 
	{
		char* line = readline (">");
		if (!line)
        	break; 	
		add_history (line);
		writeln("sigo vivo");
		duk_eval_string(ctx, line);
		writeln("sigo vivo 2");
		//duk_get_int(ctx, -1);
        //printf("=%d\n", cast(int) duk_get_int(ctx, -1));

	} /* end of while loop */

	return 0;
}

