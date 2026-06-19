module alu(
    input [3:0] A, B,
    input [2:0] opcode,
    output reg [3:0] result,
    output zero, 
    output reg carry
);

    always @(*) begin
        carry = 1'b0;
        case (opcode)
            3'b000: {carry, result} = A + B;
            3'b001: {carry, result} = A - B;
            3'b010: result = A & B;
            3'b011: result = A | B;
            3'b100: result = A ^ B;
            3'b101: result = ~A;
            3'b110: result = A << 1;
            3'b111: result = A >> 1;
        endcase
    end

    assign zero = (result==0);

endmodule