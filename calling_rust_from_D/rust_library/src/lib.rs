
use std::os::raw::c_char;
use std::ffi::CString;

#[no_mangle]
pub extern "C" fn add(left: u32, right: u32) -> u32 {
    left + right
}

#[no_mangle]
pub extern "C" fn create_string() -> *const c_char {
    let c_string = CString::new("Hello from rust!").expect("CString::new failed");
    c_string.into_raw() 
}

#[no_mangle]
pub unsafe extern "C" fn free_string(ptr: *const c_char) {
    let _ = CString::from_raw(ptr as *mut _);
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add(2, 2);
        assert_eq!(result, 4);
    }
}
