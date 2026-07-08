`timescale 1ns / 1ps

module uart_tx_tb;
    reg clk;
    wire baud_tick;
    reg load_tx;
    reg [7:0] tx_data;
    wire tx_pin;
    wire tx_busy;

    // setting up clock
    initial clk = 0;
    always #5 clk = ~clk;

    pulse_generator baud_pulse(.clk(clk), .max(27'd5), .reset(1'b0), .out(baud_tick));

    uart_tx uut(.clk(clk), .baud_tick(baud_tick), .load_tx(load_tx), .tx_data(tx_data), .tx_pin(tx_pin), .tx_busy(tx_busy));

    integer i;
    reg [9:0] captured_bits;

    initial begin

        // loads the shift register 
        load_tx = 1'b1;
        tx_data = 8'b10101010;
        @(posedge clk);
        @(posedge clk);
        load_tx = 1'b0;
        $display("%s", (tx_busy) ? "TX busy" : "TX NOT busy");

        for (i=0; i <= 9; i = i + 1) begin
            @(posedge baud_tick);
            captured_bits[i] = tx_pin; 
        end 

        $display("%b", captured_bits);

        

        $finish;
        
    end

endmodule