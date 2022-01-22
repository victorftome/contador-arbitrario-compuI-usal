// Los modulos necesarios para que el contador arbitrario funcione correctamente
`include "biestableJK.v"
`include "cambiador.v"

// El contador arbitrario el cual se encargara de seguir la secuencia
// 3 -> 7 -> 6 -> 6 -> 15 -> 14 -> 7 -> 10 -> 12 -> 14 -> REPETIR
//
// Entradas:
// 	C: Sera el estado del reloj, ya que se trata de un contador sinncrono.
//
// Salidas:
// 	SecuenciaSalida[3:0]: Sera un valor de la secuancia indicada previamente.
module ContadorArbitrario(output wire [3:0] SecuenciaSalida, input wire C);
	wire [3:0] nQ; // La variable donde almacenar la salida negada de los estados de los biestable.
	wire [3:0] Q; // La variable donde se almacenarÃ¡ la salida de los biestables.

	// Hilos necesarios para realizar las operaciones definidas al realizar los mapas de Karnaugh
	wire nQ1andQ2, Q0andnQ3, nQ1andQ3, nQ0andQ3; 
	wire Q2andnQ0, nQ2andQ0, Q1andnQ3, nQ2andnQ1;
	wire nQ1andnQ0, Q3andnQ0, Q2andQ1;
	wire J2, J1, J0, K3, K1, K0;

	// Las puertas AND definidas en los mapas para el correcto funcionamiento del contador
    
    //K3
    and(nQ1andQ2, nQ[1], Q[2]);
    //J2
    and(Q0andnQ3, nQ[3], Q[0]);
    and(nQ1andQ3, nQ[1], Q[3]);
    and(nQ0andQ3, nQ[0], Q[3]);
    
	//J1
	and(Q2andnQ0, Q[2], nQ[0]);
	and(nQ2andQ0, nQ[2], Q[0]);
	//J0
	and(Q1andnQ3, Q[1], nQ[3]);
	and(nQ2andnQ1, nQ[2], nQ[1]);

    //K3,K1 y K0
	and(nQ1andnQ0, nQ[1], nQ[0]);//K2
	and(Q3andnQ0, Q[3], nQ[0]);
	and(Q2andQ1, Q[2], Q[1]);

	// Las puertas OR que al definirse las funciones como suma de miniterminos seran las ultimas ejecutar.
	
	or(J2, Q0andnQ3, nQ1andQ3, nQ0andQ3);
	or(J1, nQ[3], Q2andnQ0, nQ2andQ0);
	or(J0, Q1andnQ3, nQ2andnQ1);
	or(K3, nQ1andnQ0, Q2andnQ0);

	or(K1, Q2andnQ0, Q3andnQ0);
	or(K0, nQ2andnQ1, Q[3], Q2andQ1);

	// Los 4 biestables necesarios para realizar el contador de 4 bits.
	JKDown JK0(Q[0], nQ[0], J0, K0, C);
	JKDown JK1(Q[1], nQ[1], J1, K1, C);
	JKDown JK2(Q[2], nQ[2], J2, nQ1andnQ0, C);
	JKDown JK3(Q[3], nQ[3], nQ1andQ2, K3, C);

	// El Cambiador del cual ya tomaremos la salida del contador
	Cambiador c(SecuenciaSalida, Q, nQ);
endmodule
