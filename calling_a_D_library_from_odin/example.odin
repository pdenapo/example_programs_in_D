package example

import "core:c"
import "core:fmt"
import "core:strings"

//when ODIN_OS == .Windows do foreign import foo "libexample_mylib.lib"
//when ODIN_OS == .Linux do foreign import foo "libexample_mylib.a "

foreign {
	hello_init :: proc() ---
	say_hello :: proc() ---
	square :: proc(x: c.int) -> c.int ---
	greeting :: proc(name: cstring) -> cstring ---
  	create_account :: proc(id: i64, type: i32, balance: f64) -> Account ---
	hello_terminate :: proc() ---
}

Account :: struct {
    id:   i64,
    type: i32,
    balance: f64,
}

main :: proc() {
	hello_init()
	defer hello_terminate()

	say_hello()

	x := square(5)
	fmt.println(x)


	name := strings.clone_to_cstring("Pablo")
	defer delete(name)

	result := greeting(name)

	fmt.println(result)
  account := create_account(123, 7,5)

  fmt.println(account.id)
  fmt.println(account.type)
  fmt.println(account.balance)

}
