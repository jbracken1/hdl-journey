module accumulator_tb;
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

        for (i=0; i<32; i=i+1) begin
            in = 1'b1;
            @(posedge clk);
        end

        @(posedge clk);
        @(posedge clk);        
        $display("sum: %h", uut.sum);

        for (i=0; i<32; i=i+1) begin
            in = 16'h7FFF;
            @(posedge clk);
        end

        @(posedge clk);
        @(posedge clk);        
        $display("sum: %b", uut.sum);

        $finish;
    end

endmodule