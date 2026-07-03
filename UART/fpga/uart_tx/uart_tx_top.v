module uart_tx_top(
    input clk,
    input button,
    input [7:0] sw,
    output tx,
    output tx_busy,
    output [7:0] led
);

    wire baud_pulse;

    reg button_prev = 1'b0;
    reg load_tx_pulse = 1'b0;

    always @(posedge clk) begin
        button_prev <= button;
        load_tx_pulse <= button && !button_prev;  // Edge detect: button goes 0 --> 1
    end

    pulse_generator baud_gen(.clk(clk), .max(27'd10_417), .reset(1'b0), .out(baud_pulse));
    uart_tx transmit(.clk(clk), .baud_tick(baud_pulse), .load_tx(load_tx_pulse), .tx_data(sw), .tx_pin(tx), .tx_busy(tx_busy));

    assign led = sw;

endmodule