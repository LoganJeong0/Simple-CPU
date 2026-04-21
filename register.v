//This is a singular register
module register(
    input clk;
    input rst;                      //negatively asserted
    input [7 : 0] inp1;
    output reg [7 : 0] out;
)
    always @(posedge clk  or negedge rst) begin
        if(!rst) begin
            out <=  8'b00000000; 
        end else begin
            out <= inp1;
        end
        
    end
endmodule