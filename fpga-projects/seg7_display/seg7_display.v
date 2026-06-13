module seg7_display(
    input clk,
    input [15:0] sw,
    output reg [6:0] seg,
    output reg [3:0] an,
    output dp
);

    wire [1:0] count;
    wire ena;
    wire [6:0] seg0, seg1, seg2, seg3;

    clock_divider div(.clk(clk), .reset(1'b0), .out(ena));
    counter_2bit c2b(.ena(ena), .reset(1'b0), .count(count));
    
    segment_decoder sd0(sw[3:0], seg0);
    segment_decoder sd1(sw[7:4], seg1);
    segment_decoder sd2(sw[11:8], seg2);
    segment_decoder sd3(sw[15:12], seg3);

    // segments
    always @(*) begin
        case(count[1:0])
            2'b00: seg = seg0;
            2'b01: seg = seg1;
            2'b10: seg = seg2;
            2'b11: seg = seg3;
        endcase
    end

    // anode 
    always @(*) begin
        an = 4'b1111;
        case(count[1:0])
            2'b00: an[0] = 1'b0;
            2'b01: an[1] = 1'b0;
            2'b10: an[2] = 1'b0;
            2'b11: an[3] = 1'b0;
        endcase
    end

    assign dp = 1'b1;

endmodule
