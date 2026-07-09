module delay_line_tb;
    reg clk;
    reg [15:0] in;
    reg ena;
    reg reset;
    wire [15:0] out;

    // reg [15:0] registers [31:0];

     // setting up clock
    initial clk = 0;
    always #5 clk = ~clk;

    fir_filter uut(.clk(clk), .in(in), .ena(ena), .reset(1'b0), .out(out));

    integer i;

    initial begin
        // reset = 1'b1;
        // @(posedge clk);
        // reset = 1'b0;

        ena = 1'b1;

        for (i=0; i<=32; i=i+1) begin
            in = i;
            @(posedge clk);
        end

        for (i=0; i<32; i=i+1) begin
            $display("Register[%d]: %h", i, uut.registers[i]);
        end

        $finish;

        // in = 32'hABCD;
        // repeat (10) @(posedge clk);
    end

endmodule