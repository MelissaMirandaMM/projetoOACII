/*

Implementando em verilog uma ULA que receba duas palavras de 32 bits que
suporta as seguintes operações de opALU:

load word 00
store word 00
branch equal 01
add 10
subtract 10
and 10
or 10
set on less than 1

*/

//Observar melhor a questão do clock e fazer testes

module ALU(input clk, input [31:0] a, input [31:0] b, input [1:0] opALU, output reg [31:0] result, output reg zero, output reg carry, output reg overflow);

  always @(posedge clk) begin
    case (opALU)
      2'b00: begin // load or store word (no operation)
        result <= 0;
        zero <= 0;
        carry <= 0;
        overflow <= 0;
      end
      2'b01: begin // branch equal
        if (a == b) begin
          result <= 1;
        end else begin
          result <= 0;
        end
        zero <= (result == 0);
        carry <= 0;
        overflow <= 0;
      end
      2'b10: begin // arithmetic and logical operations
        case (opALU)
          2'b10_00: begin // add
            {carry, result} <= a + b;
            overflow <= (a[31] == b[31]) && (a[31] != result[31]);
            zero <= (result == 0);
          end
          2'b10_01: begin // subtract
            {carry, result} <= a - b;
            overflow <= (a[31] != b[31]) && (a[31] != result[31]);
            zero <= (result == 0);
          end
          2'b10_10: begin // bitwise AND
            result <= a & b;
            zero <= (result == 0);
            carry <= 0;
            overflow <= 0;
          end
          2'b10_11: begin // bitwise OR
            result <= a | b;
            zero <= (result == 0);
            carry <= 0;
            overflow <= 0;
          end
          2'b11_00: begin // set on less than
            if (a < b) begin
              result <= 1;
            end else begin
              result <= 0;
            end
            zero <= (result == 0);
            carry <= 0;
            overflow <= 0;
          end
          default: begin // invalid operation
            result <= 0;
            zero <= 1;
            carry <= 0;
            overflow <= 0;
          end
        endcase
      end
      default: begin // invalid opcode
        result <= 0;
        zero <= 1;
        carry <= 0;
        overflow <= 0;
      end
    endcase
  end
  
endmodule

/* 


----- Exemplo Simplista -----

Implementacao de uma ULA que executa as operações de soma (controle = 1) e
subtração (controle = 0), considerando dois operandos com 8 bits cada. 


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

*/