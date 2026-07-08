module uart_tx_top(
    input clk,
    input button,
    input [7:0] sw,
    output tx,
    output tx_busy,
    output [7:0] led
);

    // parameter H = 8'h48, E = 8'h45, L = 8'h4c, O = 8'h4f, W = 8'h57, R = 8'h52, D = 8'h44;
    // parameter J = 8'h4a, A = 8'h41, C = 8'h43, K = 8'h4b, SPACE = 8'h20, DASH = 8'h2d;
    // reg [0:95] string = {H, E, L, L, O, SPACE, W, O, R, L, D, SPACE, DASH, SPACE, J, A, C, K};
    // reg [7:0] temp;

    wire baud_pulse;

    // debounces the load signal instead of directly connecting the button to the load pin
    reg button_prev = 1'b0;
    reg load_tx_pulse = 1'b0;

    always @(posedge clk) begin
        button_prev <= button;
        load_tx_pulse <= button && !button_prev;  // Edge detect: button goes 0 --> 1
    end

    pulse_generator baud_gen(.clk(clk), .max(27'd10_417), .reset(1'b0), .out(baud_pulse));
    uart_tx transmit(.clk(clk), .baud_tick(baud_pulse), .load_tx(load_tx_pulse), .tx_data(sw), .tx_pin(tx), .tx_busy(tx_busy));

    assign led = sw;

    // reg count = 0;
    // always @(posedge clk) begin
    //     if (!tx_busy) begin
    //         temp = string[count*8 : count*8 + 7];
    //         count = count + 1;
    //     end

    // end

endmodule