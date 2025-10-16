`timescale 1ns / 1ps


module InstructionFetch(
    input wire clk,
    input wire [31:0] branchTarget,
    input wire muxSel,
    output wire [31:0] output_instr
    );

    wire [31:0] pc_in;
    wire [31:0] pc_out;
    wire [31:0] muxSourceA;
    
    multiplexer mux(
        .A(muxSourceA),
        .B(branchTarget),
        .Select(muxSel),
        .Out(pc_in)
    );
    
    pc programCounter(
        .pc_in(pc_in),
        .pc_out(pc_out),
        .clk(clk)
    );
    

    
    InstructionMemory imem(
        .clk(clk),
        .pc_out(pc_out),
        .output_instr(output_instr)
    );
    
    pc_plusFour pc_plusFour(
      .pc_out(pc_out),
      .muxSourceA(muxSourceA)
    );
    
    
endmodule
