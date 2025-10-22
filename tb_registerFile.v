`timescale 1ns / 1ps

module tb_registerFile();

    // Inputs
    reg [4:0] rs, rt, rd;
    reg regWrite;
    reg [31:0] data;
    reg clk;

    // Outputs
    wire [31:0] regA, regB;

    // Instantiate the Unit Under Test (UUT)
    RegisterFile uut (
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .regWrite(regWrite),
        .data(data),
        .clk(clk),
        .regA(regA),
        .regB(regB)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 10ns clock period
    end

    // Test sequence
    initial begin
        $display("==============================================");
        $display(" Testbench for RegisterFile ");
        $display("==============================================");
        $display("Time | rd | data | rs | rt | regA | regB | regWrite");

        // Initialize signals
        rs = 0; rt = 0; rd = 0; data = 0; regWrite = 0;

        // Wait a little for setup
        #10;

        // -------------------------------------------------
        // Test 1: Write to $t1 (register 9)
        // -------------------------------------------------
        rd = 5'd9; data = 32'hABCD1234; regWrite = 1;
        #10;  // Wait for negedge
        regWrite = 0;

        // Read back from $t1
        rs = 5'd9; rt = 5'd9;
        #10;
        if (regA == 32'hABCD1234 && regB == 32'hABCD1234)
            $display("[%0t] PASS: reg[9] = %h", $time, regA);
        else
            $display("[%0t] FAIL: reg[9] expected %h, got %h", $time, 32'hABCD1234, regA);

        // -------------------------------------------------
        // Test 2: Try writing to $zero (register 0)
        // -------------------------------------------------
        rd = 5'd0; data = 32'hFFFFFFFF; regWrite = 1;
        #10;
        regWrite = 0;

        // Read back $zero
        rs = 5'd0; rt = 5'd0;
        #10;
        if (regA == 32'b0 && regB == 32'b0)
            $display("[%0t] PASS: $zero remained 0", $time);
        else
            $display("[%0t] FAIL: $zero was modified! regA=%h", $time, regA);

        // -------------------------------------------------
        // Test 3: Write to and read from another register ($s0 = reg16)
        // -------------------------------------------------
        rd = 5'd16; data = 32'h12345678; regWrite = 1;
        #10;
        regWrite = 0;

        // Read rs=16, rt=9 simultaneously
        rs = 5'd16; rt = 5'd9;
        #10;
        $display("[%0t] Read rs=16 -> %h | rt=9 -> %h", $time, regB, regA);

        // -------------------------------------------------
        // Test 4: Confirm $zero still intact at the end
        // -------------------------------------------------
        rs = 5'd0;
        #10;
        if (regB == 32'b0)
            $display("[%0t] PASS: $zero check final OK", $time);
        else
            $display("[%0t] FAIL: $zero modified!", $time);

        $display("==============================================");
        $display("Simulation finished.");
        $finish;
    end

endmodule
