module memory(
    input write_enable;
    input read_enable;
    input clk;
    input [7 : 0] address;
    input [7 : 0] write_data;
    output reg [7 : 0] read_data;
);

reg [7 : 0] mem [255 : 0];

    always @(posedge clk) begin
        if (write_enable) begin
            mem[address] <= write_data
        end
    end

    always @(*) begin
        if (read_enable) begin
            read_data = mem[address];
        end else begin
            read_data = 8'b0;
        end
    end
endmodule