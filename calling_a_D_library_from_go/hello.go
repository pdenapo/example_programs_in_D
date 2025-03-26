package main

// #cgo CFLAGS: -g -Wall 
// #cgo LDFLAGS:  -L ${SRCDIR}/mylib -lexample_mylib  -lphobos2 -pthread
// #include <stdlib.h>
// #include "./mylib/mylib/hello.h"
import "C"
import (
"fmt"
"unsafe"
)

func main() {
	C.hello_init();
    fmt.Println("Probando llamar a una función de D")
	C.say_hello();
	x := C.int(20);
	y := C.square(x);
	fmt.Println("y=",y);

	name := C.CString("Pablo")
	defer C.free(unsafe.Pointer(name))
	g:=C.greeting(name);
	// Este puntero no hay que liberarlo porque está controlado por el runtime de D
	
	fmt.Println("g=",C.GoString(g));
	

	C.hello_terminate();
}
