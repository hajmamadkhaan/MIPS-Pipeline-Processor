`timescale 1ns / 1ps


module pc(
    input wire [31:0] pc_in,
    output reg [31:0] pc_out,
    input wire clk
    );
    
    always @(posedge clk) begin
        pc_out = pc_in;
    end
endmodule
