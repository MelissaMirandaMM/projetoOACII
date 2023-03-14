module ULA (
    input clk,
    input [1:0] inputULA,
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] outputULA
);

// 2-bit opcode definitions
parameter LOAD = 2'b00;
parameter BRANCH = 2'b01;
parameter ADD_SUB_AND_OR_SLT = 2'b10;

// internal registers for storing values
reg [31:0] reg_a;
reg [31:0] reg_b;

always @(posedge clk) begin
    // load value from memory into register a
    if (inputULA == LOAD) begin
        reg_a <= a;
    end
    // store value from register a into memory
    else if (inputULA == STORE) begin
        outputULA <= reg_a;
    end
    // branch if a == b
    else if (inputULA == BRANCH) begin
        if (reg_a == b) begin
            $display("Branch taken");
        end
    end
    // perform arithmetic/logic operations
    else if (inputULA[1:0] == ADD_SUB_AND_OR_SLT) begin
        // assign register values to local variables
        integer local_a = reg_a;
        integer local_b = reg_b;

        // perform operation based on opcode
        case (inputULA[1:0])
            ADD_SUB_AND_OR_SLT[0]: outputULA <= local_a + local_b; // add
            ADD_SUB_AND_OR_SLT[1]: outputULA <= local_a - local_b; // subtract
            ADD_SUB_AND_OR_SLT[2]: outputULA <= local_a & local_b; // and
            ADD_SUB_AND_OR_SLT[3]: outputULA <= local_a | local_b; // or
            default: outputULA <= 0; // default value
        endcase
    end
    // set flag based on whether a < b
    else begin
        outputULA <= (reg_a < reg_b) ? 1 : 0;
    end
end

// update register b on every clock cycle
always @(posedge clk) begin
    reg_b <= b;
end

endmodule
