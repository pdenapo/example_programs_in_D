import { dlopen, FFIType} from "bun:ffi";

const path = `./mylib/libexample_mylib.so`;

const mylib = dlopen(path, {
    say_hello: {
    args: [],
    returns: FFIType.cstring,
  },
  square: {
    args: [FFIType.int],
    returns: FFIType.int
  }
});

mylib.symbols.say_hello()

console.log("The square of 3 is "+mylib.symbols.square(3))