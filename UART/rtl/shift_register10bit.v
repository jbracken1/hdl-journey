module shift_register10bit(
    input clk,
    input input_bit, 
    input [9:0] in,
    input load,
    input reset,
    input ena,
    output reg [9:0] register,
    output out
);

    assign out = register[0];

    always @(posedge clk) begin
        
        if (load) begin
            register <= in;
        end
        else if (ena) begin
            register[8:0] <= register[9:1];
            register[9] <= input_bit;
        end

        if (reset)
            register <= 1'b0;
    end

endmodule