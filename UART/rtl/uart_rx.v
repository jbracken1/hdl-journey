module uart_rx(
    input clk,
    input baud_tick,
    // input load_tx,
    // input [7:0] tx_data,
    input rx_pin,
    output [9:0] rx_data,
    // output reg rx_busy = 1'b0
    // output reg rx_valid = 1'b0
    output reg rx_valid
    // output start, 
    // output stop
);

    reg [3:0] count;
    wire shift_enable;
    // wire [9:0] shift_reg;
    wire shift_out;
    reg rx_prev;
    reg receiving = 1'b0;
    reg receiving_prev;
    // wire start, stop;
    // wire [7:0] shift_data;


    shift_register10bit sr10(.clk(clk), .input_bit(rx_pin), .in({10'b0}), .load(1'b0), .reset(1'b0), .ena(shift_enable), .register({rx_data}), .out(shift_out));

    // assign tx_pin = (tx_busy) ? shift_out : 1'b1;
    assign shift_enable = baud_tick && receiving; // && receiving

    always @(posedge clk) begin
        receiving_prev <= receiving;

        rx_prev <= rx_pin;
        if (!receiving) begin
            if (rx_prev != rx_pin) begin
                receiving <= 1'b1;

                count <= 0;
            end
        end
        else if (baud_tick) begin
            count <= count + 1;
            if (count == 9) begin
                // rx_data <= shift_data;
                receiving <= 1'b0;
            end
        end

        if (receiving_prev==1'b1 && receiving==1'b0) begin
            rx_valid <= rx_data[9] && !rx_data[0];
        end
    end

    // always @(posedge clk) begin
    //     rx
    //     if (!rx_busy) begin
    //         if (load_tx) begin
    //             tx_busy <= 1'b1;
    //             count <= 0;
    //         end
    //     end
    //     else if (baud_tick) begin
    //         count = count + 1;
    //         if (count == 9) begin
    //             tx_busy <= 1'b0;
    //         end
    //     end
    // end


endmodule