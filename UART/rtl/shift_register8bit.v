module shift_register8bit(
    input clk,
    input input_bit, 
    input [7:0] in,
    input load,
    input reset,
    input ena,
    output reg [7:0] register,
    output out
);

    assign out = register[0];

    always @(posedge clk) begin
        
        if (load) begin
            register <= in;
        end
        else if (ena) begin
            register[6:0] <= register[7:1];
            register[7] <= input_bit;
        end

        if (reset)
            register <= 1'b0;
    end

endmodule