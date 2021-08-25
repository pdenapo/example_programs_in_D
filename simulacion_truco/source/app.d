import std.stdio;
import core.stdc.stdlib;
import std.math.rounding;

const cuantas_cartas =40;
const long cuantas_veces=1;
bool[cuantas_cartas] mazo;
long[cuantas_cartas] veces_por_carta;
long cartas_elegidas;

void main()
{
  long vez=0;
  long favorables=0;
 
 while (vez<cuantas_veces)
 {
 vez++;
 writeln("vez=",vez);
 
 int cartas_en_el_mazo=40;
 for (int k=0;k<cuantas_cartas;k++)
	mazo[k]=false;
 int quedan_en_el_mazo=cuantas_cartas;
 
 for (int k=0;k<6;k++)
 {
    
	float random= cast(float) rand()/cast(float)(RAND_MAX);
	int escalado=cast (int) floor(random*float(quedan_en_el_mazo));
	writeln("ecalado=",escalado);
	int buscamos_carta= escalado;
	int carta_elegida;

	for(int j=0;j<escalado;j++)
	{
	  if(!mazo[j])
	  {
		writeln("j=",j," buscamos_carta=",buscamos_carta);
		if (buscamos_carta==0)
		{
			carta_elegida=j;
			break;
		}
		else 
			buscamos_carta--;  
	  }
	  else 
	  	continue;	
	}

	cartas_elegidas++;
	writeln("carta_elegida=",carta_elegida);
	veces_por_carta[carta_elegida]++;
	mazo[carta_elegida]= true; /* la marcamos como elegida */
	quedan_en_el_mazo--;
	
	/*
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
*/
 } // una simulación



}

 writeln("Frecuencias de las cartas");
 for (int k=0;k<cuantas_cartas;k++)
   writeln(k,"\t",cast(float) veces_por_carta[k]/cast(float) cartas_elegidas);
 	
/*writeln(veces_por_carta);*/

/* writeln("Casos favorables=",favorables);	
 writeln("Probabilidad estimada=",cast(float) favorables/cast(float) cuantas_veces);
*/

}