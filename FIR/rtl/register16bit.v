module register16bit(
    input clk,
    input signed [15:0] in,
    input ena,
    input reset,
    output reg signed [15:0] data
);

    always @(posedge clk) begin     
        if (ena) begin
            data <= in;
        end
        if (reset)
            data <= 1'b0;
    end

endmodule