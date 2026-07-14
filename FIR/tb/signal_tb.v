module signal_tb;
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
    parameter IS_FILE = "../../../../../hex/input_signal.hex";
    parameter OS_FILE = "../../../../../hex/output_signal.hex";
    reg signed [15:0] input_signal [0:1023];

    integer file;

    initial begin
        $readmemh(IS_FILE, input_signal);

        reset = 1'b1;
        ena = 1'b0;
        in = 16'b0;

        // two positive clock edges so that reset is properly recognized. 
        // otherwise, reset goes low before filter can process it
        @(posedge clk);
        @(posedge clk);
        reset = 1'b0;
        ena = 1'b1;

        file = $fopen(OS_FILE, "w");

        for (i=0; i<1024; i=i+1) begin
            in = input_signal[i];
            @(posedge clk);
            $fdisplay(file, "%h", out);  // Write hex value
        end
        $fclose(file);

        $finish;
    end

endmodule