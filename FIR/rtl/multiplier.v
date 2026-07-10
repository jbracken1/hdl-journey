module multiplier(
    input clk,
    input [15:0] a, b,
    input ena,
    output reg [31:0] out
);

    always @(posedge clk) begin
        if (ena)
            out <= a * b;
    end

endmodule