module dff_tb;
    reg clk, reset, d;
    wire q;

    my_dff uut(.clk(clk), .reset(reset), .d(d), .q(q));

    // generate clk
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        d = 1'b0; reset = 1'b0; #10;
        d = 1'b0; reset = 1'b1; #10;
        d = 1'b1; reset = 1'b0; #10;
        d = 1'b1; reset = 1'b1; #10;
        
        d = 1'b0; reset = 1'b0; #10;
        d = 1'b0; reset = 1'b1; #10;
        d = 1'b1; reset = 1'b0; #10;
        d = 1'b1; reset = 1'b1; #10;

        d = 1'b1; reset = 1'b0; #10;
        d = 1'b1; reset = 1'b1; #10;
        d = 1'b0; reset = 1'b0; #10;
        d = 1'b0; reset = 1'b1; #10;
    end

endmodule
