`timescale 1ns/1ns
module testbench;

reg clk;  
reg rst;
reg [15:0] instruction;


wire [1:0] re1;
wire [1:0] re2;
wire [1:0] reg_destination;
wire mem_read;
wire mem_write;
wire reg_write;
wire [2:0] ALU_op;
wire [9:0] load_in;
wire [9:0] re1_data;
wire [9:0] re2_data;

wire immediate_enable;
wire [9:0] immediate;
wire [9:0] mem_out;
wire [9:0] alu_out;


ALU alu0(
    .inp1(re1_data),
    .inp2(re2_data),
    .opcode(ALU_op),
    .out(alu_out)
);

decoder decode0(
    .instruction(instruction),
    .ALU_op(ALU_op),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .reg_write(reg_write),
    .immediate_enable(immediate_enable),
    .reg_destination(reg_destination),
    .re1(re1),
    .re2(re2),
    .immediate(immediate)
);

memory mem0(
    .write_enable(mem_write),
    .read_enable(mem_read),
    .clk(clk),
    .address(immediate),
    .write_data(re1_data),
    .read_data(mem_out)
);

assign load_in = immediate_enable ? immediate : mem_read ? mem_out : alu_out;

register_file regfile0(
    .clk(clk),
    .reg_write(reg_write),
    .rst(rst),
    .rs1(re1),
    .rs2(re2),
    .rd(reg_destination),
    .write_data(load_in),
    .read_data1(re1_data),
    .read_data2(re2_data)
);


initial begin
    clk = 0;

    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    rst = 1;
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench);

    $monitor(
        "T =%0t | R0 =%d | R1 =%d | R2 =%d | R3 =%d",
        $time,
        regfile0.registers[0],
        regfile0.registers[1],
        regfile0.registers[2],
        regfile0.registers[3],
    );

//TEST CASE
    
    instruction = 16'b1000000000000101; #10;            //LDI R0 5
    instruction = 16'b1000010000000011; #10;            //LDI R1 3
    instruction = 16'b0000100001000000; #10;            //ADD R2 (dest), R1, R0
    instruction = 16'b0001110001000101; #10;            //SUB R3 (dest), R1, R0
    instruction = 16'b0010110001000101; #10;            //AND R3 (dest), R1, R0
    instruction = 16'b0011110001000101; #10;            //OR R3 (dest), R1, R0
    instruction = 16'b0100110001000101; #10;            //XOR R3 (dest), R1, R0
    instruction = 16'b0101110001000101; #10;            //NOT R3 (dest), R1
    instruction = 16'b0111010000001010; #10;            //STORE R2 10
    instruction = 16'b0110110000001010; #10;            //LOAD R3 10
    rst = 0; #10;    //testing rst

    $finish;
end

endmodule