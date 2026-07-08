`timescale 1ns / 1ps

module uart_rx_tb;
    reg clk;
    wire baud_tick;
    reg rx_pin;

    wire [9:0] rx_data;
    wire rx_valid;
    // wire start, stop;

    // setting up clock
    initial clk = 0;
    always #5 clk = ~clk;

    pulse_generator baud_pulse(.clk(clk), .max(27'd5), .reset(1'b0), .out(baud_tick));

    uart_rx uut(.clk(clk), .baud_tick(baud_tick), .rx_pin(rx_pin), .rx_data(rx_data), .rx_valid(rx_valid));

    integer i;
    reg [9:0] data = 10'b1_00010001_0;

    initial begin

        // loads the shift register 
        rx_pin = 1'b1;
        @(posedge clk);
        @(posedge clk);
        rx_pin = data[0];
        @(posedge baud_tick);

        for (i=0; i <= 11; i = i + 1) begin
            rx_pin = data[i];
            @(posedge baud_tick);
        end 

        @(posedge clk);

        $display("%b", rx_data);
        $display("%s", rx_valid ? "RX valid" : "RX not valid");

        $finish;
        
    end

endmodule