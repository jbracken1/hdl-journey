module fir_filter(
    input clk,
    input [15:0] in,
    input ena,
    input reset,
    output [15:0] out
);

    wire [15:0] registers [31:0];

    // delay line
    genvar i;
    generate 
        for (i=0; i < 32; i = i + 1) begin
            register16bit r16(.clk(clk), .in((i==0) ? in : registers[i-1]), .ena(ena), .reset(reset), .data(registers[i]));
        end
    endgenerate

    // multiplier

    // adder

    // rounding

    // temp
    assign out = 1'b0;
    

endmodule