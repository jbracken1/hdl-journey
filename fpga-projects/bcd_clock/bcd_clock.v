module bcd_clock(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    wire hena0, hena1, mena0, mena1, sena1;
    wire rollover;
    
    assign rollover = hena0 && hh[7:4]==1 && hh[3:0]==2;
    
    always @(posedge clk) begin
        if (reset)
            pm <= 0;
        else if (hena0 && hh[7:4]==1 && hh[3:0]==1)
    		pm <= ~pm;
    end
    
    //hours
    bcd_count_hour h0(clk, reset, rollover, hena0, 4'h9, 1, 2, hh[3:0]);
    bcd_count_hour h1(clk, reset, rollover, hena1, 4'h9, 0, 1, hh[7:4]);
    
    assign hena0 = ena && mena1 && (mm[7:4]==4'h5);
    assign hena1 = ena && hena0 && (hh[3:0]==4'h9);
    
    // minutes
    bcd_count m0(clk, reset, mena0, 4'h9, mm[3:0]);
    bcd_count m1(clk, reset, mena1, 4'h5, mm[7:4]);
    
    assign mena0 = ena && sena1 && (ss[7:4]==4'h5);
    assign mena1 = ena && mena0 && (mm[3:0]==4'h9);
    
    // seconds
    bcd_count s0(clk, reset, ena, 4'h9, ss[3:0]);
    bcd_count s1(clk, reset, sena1, 4'h5, ss[7:4]);
    
    assign sena1 = ena && (ss[3:0]==4'h9);

endmodule