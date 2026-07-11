module fir_filter(
    input clk,
    input signed [15:0] in,
    input ena,
    input reset,
    output signed [15:0] out
);

    // FIR Filter coefficients
    reg signed [15:0] coeff [0:31];

    // reads coefficients from a .hex file
    parameter COEFF_FILE = "../../../../../hex/test_coefficients.hex";    // default coefficients. my project files are in a separate folder one level further so i use an extra ..           
    initial begin
        $readmemh(COEFF_FILE, coeff);
    end

    wire signed [15:0] registers [31:0];
    // delay line
    genvar i;
    generate 
        for (i=0; i < 32; i = i + 1) begin
            register16bit r16(.clk(clk), .in((i==0) ? in : registers[i-1]), .ena(ena), .reset(reset), .data(registers[i]));
        end
    endgenerate

    // multiplier
    // the output of the multiplier has double the amount of bits as its inputs because
    // the max value of a 16-bit number is 2^16. this means that maximum number of bits needed 
    // for two 16-bit values is 2^16 * 2^16 = 2^32 or 32 bits. since it's signed 
    wire signed [31:0] mult_out [31:0];
    generate 
        for (i=0; i < 32; i = i + 1) begin
            multiplier mult(.clk(clk), .a(registers[i]), .b(coeff[i]), .ena(ena), .out(mult_out[i]));
        end
    endgenerate

    // accumulator
    // we only need 37 bits since the max value to come out of the sum is 2^32 * 2^5
    // for the 32 additions of a max value 32-bit number. using bits to give a little leeway
    reg signed [39:0] sum;
    always @(*) begin
        sum = 0;
        for (integer i=0; i<32; i=i+1) begin
            sum = sum + mult_out[i];
        end
    end

    // rounding
    // rather than rounding using a greater than or equal to operator(>), 
    // we check the MSB of the lower half of the sum. because the 
    reg signed [15:0] fixed_point_out;
    always @(*) begin
        if (sum[14]==1'b1) begin
            fixed_point_out = sum[30:15] + 1;
        end
        else begin
            fixed_point_out = sum[30:15];
        end
    end

    assign out = fixed_point_out;
    

endmodule