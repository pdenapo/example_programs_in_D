import std.stdio;
import std.process;

void main()
{
  auto latex=execute(["lualatex","--interaction=nonstopmode","my_doc.tex"]);
  if (latex.status != 0) writeln("Compilation failed.");
  writeln(latex.output);
}
