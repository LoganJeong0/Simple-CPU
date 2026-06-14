module decoder(
   input [15:0] instruction,
   output reg [2:0] ALU_op,
   output reg mem_read,
   output reg mem_write,
   output reg reg_write,
   output reg immediate_enable,
   output reg [1:0] reg_destination,
   output reg [1:0] re1,
   output reg [1:0] re2,
   output reg [9:0] immediate
);

always @(*) begin
    ALU_op = 0;         //default values
    mem_read = 0;
    mem_write = 0;
    reg_write = 0;
    immediate_enable = 0;

    reg_destination = instruction[11:10];
    re1 = instruction[9:8];
    re2 = instruction[7:6];
    immediate = instruction[9:0];



    case (instruction[15:12])
        4'b0000: begin              //add
            ALU_op = 3'b000;
            reg_write = 1;
        end

        4'b0001: begin
            ALU_op = 3'b001;             //sub
            reg_write = 1;
        end
        
        4'b0010: begin              //and
            ALU_op = 3'b010;
            reg_write = 1;
        end

        4'b0011: begin              //or
            ALU_op = 3'b011;
            reg_write = 1;
        end

        4'b0100: begin              //xor
            ALU_op = 3'b100;
            reg_write = 1;
        end        

        4'b0101: begin              //not
            ALU_op = 3'b101;
            reg_write = 1;
        end

        4'b0110: begin             //load (memory to register)
            mem_read = 1;
            reg_write = 1;
        end

        4'b0111: begin             //store (register to memory)
            re1 = instruction[11:10];
            mem_write = 1;
        end

        4'b1000: begin             //LDI
            immediate_enable = 1;
            reg_write = 1;
        end
    endcase
end

endmodule
