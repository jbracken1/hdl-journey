module led_blink(
    input clk_100MHz,
    output [3:0] clk_1Hz
);

    reg [25:0] counter_reg = 0;
    reg [3:0] clk_out_reg = 0;

    always @(posedge clk_100MHz) begin
        if (counter_reg == 49_999_999) begin
            counter_reg <= 0;
            clk_out_reg <= clk_out_reg + 1;
        end
        else 
            counter_reg <= counter_reg + 1;
    end

    assign clk_1Hz = clk_out_reg;

endmodule