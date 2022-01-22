`include "ContadorArbitrarioPuertasNAND.v"

// Los mismo que su analogo pero usando el contador con puertas NAND
module test;
        reg C;
        wire [3:0] aux;
        wire [3:0] Q;
        ContadorArbitrarioNAND contador(Q, C);

        assign aux[3] = contador.JK3.Q;
        assign aux[2] = contador.JK2.Q;
        assign aux[1] = contador.JK1.Q;
        assign aux[0] = contador.JK0.Q;

        always #1 C = ~C;

        initial
        begin
		$monitor($time, " | | %b(%d) ---> %b (%d)", aux, aux, Q, Q);
                $dumpfile("contadorArbitrarioNumerosFueraSecuenciaNAND.dmp");
                $dumpvars(2, contador);
                C = 0;

                $display("Empezamos en 0: ");

                contador.JK3.Q <= 0;
                contador.JK2.Q <= 0;
                contador.JK1.Q <= 0;
                contador.JK0.Q <= 0;
                #24

                $display("Empezamos en 1: ");

                contador.JK3.Q <= 0;
                contador.JK2.Q <= 0;
                contador.JK1.Q <= 0;
                contador.JK0.Q <= 1;
                #24

                $display("Empezamos en 8: ");

                contador.JK3.Q <= 1;
                contador.JK2.Q <= 0;
                contador.JK1.Q <= 0;
                contador.JK0.Q <= 0;
                #24

                $display("Empezamos en 9: ");

                contador.JK3.Q <= 1;
                contador.JK2.Q <= 0;
                contador.JK1.Q <= 0;
                contador.JK0.Q <= 1;
                #24

                $display("Empezamos en 11: ");

                contador.JK3.Q <= 1;
                contador.JK2.Q <= 0;
                contador.JK1.Q <= 1;
                contador.JK0.Q <= 1;
                #24

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

