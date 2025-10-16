`timescale 1ns / 1ps


module InstructionMemory(
    input wire clk,
    input wire [31:0] pc_out,
    output reg [31:0] output_instr
    );
    
    reg [7:0]Mem[255:0];
//    reg word_alignemnt;
    reg [31:0] temp;
    
    integer i;
    initial begin
        for (i = 0; i <= 255; i = i+1) begin
            Mem[i] = i[7:0];
        end    
    end
    
    always @(posedge clk) begin
        temp = {Mem[pc_out], Mem[pc_out + 1], Mem[pc_out + 2], Mem[pc_out + 3]};
    end
    
    always @(negedge clk) begin
        output_instr = temp;
    end
    
endmodule
