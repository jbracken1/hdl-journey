module clock_divider(
    input clk,
    input [26:0] max,
    input reset,
    output out
);
    
    reg [26:0] count = 0;

    always @(posedge clk) begin        
        if (reset || count==max) begin
            count <= 0;
        end
        else
            count <= count + 1;
    end

    assign out = (count==max);

endmodule
