module memory(
    input write_enable,
    input read_enable,
    input clk,
    input [9:0] address,
    input [9:0] write_data,
    output reg [9:0] read_data
);
    reg [9:0] mem [1023:0];

    always @(posedge clk) begin
        if (write_enable) begin
            mem[address] <= write_data;
        end
    end

    always @(*) begin
        if (read_enable) begin
            read_data = mem[address];
        end else begin
            read_data = 10'b0;
        end
    end
endmodule