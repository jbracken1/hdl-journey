module top_combinational_tb;
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire cout, eq, gt, lt;
    wire [7:0] dec_out;

    top_combinational uut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout), .eq(eq), .gt(gt), .lt(lt), .dec_out(dec_out));

    initial begin
        a = 4'b1010; b = 4'b0101; cin = 1'b0; #10;
        a = 4'b0111; b = 4'b0001; cin = 1'b0; #10;
        a = 4'b0111; b = 4'b0000; cin = 1'b1; #10;
        a = 4'b1010; b = 4'b0101; cin = 1'b1; #10;
        a = 4'b1100; b = 4'b0001; cin = 1'b1; #10;
        a = 4'b1111; b = 4'b1111; cin = 1'b1; #10;
        a = 4'b0111; b = 4'b1111; cin = 1'b1; #10;
    end

endmodule