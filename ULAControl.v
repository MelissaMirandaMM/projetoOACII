module ULAControl(input            clk,
			      input      [0:1] OpALU,
				  input      [0:5] funct,
				  output reg [0:3] inputALU);

	always @(posedge clk) begin
		if(OpALU == 2'b00) begin //Instrução LW e SW
			inputALU = 4'b0010;
		end
		else if(OpALU == 2'b01) begin //Branch Equal
			inputALU = 4'b0110;
		end
		else if(OpALU == 2'b10) begin //Tipo R
			if (funct == 6'b100000) begin //add
				inputALU = 4'b0010;
			end
			else if (funct == 6'b100010) begin //subtract
				inputALU = 4'b0110;
			end
			else if (funct == 6'b100100) begin //AND
				inputALU = 4'b0000;
			end
			else if (funct == 6'b100101) begin //OR
				inputALU = 4'b0001;
			end
			else if (funct == 6'b101010) begin //set on less than
				inputALU = 4'b0111;
			end
		end
		
	end

endmodule