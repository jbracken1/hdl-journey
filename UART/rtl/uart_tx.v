module uart_tx(
    input clk,
    input baud_tick,
    input load_tx,
    input [7:0] tx_data,
    output tx_pin,
    output reg tx_busy = 1'b0
);

    reg [3:0] count;
    wire shift_enable;
    wire [9:0] shift_reg;
    wire shift_out;

    shift_register10bit sr10(.clk(clk), .in({1'b1, tx_data, 1'b0}), .load(load_tx), .reset(1'b0), .ena(shift_enable), .register(shift_reg), .out(shift_out));

    assign tx_pin = (tx_busy) ? shift_out : 1'b1;
    assign shift_enable = baud_tick && tx_busy;

    always @(posedge clk) begin
        if (!tx_busy) begin
            if (load_tx) begin
                tx_busy <= 1'b1;
                count <= 0;
            end
        end
        else if (baud_tick) begin
            count = count + 1;
            if (count == 9) begin
                tx_busy <= 1'b0;
            end
        end
    end


endmodule