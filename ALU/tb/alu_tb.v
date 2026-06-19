module alu_tb;

    reg [3:0] A, B;
    reg [2:0] opcode;
    wire [3:0] result;
    wire carry, zero;

    alu uut(.A(A), .B(B), .opcode(opcode), .result(result), .zero(zero), .carry(carry));

    initial begin
        A = 4'hA; B = 4'h2; opcode = 3'b000; #10;
        A = 4'hF; B = 4'h1; opcode = 3'b000; #10;
        A = 4'h4; B = 4'h7; opcode = 3'b000; #10;

        A = 4'hB; B = 4'h3; opcode = 3'b001; #10;
        A = 4'h5; B = 4'h5; opcode = 3'b001; #10;
        A = 4'h2; B = 4'h3; opcode = 3'b001; #10;
        
        A = 4'hF; B = 4'h0; opcode = 3'b010; #10; 
        A = 4'hF; B = 4'h6; opcode = 3'b010; #10; 
        A = 4'hA; B = 4'h5; opcode = 3'b010; #10; 

        A = 4'h0; B = 4'h0; opcode = 3'b011; #10;
        A = 4'hA; B = 4'h5; opcode = 3'b011; #10;
        A = 4'h3; B = 4'h1; opcode = 3'b011; #10;

        A = 4'h5; B = 4'hC; opcode = 3'b100; #10;
        A = 4'h7; B = 4'hF; opcode = 3'b100; #10;
        A = 4'hF; B = 4'hF; opcode = 3'b100; #10;

        A = 4'hF; B = 4'h1; opcode = 3'b101; #10;
        A = 4'hA; B = 4'h1; opcode = 3'b101; #10;
        A = 4'hC; B = 4'h1; opcode = 3'b101; #10;

        A = 4'hF; B = 4'h3; opcode = 3'b110; #10;
        A = 4'h8; B = 4'h3; opcode = 3'b110; #10;
        A = 4'h6; B = 4'h3; opcode = 3'b110; #10;

        A = 4'hF; B = 4'h3; opcode = 3'b111; #10;
        A = 4'h1; B = 4'h3; opcode = 3'b111; #10;
        A = 4'hC; B = 4'h3; opcode = 3'b111; #10;
    end


endmodule