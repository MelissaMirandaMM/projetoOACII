/* Implementacao de uma ULA que executa as operações de soma (controle = 1) e
subtração (controle = 0), considerando dois operandos com 8 bits cada. 
*/

module main(inputA, inputB, control, register);
    input [7:0] inputA, inputB; // Entradas de 8 bits
    input control; // control 1 para soma ou 0 para subtração
    output [7:0] register; // Saída de 8 bits
    reg [7:0] s3; // Saída intermediária
    wire [7:0] wire1, wire2; // Saídas intermediárias

    assign wire1 = inputA; // inputA recebe fio wire1
    assign wire2 = inputB; // inputB recebe fio wire2
    assign register = s3; // atribui registrador s3 à saída

    always @(control)
    begin
        if(control == 1'b1) // Se o control for 1, soma
            s3 = wire1 + wire2;
    end

    always @(control)
    begin
        if(control == 1'b0) // Se o controle for 0, subtrai
            s3 = wire1 - wire2;
    end

endmodule