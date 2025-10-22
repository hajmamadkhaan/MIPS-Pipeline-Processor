`timescale 1ns / 1ps

module tb_InstructionFetch;

    // Inputs to IF stage
    reg clk;
    reg [31:0] branchTarget;
    reg muxSel;

    // Internal wires to probe outputs (for visibility)
    // We'll declare them here by temporarily modifying IF to expose output_instr and pc_out
    // (or you can use hierarchical references like: uut.imem.output_instr)
    
    // Instantiate Unit Under Test (UUT)
    InstructionFetch uut (
        .clk(clk),
        .branchTarget(branchTarget),
        .muxSel(muxSel)
        .output_instr(output_instr),
        .pc_out(pc_out)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // toggle every 5 ns
    end

    // Test sequence
    initial begin
        // Monitor signals
        $monitor("Time=%0t | clk=%b | muxSel=%b | branchTarget=%h | pc_out=%h | output_instr=%h",
                  $time, clk, muxSel, branchTarget, uut.pc_out, uut.output_instr);

        // Initialize inputs
        muxSel = 0;
        branchTarget = 32'h0000_0010;

        // Let PC increment a few times normally (sequential flow)
        #12;  // a few clock edges
        #20;
        
        // Now simulate a branch taken
        muxSel = 1;  // select branch target
        #10;

        // Back to sequential
        muxSel = 0;
        #30;

        // Another branch target
        branchTarget = 32'h0000_0020;
        muxSel = 1;
        #10;

        // Continue normally again
        muxSel = 0;
        #20;

        // Finish simulation
        $finish;
    end

endmodule
