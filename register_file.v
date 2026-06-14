module register_file(
    input clk,
    input reg_write,
    input rst,
    input [1:0] rs1,
    input [1:0] rs2,
    input [1:0] rd,
    input [9:0] write_data,
    output [9:0] read_data1,
    output [9:0] read_data2
);

    reg [9:0] registers [3:0];
    
    assign read_data1 = registers[rs1];
    assign read_data2 = registers[rs2];
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            registers[0] <= 0;
            registers[1] <= 0;
            registers[2] <= 0;
            registers[3] <= 0;
        end
        else if (reg_write) begin
            registers[rd] <= write_data;
        end
    end


endmodule