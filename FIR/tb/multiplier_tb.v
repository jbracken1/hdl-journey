module multiplier_tb;
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
        in = 1'b1;

        // two positive clock edges so that reset is properly recognized. 
        // otherwise, reset goes low before filter can process it
        @(posedge clk);
        @(posedge clk);
        reset = 1'b0;
        ena = 1'b1;

        // @(posedge clk);
        for (i=0; i<32; i=i+1) begin
            in = i;
            $display("i: %h", in);
            $display("Register[0]: %h", uut.mult_out[0]);
            @(posedge clk);
            // @(posedge clk);
        end

        // needs 2 extra cycles to pass through the delay line into the multiplier
        @(posedge clk);
        @(posedge clk);

        for (i=0; i<32; i=i+1) begin
            $display("Register[%d]: %h", i, uut.mult_out[i]);
        end

        $finish;
    end

endmodule