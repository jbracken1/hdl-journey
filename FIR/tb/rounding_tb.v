module rounding_tb;
    reg clk;
    reg [15:0] in;
    reg ena;
    reg reset;
    wire [15:0] out;

     // setting up clock
    initial clk = 0;
    always #5 clk = ~clk;

    fir_filter uut(.clk(clk), .in(in), .ena(ena), .reset(reset), .out(out));

    integer i;

    initial begin
        reset = 1'b1;
        ena = 1'b0;
        in = 1'b0;

        // two positive clock edges so that reset is properly recognized. 
        // otherwise, reset goes low before filter can process it
        @(posedge clk);
        @(posedge clk);
        reset = 1'b0;
        ena = 1'b1;

        in = 16'b1;
        @(posedge clk);

        repeat (31) begin
            in = 1'b0;
            @(posedge clk);
        end

        @(posedge clk);
        @(posedge clk);        
        $display("sum: %b", uut.sum);


        $display("%s", uut.fixed_point_out==1 ? "Rounded" : "Not Rounded");
        $display("%h", uut.fixed_point_out);

        $finish;
    end

endmodule