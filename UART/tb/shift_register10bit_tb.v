module shift_register10bit_tb;
    reg clk;
    reg input_bit;
    reg [9:0] in;
    reg load;
    reg reset;
    reg ena;
    wire [9:0] register;
    wire out;

    // setting up clock
    initial clk = 0;
    always #5 clk = ~clk;

    shift_register10bit uut(.clk(clk), .input_bit(input_bit), .in(in), .load(load), .reset(reset), .ena(ena), .register(register), .out(out));

    initial begin
        ena = 1'b1; input_bit = 1'b0;
        in = 10'b0; load = 1'b0; reset = 1'b1; #10;
        in = 10'b1010101010; load = 1'b1; reset = 1'b0; #10;

        // ena = 1'b1; 
        in = 10'b0; load = 1'b0; reset = 1'b0; #50;

        ena = 1'b0; #40;
        
        input_bit = 1'b1;
        ena = 1'b1; #60;

        in = 10'b1011111011; load = 1'b1; reset = 1'b0; #10;
        in = 10'b0; load = 1'b0; reset = 1'b0; #50;
        in = 10'b0; load = 1'b0; reset = 1'b1; #10;
    end

endmodule