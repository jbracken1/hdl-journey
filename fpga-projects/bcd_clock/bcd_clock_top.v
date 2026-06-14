module bcd_clock_top(
    input clk,
    output reg [6:0] seg,
    output reg [3:0] an,
    output dp
);

    reg [3:0] reset_counter = 0;
    wire auto_reset = (reset_counter != 4'hF);

    always @(posedge clk) begin
        if (reset_counter != 4'hF)
            reset_counter <= reset_counter + 1;
    end

    wire [1:0] count;
    wire clk_1hz, clk_1khz;
    wire [6:0] seg0, seg1, seg2, seg3;

    clock_divider c1(.clk(clk), .max(1_666_666), .reset(1'b0), .out(clk_1hz));
    clock_divider c1k(.clk(clk), .max(99_999), .reset(1'b0), .out(clk_1khz));
    counter_2bit c2b(.clk(clk) , .ena(clk_1khz), .reset(1'b0), .count(count));

    wire [7:0] hours, minutes, seconds;

    bcd_clock bc(.clk(clk), .reset(auto_reset), .ena(clk_1hz), .pm(dp), .hh(hours), .mm(minutes), .ss(seconds));
    
    segment_decoder sd0(minutes[3:0], seg0);
    segment_decoder sd1(minutes[7:4], seg1);
    segment_decoder sd2(hours[3:0], seg2);
    segment_decoder sd3(hours[7:4], seg3);

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

endmodule
