module uart_rx(
    input clk,
    input baud_tick,
    input rx_pin,
    output [7:0] rx_data,
    output reg rx_valid
);

    wire shift_enable;
    wire shift_out;
    reg rx_prev;
    reg baud_prev;
    wire [7:0] shift_data;


    shift_register8bit sr8(.clk(clk), .input_bit(rx_pin), .in({10'b0}), .load(1'b0), .reset(1'b0), .ena(shift_enable), .register({rx_data}), .out(shift_out));


    parameter IDLE = 2'b00, RECEIVING = 2'b01;
    reg [1:0] state = IDLE;
    reg [3:0] count;

    always @(posedge clk) begin
        rx_prev <= rx_pin;
        baud_prev <= baud_tick;

        case (state)
            IDLE: begin
                rx_valid <= 1'b0;
                if (rx_prev && !rx_pin) begin
                    state <= RECEIVING;
                    count <= 0;
                end
            end
            RECEIVING: begin
                if (baud_tick) begin
                    count <= count + 1;
                    if (count==7) begin
                        state <= IDLE;
                        rx_valid <= rx_pin;
                    end
                end
            end
        endcase
    end

    assign shift_enable = (state==RECEIVING) && (baud_tick && !baud_prev);


    // always @(posedge clk) begin
    //     receiving_prev <= receiving;

    //     rx_prev <= rx_pin;
    //     if (!receiving) begin
    //         if (rx_prev != rx_pin) begin
    //             receiving <= 1'b1;

    //             count <= 0;
    //         end
    //     end
    //     else if (baud_tick) begin
    //         count <= count + 1;
    //         if (count == 9) begin
    //             // rx_data <= shift_data;
    //             receiving <= 1'b0;
    //         end
    //     end

    //     if (receiving_prev==1'b1 && receiving==1'b0) begin
    //         rx_valid <= rx_data[9] && !rx_data[0];
    //     end
    // end


endmodule