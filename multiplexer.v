`timescale 1ns / 1ps


module multiplexer(
    input wire Select,
    input wire [31:0] A,
    input wire [31:0] B,
    output reg [31:0] Out
    );
    
    
    integer i = 0;
    always @(*) begin
        
//        Out <= Select ? B : A;
        if (~Select) Out = A;
        else Out = B;
        
        for (i = 0; i < 32; i = i + 1)
            if (A[i] === 1'bx || B[i] === 1'bx || Select === 1'bx)
                Out = 32'b0; 
        
    end
    
endmodule