module mux2to1_tb;

    reg [1:0] in;
    reg sel;
    wire out;

    mux2to1 uut(.in(in), .sel(sel), .out(out));

    initial begin
        in[1] = 0; in[0] = 0; sel = 0; #10;
        in[1] = 0; in[0] = 0; sel = 1; #10;
        in[1] = 0; in[0] = 1; sel = 0; #10;
        in[1] = 0; in[0] = 1; sel = 1; #10;
        in[1] = 1; in[0] = 0; sel = 0; #10;
        in[1] = 1; in[0] = 0; sel = 1; #10;
        in[1] = 1; in[0] = 1; sel = 0; #10;
        in[1] = 1; in[0] = 1; sel = 1; #10;
    end

endmodule