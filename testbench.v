module testbench;

reg [3 : 0] a;
reg [3 : 0] b;
reg [2 : 0] opcode;
wire [3 : 0] y;

ALU uut(
    .inp1(a),
    .inp2(b),
    .opcode(opcode),
    .out(y)
);
initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench);

    $monitor("Time=%0t | a=%b b=%b op=%b | y=%b", $time, a, b, opcode, y);

    a = 4'b0010; b = 4'b0001; opcode = 3'b000; #10;
    a = 4'b0011; b = 4'b0001; opcode = 3'b001; #10;
    a = 4'b1011; b = 4'b1001; opcode = 3'b010; #10;
    a = 4'b1011; b = 4'b0001; opcode = 3'b011; #10;
    a = 4'b0011; b = 4'b0001; opcode = 3'b100; #10;
    a = 4'b0011; b = 4'b0001; opcode = 3'b101; #10;

    $finish;
end

endmodule