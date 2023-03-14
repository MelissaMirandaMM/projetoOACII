module ULAControl(input            clk,
			      input      [0:1] OpALU,
				  input      [0:5] funct,
				  output reg [0:3] inputALU);
				  
	always @(negedge clk) begin
		case(OpALU)
			2'b00: inputALU <= 4'b0010; //Instrução LW e SW
			2'b01: inputALU <= 4'b0110; //Branch Equal
			2'b10: case(funct) //Tipo R
					6'b100000: inputALU <= 4'b0010; //add
					6'b100010: inputALU <= 4'b0110; //subtract
					6'b100100: inputALU <= 4'b0000; //AND
					6'b100101: inputALU <= 4'b0001; //OR
					6'b101010: inputALU <= 4'b0111; //set on less than
					default: inputALU <= 4'b0000;
					endcase
			default: inputALU <= 4'b0000;
		endcase
	end
endmodule