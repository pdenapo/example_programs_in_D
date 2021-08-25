import std.stdio;
import std.random;
import std.algorithm;

const cuantas_cartas=10;

void main()
{
 int[] mazo,mazo_inicial;
 long[int] veces_por_carta;
 long cartas_elegidas;	
 int[3] jugador1;
 int[3] jugador2;

 const long cuantas_veces=10000000;
 long vez=0;
 long favorables=0;
 // Inicializamos el mazo
 mazo_inicial = [];
 for (int k=1;k<=cuantas_cartas;k++)
	mazo_inicial ~= k;
 //writeln(mazo);

 while (vez<cuantas_veces)
 {
 vez++;
 writeln("vez=",vez);
 
 mazo=mazo_inicial.dup();

 for (int k=0;k<6;k++)
 {
    int carta_elegida=choice(mazo);
	cartas_elegidas++;
	veces_por_carta[carta_elegida]++;
	mazo=mazo.remove!(carta => carta == carta_elegida);
	//writeln("carta_elegida=",carta_elegida);
	//writeln("mazo=",mazo);
	switch (k)
	{
		case 0: jugador1[0]=carta_elegida;
				break;
		case 1: jugador2[0]=carta_elegida;
				break;
		case 2: jugador1[1]=carta_elegida;
				break;
		case 3: jugador2[1]=carta_elegida;
				break;
		case 4: jugador1[2]=carta_elegida;
				break;
		case 5: jugador2[2]=carta_elegida;
				break;									
		default: assert(0);
	};   
	}; // repartir las cartas
	writeln("jugador1=",jugador1);
	writeln("jugador2=",jugador2);
	
	// ¿tiene el jugador 1 la carta 1?

	if ((jugador1[0]==1) || (jugador1[1]==1) || (jugador1[1]==1))
	{
		writeln("caso favorable");
		favorables++;
	}

 } // una simulación

 foreach(carta;mazo_inicial)
   writeln(carta,"\t",cast(float) veces_por_carta[carta]/cast(float) cartas_elegidas);
 /*writeln(veces_por_carta);*/
 writeln("Casos favorables=",favorables);	
 writeln("Probabilidad estimada=",cast(float) favorables/cast(float) cuantas_veces);

}
