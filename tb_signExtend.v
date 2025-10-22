`timescale 1ns / 1ps

module tb_signExtend();

    // Inputs
    reg [15:0] imm16;
    // Outputs
    wire [31:0] imm32;

    // Instantiate the Unit Under Test (UUT)
    SignExtend uut (
        .imm16(imm16),
        .imm32(imm32)
    );

    // Test procedure
    initial begin
        $display("==========================================");
        $display(" Testbench for SignExtend Module ");
        $display("==========================================");
        $display("Time(ns) | imm16 (hex) | imm32 (hex)");
        $display("------------------------------------------");

        // Test case 1: Positive number (no sign extension)
        imm16 = 16'h1234;
        #10;
        $display("%8t | %h | %h", $time, imm16, imm32);

        // Test case 2: Negative number (sign extension)
        imm16 = 16'hF234; // bit[15] = 1 ? should extend with 1s
        #10;
        $display("%8t | %h | %h", $time, imm16, imm32);

        // Test case 3: Most negative value
        imm16 = 16'h8000; // 1000 0000 0000 0000 ? -32768
        #10;
        $display("%8t | %h | %h", $time, imm16, imm32);

        // Test case 4: Zero
        imm16 = 16'h0000;
        #10;
        $display("%8t | %h | %h", $time, imm16, imm32);

        // Test case 5: Largest positive value
        imm16 = 16'h7FFF;
        #10;
        $display("%8t | %h | %h", $time, imm16, imm32);

        $display("------------------------------------------");
        $display("Simulation finished.");
        $finish;
    end

endmodule
