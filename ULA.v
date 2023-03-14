module ULA (input         clk,
			input  [0:3]  inputULA, 
			input  [0:31] a,
			input  [0:31] b,
			output reg [0:31] outputULA);
	
	always @(posedge clk) begin
		case(inputULA)
			4'b0000: outputULA <= a & b; //AND
			4'b0001: outputULA <= a | b; //OR
			4'b0010: outputULA <= a + b; //add
			4'b0110: outputULA <= a - b; // subtract
			4'b0111: outputULA <= (a < b) ? 1 : 0; // set on less than
			default: outputULA <= 0; 
		endcase
	end
endmodule
