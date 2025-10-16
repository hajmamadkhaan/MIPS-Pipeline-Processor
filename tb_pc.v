`timescale 1ns / 1ps

module tb_pc;

    // Testbench signals
    reg clk;
    reg [31:0] pc_in;
    wire [31:0] pc_out;

    // Instantiate the DUT (Device Under Test)
    pc uut (
        .pc_in(pc_in),
        .pc_out(pc_out),
        .clk(clk)
    );

    // Generate clock signal (period = 10 ns)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // toggle every 5 ns ? 10 ns period
    end

    // Apply test values
    initial begin
        $display("Time\tclk\tpc_in\t\tpc_out");
        $monitor("%0dns\t%b\t%h\t%h", $time, clk, pc_in, pc_out);

        // Initialize
        pc_in = 32'h0000_0000;
        #10;  // wait for one clock

        // Change pc_in on each clock edge
        pc_in = 32'h0000_0004; #10;
        pc_in = 32'h0000_0008; #10;
        pc_in = 32'h0000_000C; #10;
        pc_in = 32'h0000_0010; #10;
        pc_in = 32'hABCD_1234; #10;

        $finish;
    end

endmodule