module counter4bit_tb;
    reg clk;
    reg enable;
    reg reset;
    wire [3:0] count;

    // setting up clock
    initial clk = 0;
    always #5 clk = ~clk;

    counter4bit uut(.clk(clk), .enable(enable), .reset(reset), .count(count));

    initial begin
        enable = 1'b0; reset = 1'b1; #20;
        enable = 1'b1; reset = 1'b0; #200;
        enable = 1'b0; reset = 1'b1; #20;
        enable = 1'b1; reset = 1'b0; #100;
        enable = 1'b0; reset = 1'b1; #20;
        enable = 1'b1; reset = 1'b0; #10;
    end

endmodule