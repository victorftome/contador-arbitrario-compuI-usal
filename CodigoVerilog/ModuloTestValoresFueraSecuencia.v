`include "ContadorArbitrario.v"

// Modulo con el que comprobamos que empezando desde los valores no contenidos en la secuencia 
// no se produce un bucle infinito y se mete correctamente en la secuancia esperada.
module test;
        reg C;
        wire [3:0] aux;
        wire [3:0] Q;
        ContadorArbitrario contador(Q, C);

	// Asignamos el valor de las variables Q de los biestables Q a los diferentes bits de aux
	// de tal forma cuando queramos sacarlos por pantalla con el monitor será mucho mas sencillo
        assign aux[3] = contador.JK3.Q;
        assign aux[2] = contador.JK2.Q;
        assign aux[1] = contador.JK1.Q;
        assign aux[0] = contador.JK0.Q;

	// La variable que simulara el reloj.
        always #1 C = ~C;

        initial
        begin
                $monitor($time, " | | %b(%d) ---> %b (%d)", aux, aux, Q, Q);
                $dumpfile("contadorArbitrarioNumerosFueraSecuencia.dmp");
                $dumpvars(2, contador);
                C = 0;

                $display("Empezamos en 0: ");

                // Haremos que los estados de los biestable sea 0, para que empiece a contar desde el numero 0
                // Se ha usado el operador <= en vez del = para que se hagan todas las asignaciones a la vez
                // y evitar valores no deseados
                contador.JK3.Q <= 0;
                contador.JK2.Q <= 0;
                contador.JK1.Q <= 0;
                contador.JK0.Q <= 0;
                #24

                // Haremos que la secuencia empiece en el 1. Asignando el estado correspondiente a los
                // diferentes biestables.
                $display("Empezamos en 1: ");

                contador.JK3.Q <= 0;
                contador.JK2.Q <= 0;
                contador.JK1.Q <= 0;
                contador.JK0.Q <= 1;
                #24

                // Haremos que la secuancia empiece en 8
                $display("Empezamos en 8: ");

                contador.JK3.Q <= 1;
                contador.JK2.Q <= 0;
                contador.JK1.Q <= 0;
                contador.JK0.Q <= 0;
                #24

                // Haremos que la secuancia empiece en 9
                $display("Empezamos en 9: ");

                contador.JK3.Q <= 1;
                contador.JK2.Q <= 0;
                contador.JK1.Q <= 0;
                contador.JK0.Q <= 1;
                #24

                // Haremos que la secuancia empiece en 11
                $display("Empezamos en 11: ");

                contador.JK3.Q <= 1;
                contador.JK2.Q <= 0;
                contador.JK1.Q <= 1;
                contador.JK0.Q <= 1;
                #24

                // Haremos que la secuancia empiece en 13
                $display("Empezamos en 13: ");

                contador.JK3.Q <= 1;
                contador.JK2.Q <= 1;
                contador.JK1.Q <= 0;
                contador.JK0.Q <= 1;

                #24
                $dumpoff;
                $finish;
        end
endmodule

