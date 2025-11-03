add_rules("mode.debug", "mode.release")

target("mylib")
    set_kind("static")
    add_files("mylib/*.d")
    add_includedirs("mylib", {public = true})

    
target("test")
    set_kind("binary")
    add_files("source/*.d")
    add_deps("mylib")
