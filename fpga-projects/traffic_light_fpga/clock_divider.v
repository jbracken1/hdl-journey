module clock_divider(
    input clk,
    input reset,
    output out
);
    
    reg [26:0] count = 0;

    always @(posedge clk) begin        
        if (reset || count==99_999_999) begin
            count <= 0;
        end
        else
            count <= count + 1;
    end

    assign out = (count==99_999_999);

endmodule
