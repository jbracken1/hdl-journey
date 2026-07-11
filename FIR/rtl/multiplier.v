module multiplier(
    input clk,
    input signed [15:0] a, b,
    input ena,
    output reg signed [31:0] out
);

    always @(posedge clk) begin
        if (ena)
            out <= a * b;
    end

endmodule