`include "ContadorArbitrarioPuertasNAND.v"

// El modulo donde comprobaremos que el funcionamiento del contador desarrollado con puertas NAND
// Sera igual que con el que comprobamos el funcionamiento del contador con puertas AND y OR
module test;
        reg C;
        wire [3:0] Q;
        ContadorArbitrarioNAND contador(Q, C);

        always #1 C = ~C;

        initial
        begin
                $dumpfile("contadorArbitrarioNAND.dmp");
                $dumpvars(2, contador);

                C = 0;
                #500
                $dumpoff;
                $finish;
        end
endmodule

