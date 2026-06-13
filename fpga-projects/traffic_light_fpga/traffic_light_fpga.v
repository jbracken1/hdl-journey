module traffic_light_fpga(
    input clk,
    output red,
    output green,
    output yellow
);

    wire ena;

    wire reset = 1'b0;

    clock_divider cd(.clk(clk), .reset(reset), .out(ena));
    traffic_light tl(.clk(clk), .reset(reset), .enable(ena), .red(red), .green(green), .yellow(yellow));

endmodule 