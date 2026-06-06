module register4bit_tb;
    reg clk, reset;
    reg [3:0] d;
    wire [3:0] q;

    register4bit uut(.clk(clk), .reset(reset), .d(d), .q(q));

    // generate clk
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        d = 4'hf; reset = 1'b0; #10;
        d = 4'h0; reset = 1'b0; #10;
        d = 4'he; reset = 1'b0; #10;
        d = 4'h1; reset = 1'b0; #10;

        d = 4'hf; reset = 1'b1; #10; 

        d = 4'hd; reset = 1'b0; #10;
        d = 4'h2; reset = 1'b0; #10;
        d = 4'hc; reset = 1'b0; #10;
        d = 4'h3; reset = 1'b0; #10;

        d = 4'ha; reset = 1'b1; #10;

        d = 4'hb; reset = 1'b0; #10;
        d = 4'h4; reset = 1'b0; #10;
        d = 4'ha; reset = 1'b0; #10;
        d = 4'h5; reset = 1'b0; #10;

        d = 4'h5; reset = 1'b1; #10;

        d = 4'h9; reset = 1'b0; #10;
        d = 4'h6; reset = 1'b0; #10;
        d = 4'h8; reset = 1'b0; #10;
        d = 4'h7; reset = 1'b0; #10;
    end

endmodule