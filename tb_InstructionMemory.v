`timescale 1ns / 1ps

module tb_InstructionMemory;

    reg clk;
    reg [31:0] pc_out;
    wire [31:0] output_instr;

    // Instantiate DUT (Device Under Test)
    InstructionMemory uut (
        .clk(clk),
        .pc_out(pc_out),
        .output_instr(output_instr)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        pc_out = 0;
        #10;
        pc_out = 4;
        #10;
        pc_out = 8;
        #10;
        pc_out = 12;
        #10;
        pc_out = 16;
        #10;
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t | PC=%0d | Instruction=0x%08h", $time, pc_out, output_instr);
    end

endmodule
