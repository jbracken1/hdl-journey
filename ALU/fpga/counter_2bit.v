module counter_2bit(
    input clk,
    input ena,
    input reset,
    output [1:0] count   
);

    reg [1:0] c = 0;

    always @(posedge clk) begin
        if (reset)
            c <= 0;
        else if (ena)
            c <= c + 1;
    end

    assign count = c;
    
endmodule