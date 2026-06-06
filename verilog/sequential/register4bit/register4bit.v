module register4bit(
    input clk,
    input reset,
    input [3:0] d,
    output [3:0] q
);

    my_dff d0(clk, reset, d[0], q[0]);
    my_dff d1(clk, reset, d[1], q[1]);
    my_dff d2(clk, reset, d[2], q[2]);
    my_dff d3(clk, reset, d[3], q[3]);

endmodule