add_rules("mode.debug", "mode.release")

add_requires("dub::colorize", {alias = "colorize"})

target("test")
    set_kind("binary")
    add_files("source/*.d")
    add_packages("colorize")

