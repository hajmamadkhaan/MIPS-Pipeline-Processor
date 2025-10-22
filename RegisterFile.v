`timescale 1ns / 1ps


module RegisterFile(
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input regWrite,
    input [31:0] data,
    input clk,
    output [31:0] regA,
    output [31:0] regB
    );

    reg [31:0] regs [31:0];
    
    integer i;
    initial begin
        for (i = 0; i < 32; i= i+1) begin
            regs[i] = 32'b0;
        end
    end
    
        
    always @(negedge clk) begin
        if (regWrite && (rd != 5'd0))
            regs[rd] <= data;
    end
    
    
    assign regA = regs[rt];
    assign regB = regs[rs];
    
endmodule
