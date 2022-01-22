// El modulo del contador arbitrario a comprobar.
`include "ContadorArbitrario.v"

// El modulo donde comprobaremos que el funcionamiento del contador
// desarrollado con puertas AND y OR funciona correctamente.
module test;
        reg C;
        wire [3:0] Q;
        ContadorArbitrario contador(Q, C); // El contador arbitrario desarrollado.

	// Hacemos que cada vez que pasa una unidad de tiempo el estado del "reloj" se actualice.
        always #1 C = ~C;

        initial
        begin
        	// Creamos el cronograma para su posterior estudio.
                $dumpfile("contadorArbitrario.dmp");
                $dumpvars(2, contador);

                C = 0;
                #500
                $dumpoff;
                $finish;
        end
endmodule

