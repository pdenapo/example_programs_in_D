import std.stdio;
import std.datetime.date;
import std.array;
import std.conv;
import std.format;

Date fecha_desde_string(string s)
{
 string[] s_split = s.split("/");
 int día =to!int(s_split[0]);
 int mes = to!int(s_split[1]);
 int año = to!int(s_split[2]); 
 return Date(año,mes,día);
}

string fecha_como_string(Date d)
{
  return format("%02d",d.day)~"/" ~
         format("%02d",d.month)~"/"~ 
         format("%04d",d.year);	
}

void main()
{
  Date fecha,fecha2;
  string mi_fecha = "12/04/2020";
  fecha = fecha_desde_string(mi_fecha );
  writeln("fecha=",fecha);
  writeln("fecha_como_string=",fecha_como_string(fecha));
  string mi_fecha2 = "03/01/2019";
  fecha2 = fecha_desde_string(mi_fecha2);
  writeln("fecha2=",fecha);
  writeln("fecha_como_string2=",fecha_como_string(fecha2));
  writeln("¿Es anterior?",fecha2 <=fecha);
}
