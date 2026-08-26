// bcd digit counter for the hours place, needs its own rollover/reset values
// since hours go 12 -> 1 instead of wrapping to 0 like the other digits
module bcd_count_hour (
    input clk,
    input reset,        // Synchronous active-high reset
    input rollover,
    input enable,
    input [3:0] peak,
    input [3:0] rollover_val,
    input [3:0] reset_val,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (enable) begin
            if (q==peak)
                q <= 0;
            else
                q <= q + 1;
        end
        if (rollover)
            q <= rollover_val;
        if (reset)
            q <= reset_val;
    end

endmodule