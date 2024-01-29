module seq_detector(
    input input_x,
    input clock,
    input reset,
    output reg output_z
);

parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b011,
          S4 = 3'b100,
          S5 = 3'b101;

reg [2:0] current_state, next_state;

always @(posedge clock, posedge reset)
begin
    if (reset==1)
        current_state <= S0;
    else
        current_state <= next_state;
end

always @(current_state, input_x)
begin
    case (current_state)
	S0: begin
            if (input_x == 1)
                next_state <= S1;
            else
                next_state <= S0;
        end

        S1: begin
            if (input_x == 0)
                next_state <= S2;
            else
                next_state <= S1;
        end

        S2: begin
            if (input_x == 0)
                next_state <= S3;
            else
                next_state <= S1;
        end

        S3: begin
            if (input_x == 1)
                next_state <= S4;
            else
                next_state <= S0;
        end

        S4: begin
            if (input_x == 1)
                next_state <= S5;
            else
                next_state <= S2;
        end

        S5: begin
            if (input_x == 1)
                next_state <= S0;
            else
                next_state <= S1;
        end

        default: next_state <= S0;
    endcase
end

always @(current_state)
begin
    case (current_state)
        S0, S1, S2, S3, S4: output_z <= 0;
        S5: output_z <= 1;
        default: output_z <= 0;
    endcase
end

endmodule
