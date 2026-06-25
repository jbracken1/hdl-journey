module shift_register10bit(
    input clk,
    input [9:0] in,
    input load,
    input reset,
    output reg [9:0] register,
    output reg out
);

    always @(posedge clk) begin
        
        if (load)
            register <= in;
        else begin
            out <= register[0];
            register[8:0] <= register[9:1];
            register[9] <= 1'b0;
        end

        if (reset)
            register <= 1'b0;
    end

endmodule