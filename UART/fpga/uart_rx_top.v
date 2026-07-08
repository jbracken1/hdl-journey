module uart_rx_top(
    input clk,
    input rx,
    output [7:0] data,
    output valid
);

    wire baud_pulse;
    wire stop, start;

    pulse_generator baud_gen(.clk(clk), .max(27'd10_417), .reset(1'b0), .out(baud_pulse));
    uart_rx uut(.clk(clk), .baud_tick(baud_pulse), .rx_pin(rx), .rx_data({stop, data, start}), .rx_valid(valid));

endmodule