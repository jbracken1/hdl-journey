// top level for the fir demo, uart in -> filter -> uart out
module fir_top(
    input clk,
    input rx,
    output tx
);

    // // temporary 16 bit holding register
    reg [7:0] transmit_data;

    reg [15:0] fir_reg;


    // baud tick generator to time the tx and rx modules
    wire baud_pulse;

    pulse_generator baud_gen(.clk(clk), .max(27'd10), .reset(1'b0), .out(baud_pulse));

    // uart receive 
    wire [7:0] data;
    wire valid;

    uart_rx uart_rx_fir(.clk(clk), .baud_tick(baud_pulse), .rx_pin(rx), .rx_data({data}), .rx_valid(valid));

    // temporary 16 bit holding register
    reg [15:0] temp_in;
    reg input_ready = 1'b0;
    reg byte_sel = 1'b0;  // which half of the 16-bit word we're on, high byte then low byte

    always @(posedge clk) begin
        if (valid) begin
            if (byte_sel==0) begin
                temp_in [15:8] <= data;
                transmit_data [7:0] <= fir_reg[15:8];
            end
            else begin
                temp_in [7:0] <= data;
                transmit_data [7:0] <= fir_reg[7:0];
                input_ready <= 1'b1;
            end
            byte_sel <= byte_sel + 1;
        end

        if (input_ready) begin
            input_ready <= 1'b0;
        end
    end


    // resets fir delay line on bootup. holds reset high for 15 clock cycles
    reg reset = 1'b1;
    reg [3:0] res_count = 4'b0;
    always @(posedge clk) begin
        if (res_count < 15) begin
            res_count <= res_count + 1;
        end
        else begin 
            reset <= 1'b0;
        end
    end

    // fir filter 
    wire [15:0] fir_out;
    fir_filter fir(.clk(clk), .in(temp_in), .ena(input_ready), .reset(reset), .out(fir_out));

    always @(posedge clk) begin
        fir_reg <= fir_out;
    end

    // uart transmit
    wire tx_busy;
    uart_tx transmit(.clk(clk), .baud_tick(baud_pulse), .load_tx(~tx_busy && valid), .tx_data(transmit_data), .tx_pin(tx), .tx_busy(tx_busy));

endmodule