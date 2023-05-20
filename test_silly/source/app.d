import std.stdio;
import d_mpdecimal.deimos;
import d_mpdecimal.decimal;
import std.string: translate,empty;

Decimal convertir_a_número(string s1, bool formato_argentino)
{
  //debug writeln("DEBUG convertir_a_número ",s1);
  if (s1.empty())
    return Decimal(0);
  string s2;
  foreach (c; s1)
  {
    if ((c == ' ') || (c == '.' && formato_argentino))
      continue;
    s2 ~= c;
  }
  string s3 = translate(s2, [',': '.']);
  //debug writeln("DEBUG s3=", s3);
  clear_status();
  Decimal resultado = Decimal(s3);
  if (get_status() && MPD_Conversion_syntax)
    throw new Exception("Error de sintaxis convitiendo a número " ~ s1);
  //debug writeln("DEBUG resultado=", resultado);
  return resultado;
}

version(unittest) {
	// Do nothing here, dub takes care of that
} else {
	void main() {
		writeln("An example for using the silly test runner.");
		writeln("Run the tests with dub test");
		init_ieee_decimal(128);
		writeln("We write a decimal as an example:");
		writeln(Decimal("12.5"));
	}
}

@("Decimal")
unittest
{
  init_ieee_decimal(128);	
  assert(Decimal("12.5").toString()=="12.5");
}

@("convertir_a_número")
unittest
{
  import std.exception;  
  init_ieee_decimal(128);	
  assert(convertir_a_número("", true) == Decimal("0"));
  assert(convertir_a_número("12,5", true) == Decimal("12.5"));
  assert(convertir_a_número("1.324,5", true) == Decimal("1324.5"));

  assertThrown(convertir_a_número("?", true));
}