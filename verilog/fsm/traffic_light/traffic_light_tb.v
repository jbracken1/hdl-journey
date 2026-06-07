module traffic_light_tb;
    reg clk;
    reg reset;
    reg enable;

    wire red;
    wire green;
    wire yellow;

    // setting up clock
    initial clk = 0;
    always #5 clk = ~clk;

    traffic_light uut(.clk(clk), .reset(reset), .enable(enable), .red(red), .green(green), .yellow(yellow));

    initial begin
        enable = 1'b0; reset = 1'b1; #20;
        enable = 1'b1; reset = 1'b0; #50;
        enable = 1'b0; reset = 1'b1; #10;
        enable = 1'b0; reset = 1'b0; #20;
        enable = 1'b1; reset = 1'b0; #30;
        enable = 1'b0; reset = 1'b0; #20;
    end

endmodule