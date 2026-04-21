module ALU(
    input [7 : 0] inp1, inp2,
    input [2 : 0] opcode,
    output reg [7 : 0] out,
    output reg carry_out

);

    always @(*) begin
        out = 4'b00000000;
        carry_out = 1'b0;

        case(opcode)
            3'b000: {carry_out, out} = inp1 + inp2;        //{a, b}: concatenation, 1 bit from a is attached to the right of b, so a is the left most bit of a + b
            3'b001: out = inp1 - inp2;
            3'b010: out = inp1 & inp2;
            3'b011: out = inp1 | inp2;
            3'b100: out = inp1 ^ inp2;
            3'b101: out = ~inp1;
            default: out = 8'b00000000;
        endcase
    end
endmodule