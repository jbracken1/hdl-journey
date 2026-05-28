module comparator4bit_tb;
    reg [3:0] a, b;
    wire eq, gt, lt;

    comparator4bit uut(.a(a), .b(b), .eq(eq), .gt(gt), .lt(lt));

    initial begin
        a = 4'b1000; b = 4'b0100; #10;
        a = 4'b0001; b = 4'b0011; #10;
        a = 4'b0010; b = 4'b0100; #10;
        a = 4'b1000; b = 4'b1000; #10;
        a = 4'b0100; b = 4'b0100; #10;
        a = 4'b1010; b = 4'b0011; #10;
    end

endmodule