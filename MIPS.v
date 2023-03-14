module MIPS(input             clk,
			input      [0:1]  OpALU,
			input      [0:5]  funct,
			input      [0:31] a,
			input      [0:31] b,
			output     [0:31] outputULA);
	
	
	wire [0:3] inputALU;
	

endmodule

always @(*) begin
    case(opALU)
        2'b00: begin //load word or store word
            if (funct[4:0] == 6'b100011) //lw
                outputULA = 32'b00000000000000000000000000000011;
            else if (funct[4:0] == 6'b101011) //sw
                outputULA = 32'b00000000000000000000000000000011;
        end
        // add, subtract, and, or, set on less than
        // code for other operations
    endcase
end

else if (opALU == 2'b01) begin //branch equal
    if (a == b) 
        outputULA = 1;
    else
        outputULA = 0;
end

else if (opALU == 2'b10) begin //add
    outputULA = a + b;
end

else if (opALU == 2'b10) begin //subtract
    outputULA = a - b;
end

else if (opALU == 2'b10) begin //and
    outputULA = a & b;
end

else if (opALU == 2'b10) begin //or
    outputULA = a | b;
end

else if (opALU == 2'b10) begin //set on less than
    if (a < b)
        outputULA = 1;
    else
