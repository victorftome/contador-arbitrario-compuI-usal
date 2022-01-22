// El cambiador que se encargara de transiciones los numeros fuera de la secuancia
// para que no se produzca un bucle infinito.
//
// Entradas:
// 	I[3:0] - Los valores a cambiar por sus correspondientes
// 	nI[3:0] - Los valores de entradas negados
//
// Salidas:
// 	O[3:0] - El numero de 4 bits al que se ha cambiado.
module Cambiador(output wire [3:0] O, input wire [3:0] I, input wire [3:0] nI);
	// Los cables necesario para realizar las operaciones definidas en los mapas de Karnaugh
	wire nI2andI1andnI0, I2andnI3, nI0andnI1andI2andnI3, nI2andI0, I3andI0andnI1, I3andI0, I1andI0;

	// Las operaciones AND obtenidas de los mapas de Karnaugh
	and(nI2andI1andnI0, nI[2], I[1], nI[0]);                   //O3
	and(nI3andI1andnI0, nI[3], I[1], nI[0]);                   //O2
	and(I2andnI3, I[2], nI[3]);                                //O1
	and(nI0andnI1andI2andnI3, nI[0], nI[1], I[2], nI[3]);      //O0
	and(nI2andI0, nI[2], I[0]);                                //O0
	and(I3andI0, I[3], I[0]);                                  //O0
	and(I1andI0, I[1], I[0]);                                  //O0

	// Las operaciones OR obtenidas de los mapas de Karnaugh
	// Como hemos decidido expresar la funcion booleana como suma de miniterminos
	// seran las ultimas operaciones a realizar.
	or(O[3], I[3], nI2andI1andnI0);
	or(O[2], I[2], nI3andI1andnI0);
	or(O[1], I[1], I2andnI3);
	or(O[0], nI0andnI1andI2andnI3, nI2andI0, I3andI0, I1andI0);
endmodule
