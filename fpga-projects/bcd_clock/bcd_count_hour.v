module bcd_count_hour (
    input clk,
    input reset,        // Synchronous active-high reset
    input rollover,
    input enable,
    input [3:0] peak,
    input [3:0] rolloverVal,
    input [3:0] resetVal,
    output reg [3:0] q);
    
    always @(posedge clk) begin
        if (enable) begin
            if (q==peak)
                q <= 0;
            else
                q <= q + 1;
        end
        if (rollover)
            q <= rolloverVal;
        if (reset)
            q <= resetVal;
    end

endmodule