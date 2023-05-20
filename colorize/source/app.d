import colorize : fg, color, cwriteln, cwritefln;

void main()
{
  cwriteln("This is blue".color(fg.blue));
  cwriteln("This is blue\n".color("blue"));
  
  // With format
  
  auto colors= ["black","red","blue","green","magenta","yellow","cyan","light_black",
  "light_red","light_green","light_yellow","light_blue","light_magenta","light_cyan"];
  foreach(c;colors)
  {
    cwritefln("This is %s".color(c), c);
  }
}
