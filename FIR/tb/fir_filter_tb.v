module fir_filter_tb;
    reg clk;
    reg [15:0] in;
    reg ena;
    reg reset;
    wire [15:0] out;

     // setting up clock
    initial clk = 0;
    always #5 clk = ~clk;

    // this .hex file has all coefficients = h7FFF which represents the max value for Q15. this represents 1
    // meaning all outputs should be equal to the magnitude of the impulse
    fir_filter #(.COEFF_FILE("../../../../../hex/test_coefficients.hex")) uut(.clk(clk), .in(in), .ena(ena), .reset(reset), .out(out));

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

        // impulse response with magnitude 1 
        in = 16'h2A;
        @(posedge clk);
        repeat (31) begin
            in = 16'b0;
            @(posedge clk);
            $display("out(in process): %h", out);
        end

        @(posedge clk);
        @(posedge clk);        
        $display("out: %h", out);

        $finish;
    end

endmodule