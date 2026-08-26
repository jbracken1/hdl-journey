// 32-tap FIR filter, fixed low-pass coefficients below.
// shifts in through the delay line, multiplies by coeffs, sums it all up and rounds
module fir_filter(
    input clk,
    input signed [15:0] in,
    input ena,
    input reset,
    output signed [15:0] out
);

    // FIR Filter coefficients
    reg signed [15:0] coeff [0:31];

    // Alternate: load coefficients from a .hex file instead of hardcoding them below.
    // Path is relative to this project's own folder, one level further than usual.
    // parameter COEFF_FILE = "../../../../../hex/test_coefficients.hex";
    // initial begin
    //     $readmemh(COEFF_FILE, coeff);
    // end

    initial begin
        coeff[ 0] = 16'hffca;
        coeff[ 1] = 16'hffc0;
        coeff[ 2] = 16'hffae;
        coeff[ 3] = 16'hff9f;
        coeff[ 4] = 16'hffa3;
        coeff[ 5] = 16'hffd1;
        coeff[ 6] = 16'h0042;
        coeff[ 7] = 16'h010a;
        coeff[ 8] = 16'h0232;
        coeff[ 9] = 16'h03b7;
        coeff[10] = 16'h0584;
        coeff[11] = 16'h0775;
        coeff[12] = 16'h095c;
        coeff[13] = 16'h0b05;
        coeff[14] = 16'h0c40;
        coeff[15] = 16'h0ce8;
        coeff[16] = 16'h0ce8;
        coeff[17] = 16'h0c40;
        coeff[18] = 16'h0b05;
        coeff[19] = 16'h095c;
        coeff[20] = 16'h0775;
        coeff[21] = 16'h0584;
        coeff[22] = 16'h03b7;
        coeff[23] = 16'h0232;
        coeff[24] = 16'h010a;
        coeff[25] = 16'h0042;
        coeff[26] = 16'hffd1;
        coeff[27] = 16'hffa3;
        coeff[28] = 16'hff9f;
        coeff[29] = 16'hffae;
        coeff[30] = 16'hffc0;
        coeff[31] = 16'hffca;
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

    integer j;
    reg signed [31:0] mult_reg [31:0];
    always @(posedge clk) begin
        for (j=0; j<32; j=j+1)
            mult_reg[j] <= mult_out[j];
    end

    // accumulator
    // we only need 37 bits since the max value to come out of the sum is 2^32 * 2^5
    // for the 32 additions of a max value 32-bit number. using bits to give a little leeway
    reg signed [39:0] sum;
    (* keep = "true" *) reg signed [39:0] sum_reg;

    integer k, m, n;
    // Can't use loop in assign, so use always @(*)
    reg signed [39:0] partial_sum_combA;
    always @(*) begin
        partial_sum_combA = 0;
        for (m=0; m<8; m=m+1)
            partial_sum_combA = partial_sum_combA + mult_reg[m];
    end

    // Register it
    (* keep = "true" *) reg signed [39:0] partial_sumA;
    always @(posedge clk)
        partial_sumA <= partial_sum_combA;

    reg signed [39:0] partial_sum_combB;
    always @(*) begin
        partial_sum_combB = partial_sumA;
        for (k=8; k<16; k=k+1)
            partial_sum_combB = partial_sum_combB + mult_reg[k];
    end

    // Register it
    (* keep = "true" *) reg signed [39:0] partial_sumB;
    always @(posedge clk)
        partial_sumB <= partial_sum_combB;

    
    // Stage 2 (combinational)
    always @(*) begin
        sum = partial_sumB;
        for (n=16; n<32; n=n+1)
            sum = sum + mult_reg[n];
    end

    always @(posedge clk) begin
        sum_reg <= sum;
    end

    // rounding
    // rather than rounding using a greater than or equal to operator(>), 
    // we check the MSB of the lower half of the sum. because the 
    reg signed [15:0] fixed_point_out;
    always @(*) begin
        if (sum_reg[14]==1'b1) begin
            fixed_point_out = sum_reg[30:15] + 1;
        end
        else begin
            fixed_point_out = sum_reg[30:15];
        end
    end

    assign out = fixed_point_out;
    

endmodule