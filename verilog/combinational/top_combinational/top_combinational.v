module top_combinational(input [3:0] a, b, input cin,
                         output [3:0] sum, output cout, eq, gt, lt,
                         output [7:0] dec_out);

    wire [3:0] sum_wire;

    adder4bit add(.a(a), .b(b), .cin(cin), .sum(sum_wire), .cout(cout));
    decoder3to8 dec(.in(sum_wire[2:0]), .out(dec_out));
    comparator4bit comp(.a(a), .b(b), .eq(eq), .gt(gt), .lt(lt));

    assign sum = sum_wire;

endmodule