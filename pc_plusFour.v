`timescale 1ns / 1ps


module pc_plusFour(

    input wire [31:0] pc_out,
    output wire [31:0] muxSourceA
    );
    
    assign muxSourceA = pc_out + 4;
endmodule