module bcd_count (
    input clk,
    input reset,        // Synchronous active-high reset
    input enable,
    input [3:0] peak,
    output reg [3:0] q);
    
    always @(posedge clk) begin
        if (reset)
            q <= 0;
        else if (enable) begin
            if (q==peak)
                q <= 0;
            else 
                q <= q + 1;
        end
    end

endmodule