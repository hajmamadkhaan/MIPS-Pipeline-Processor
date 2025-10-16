`timescale 1ns / 1ps

module tb_mux;

    // Testbench signals
    reg Select;
    reg [31:0] A, B;
    wire [31:0] Out;

    // Instantiate the DUT (Device Under Test)
    multiplexer uut (
        .Select(Select),
        .A(A),
        .B(B),
        .Out(Out)
    );

    // Test procedure
    initial begin
        $display("Time\tSelect\tA\t\t\tB\t\t\tOut");
        $monitor("%0dns\t%b\t%h\t%h\t%h", $time, Select, A, B, Out);

        // Initialize
        Select = 0; A = 32'hAAAA_AAAA; B = 32'h5555_5555; #10;
        Select = 1; #10;
        A = 32'hFFFF_0000; B = 32'h0000_FFFF; #10;
        Select = 0; #10;

        // Test with X input
        A = 32'hXXXX_XXXX; B = 32'h1111_1111; Select = 1'bx; #10;

        $finish;
    end

endmodule
