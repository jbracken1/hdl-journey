module delay_line_tb;
    reg clk;
    reg signed [15:0] in;
    reg ena;
    reg reset;
    wire signed [15:0] out;

     // setting up clock
    initial clk = 0;
    always #5 clk = ~clk;

    fir_filter uut(.clk(clk), .in(in), .ena(ena), .reset(reset), .out(out));

    integer i;

    initial begin
        reset = 1'b1;
        @(posedge clk);
        @(posedge clk);
        reset = 1'b0;
        ena = 1'b1;

        for (i=0; i<32; i=i+1) begin
            $display("Register[%d]: %h", i, uut.registers[i]);
        end

        for (i=0; i<=32; i=i+1) begin
            in = i;
            @(posedge clk);
            @(posedge clk);
        end

        for (i=0; i<32; i=i+1) begin
            $display("Register[%d]: %h", i, uut.registers[i]);
        end

        $finish;
    end

endmodule