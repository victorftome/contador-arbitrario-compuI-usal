// La implementación del biestable JK por modelo de comportamiento.
// Se encargara de ir almacenando la secuencia correspondiente.
// El biestable se actualizara en flancos de bajada.
//
// Entradas:
// 	J: Es la entrada SET del biestable.
// 	K: Es la entrada RESET del biestable.
// 	C: Es la entrada del reloj para poder hacer que se ejecute de forma síncrona.
//
// Salidas:
// 	Q: La salida donde se ve reflejado el estado del biestable 1 o 0.
// 	nQ: Es la salida negada del biestable, es basicamente el opuesto de Q.
module JKDown(output reg Q, output wire nQ, input wire J, input wire K, input wire C);
	initial Q = 0;
	not(nQ, Q); // Se realiza el opuesto de Q.

	// Se especifica que siempre que C se encuentre en un flanco de
	// bajada se ejecutara el codigo contenido en el bloque always.
	always @(negedge C)
		case ({J, K}) // Este case se encargara de similar el comportamiento del biestable por modelo de comportamiento.
			2'b10: Q = 1;
			2'b01: Q = 0;
			2'b11: Q = ~Q;
		endcase
endmodule
