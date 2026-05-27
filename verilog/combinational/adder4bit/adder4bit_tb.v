module adder4bit_tb;
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire cout;

    adder4bit uut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        a = 4'h0; b = 4'h0; cin = 1'b0; #10;
        a = 4'h4; b = 4'h3; cin = 1'b0; #10;
        a = 4'h7; b = 4'h7; cin = 1'b0; #10;
        a = 4'hf; b = 4'h1; cin = 1'b0; #10;
        a = 4'h0; b = 4'hf; cin = 1'b1; #10;
        a = 4'hf; b = 4'hf; cin = 1'b1; #10;
    end

endmodule