import std.stdio;
import std.ascii : isDigit;
import std.range;

// import d_mpdecimal.deimos;
// import d_mpdecimal.decimal;
// import std.string : translate, empty;

// If the input is a valid number returns it in the standard numerical format
// If not, it returns 
string normalize_number(string s, bool formato_argentino)
{
  if (s.length == 0)
    return "";

  if (s[0] == '-')
    return "-" ~ normalize_number(s[1 .. $], formato_argentino);

  writeln("nomalizing number ", s);
  writeln("formato_argentino=", formato_argentino);
  dchar decimal_separator;
  dchar thousands_separator;

  if (formato_argentino)
  {
    decimal_separator = ',';
    thousands_separator = '.';
  }
  else
  {
    decimal_separator = '.';
    thousands_separator = ',';
  }

  bool decimal_separator_found;
  ulong decimal_separator_index;

  for (ulong i = 0; i < s.length; i++)
  {
    if (s[i] == decimal_separator)
    {
      if (decimal_separator_found) // decimal separators are not allowed
        return "";

      decimal_separator_found = true;
      decimal_separator_index = i;
    }
  }

  string integral_part;
  string decimal_part;

  if (decimal_separator_found)
  {
    integral_part = s[0 .. decimal_separator_index];
    decimal_part = s[decimal_separator_index + 1 .. $];
  }
  else
  {
    integral_part = s;
  }

  writeln("integral_part=", integral_part);
  writeln("decimal_part=", decimal_part);
  writeln("decimal_separator_found=", decimal_separator_found);

  string reduced_integral_part;

  bool thousands_separator_found;

  foreach (index, c; integral_part)
  {
    if (isDigit(c))
    {
      reduced_integral_part ~= c;
      continue;
    }
    else if (c == thousands_separator)
    {
      if (integral_part.length - index == 4)
      {
        thousands_separator_found = true;
        continue;
      }
      else if ((integral_part.length - index) % 4 == 0)
        continue;
      else
        return "";
    }
    else
      return "";
  }

  writeln("reduced_integral_part=", reduced_integral_part);

  if (reduced_integral_part == "")
    return "";

  foreach (c; decimal_part)
  {
    if (isDigit(c))
      continue;
    else
      return "";
  }

  if (decimal_separator_found)
    return reduced_integral_part ~ "." ~ decimal_part;
  else
    return reduced_integral_part;
}

//   assert(!is_valid_number("12.52", true));
//   assert(is_valid_number("12.52", false));
//   assert(!is_valid_number("-12.05,23", true));
//   assert(!is_valid_number("-12.05,23", false));
//   assert(expected_to_be!bool(is_valid_number("18.3360", false), true));
//   assert(expected_to_be!bool(is_valid_number("18.3360", true), false));
//   assert(expected_to_be!bool(is_valid_number("1000", false), true));
//   assert(expected_to_be!bool(is_valid_number("1000", true), true));

// }

@("n0")
unittest
{
  string n0 = normalize_number("12,,5", true);
  writeln("n0=", n0);
  assert(n0 == "");
}

@("n1")
unittest
{
  string n1 = normalize_number("12", false);
  writeln("n1=", n1);
  assert(n1 == "12");
}

@("n2")
unittest
{
  string n2 = normalize_number("12", true);
  writeln("n2=", n2);
  assert(n2 == "12");
}

@("n3")
unittest
{
  string n3 = normalize_number("12,5", true);
  writeln("n3=", n3);
  assert(n3 == "12.5");
}

@("n4")
unittest
{
  string n4 = normalize_number("12,5", false);
  writeln("n4=", n4);
  assert(n4 == "");
}

@("n5")
unittest
{
  string n5 = normalize_number("74,6400", true);
  writeln("n5=", n5);
  assert(n5 == "74.6400");
}

@("n6")
unittest
{
  string n6 = normalize_number("74,6400", false);
  writeln("n6=", n6);
  assert(n6 == "");
}

@("n6")
unittest
{
  string n6 = normalize_number("74,6400", false);
  writeln("n6=", n6);
  assert(n6 == "");
}

@("n7")
unittest
{
  // tiene sentido en formato argentino!
  string n7 = normalize_number("12.521", true);
  writeln("n7=", n7);
  assert(n7 == "12521");
}

@("n8")
unittest
{
  string n8 = normalize_number("12.521", false);
  writeln("n8=", n8);
  assert(n8 == "12.521");
}

@("n9")
unittest
{
  string n9 = normalize_number("1.325.212,52", true);
  writeln("n9=", n9);
  assert(n9 == "1325212.52");
}

@("n10")
unittest
{
  string n10 = normalize_number("1.325.212,52", false);
  writeln("n10=", n10);
  assert(n10 == "");
}

@("n11")
unittest
{
  string n11 = normalize_number("-1.325.212,52", true);
  writeln("n11=", n11);
  assert(n11 == "-1325212.52");
}

@("n12")
unittest
{
  string n12 = normalize_number("1.325.212,52", false);
  writeln("n12=", n12);
  assert(n12 == "");
}

@("n13")
unittest
{
  string n13 = normalize_number("", false);
  writeln("n13=", n13);
  assert(n13 == "");
}

@("n14")
unittest
{
  string n14 = normalize_number("12.25,34", true);
  writeln("n14=", n14);
  assert(n14 == "");
}

@("n15")
unittest
{
  string n15 = normalize_number("12.234.252,341", true);
  writeln("n15=", n15);
  assert(n15 == "12234252.341");
}

@("n16")
unittest
{
  string n16 = normalize_number("12.24.252,341", true);
  writeln("n16=", n16);
  assert(n16 == "");
}
