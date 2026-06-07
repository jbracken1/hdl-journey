module traffic_light(
    input clk,
    input reset,
    input enable,
    output red,
    output green,
    output yellow
);

    parameter RED=0, YELLOW=1, GREEN=2;

    reg [1:0] next_state, state;

    always @(*) begin
        case (state)
            GREEN: next_state = enable ? YELLOW : GREEN;
            YELLOW: next_state = enable ? RED : YELLOW;
            RED: next_state = enable ? GREEN : RED;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= RED;
        else
            state <= next_state;
    end

    assign red = (state==RED);
    assign yellow = (state==YELLOW);
    assign green = (state==GREEN);

endmodule