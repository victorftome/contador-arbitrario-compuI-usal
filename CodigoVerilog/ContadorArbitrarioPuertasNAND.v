`include "biestableJK.v"
`include "cambiadornand.v"

// El contador arbitrario el cual se encargara de seguir la secuencia
// La diferencia es que este ha sido desarrollado usando puertas NAND.
// Ya que estas tienen un coste mas económico.
// 3 -> 7 -> 6 -> 6 -> 15 -> 14 -> 7 -> 10 -> 12 -> 14 -> REPETIR
//
// Entradas:
// 	C: Sera el estado del reloj, ya que se trata de un contador síncrono.
//
// Salidas:
// 	SecuenciaSalida[3:0]: Sera un valor de la secuancia indicada previamente.
//
// Todos los modulos funcionaran de la misma manera que en el contador desarrollado con puertas AND y OR.
// Los unicos cambios han sido las puertas a usar.
module ContadorArbitrarioNAND(output wire [3:0] SecuenciaSalida, input wire C);
	wire [3:0] nQ;
	wire [3:0] Q;
	wire J3, J2, J1, J0, K3, K2, K1, K0;
	wire Q2nandnQ1, Q0nandnQ3, nQ1nandQ3, nQ0nandQ3, Q2nandnQ0, nQ2nandQ0, Q1nandnQ3, nQ2nandnQ1, nQ0nandnQ1, Q2nandQ1;

	// J3
	nand(Q2nandnQ1, Q[2], nQ[1]);
	nand(J3, Q2nandnQ1);

	// J2
	nand(Q0nandnQ3, Q[0], nQ[3]);
	nand(nQ1nandQ3, nQ[1], Q[3]);
	nand(nQ0nandQ3, nQ[0], Q[3]);
	nand(J2, Q0nandnQ3, nQ1nandQ3, nQ0nandQ3);

	// J1
	nand(Q2nandnQ0, Q[2], nQ[0]);
	nand(nQ2nandQ0, nQ[2], Q[0]);
	nand(J1, Q2nandnQ0, Q[3], nQ2nandQ0);

	// J0
	nand(Q1nandnQ3, Q[1], nQ[3]);
	nand(nQ2nandnQ1, nQ[2], nQ[1]);
	nand(J0, Q1nandnQ3, nQ2nandnQ1);

	// K3
	nand(nQ0nandnQ1, nQ[0], nQ[1]);
	nand(K3, Q2nandnQ0, nQ0nandnQ1);

	// K2
	nand(K2, nQ0nandnQ1);

	// K1
	nand(K1, Q2nandnQ0, nQ0nandQ3);

	// K0
	nand(Q2nandQ1, Q[2], Q[1]);
	nand(K0, nQ[3], Q2nandQ1, nQ2nandnQ1);

	JKDown JK0(Q[0], nQ[0], J0, K0, C);
	JKDown JK1(Q[1], nQ[1], J1, K1, C);
	JKDown JK2(Q[2], nQ[2], J2, K2, C);
	JKDown JK3(Q[3], nQ[3], J3, K3, C);
	
	Cambiadornand c(SecuenciaSalida, Q, nQ);
endmodule
