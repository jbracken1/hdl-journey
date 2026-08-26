// sends two bytes over uart and captures the transmitted response to check it comes back out
module fir_top_tb;
    reg clk;
    reg rx;
    wire tx;

    // setting up clock
    initial clk = 0;
    always #5 clk = ~clk;

    fir_top uut(.clk(clk), .rx(rx), .tx(tx));

    integer i, j;
    reg [7:0] data;

    initial begin
        data = 8'h7f;
        rx = 1'b1;
        @(posedge clk);
        @(posedge clk);

        @(posedge uut.baud_pulse);
        @(posedge uut.baud_pulse);


        for (j=0; j < 32; j=j+1) begin
            data = j<2 ? (j%2==0 ? 8'hab : 8'hcd) : 0;
            rx = 0;
            @(posedge uut.baud_pulse);
            for (i=0; i < 8; i = i + 1) begin
                rx = data[i];
                @(posedge uut.baud_pulse);
            end 
            rx = 1;
            @(posedge uut.baud_pulse);
        end

        repeat(10) @(posedge uut.baud_pulse);
    end


    parameter START = 2'b00, IDLE = 2'b01, END = 2'b10;
    reg [1:0] state = IDLE;
    reg [9:0] tx_out;
    reg tx_busy_prev;
    reg [3:0] count = 0;

    always @(posedge clk) begin
        tx_busy_prev <= uut.tx_busy;

        case (state) 
            IDLE: begin
                if (!tx_busy_prev && uut.tx_busy) begin
                    state <= START;
                end
            end
            START: begin
                if (tx_busy_prev && !uut.tx_busy) begin
                    state <= END;
                end
            end
            END: begin
                state <= IDLE;            
            end
        endcase

    end

    always @(posedge clk) begin

        case (state) 
            START: begin
                if (uut.baud_pulse) begin
                    tx_out[count] <= tx;
                    count <= count + 1;
                end
            end
            END: begin
                $display("%h", tx_out[8:1]);   
                count <= 0;       
            end
        endcase
    end

endmodule