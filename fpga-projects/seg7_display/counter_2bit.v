module counter_2bit(
    input ena,
    input reset,
    output [1:0] count   
);

    reg [1:0] c = 0;

    always @(posedge ena) begin
        if (reset)
            c <= 0;
        else 
            c <= c + 1;
    end

    assign count = c;
    
endmodule