import std.stdio;
import std.string;

void main()
{
	auto archivo_de_cotizaciones = File(
		"./tabla.txt", "r");
	int nro_de_fila = 0;
	foreach (fila; archivo_de_cotizaciones.byLine())
	{
		++nro_de_fila;
		/* saltamos la primera fila que es el encabezado */
		if (nro_de_fila == 1)
			continue;
		writeln(fila.split[3]);
	}
}
