`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/18 17:01:26
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input [3 : 0] ALUControl,
    input [31 : 0] Src1,
    input [31 : 0] Src2,
    output reg [31 : 0] Result,
    output ZF,
    output SF
    );
    
    always@(*) begin
        case (ALUControl)
            4'b0000: Result = Src1 & Src2;
            4'b0001: Result = Src1 | Src2;
            4'b0010: Result = Src1 + Src2;
            4'b0110: Result = Src1 - Src2;
            4'b0111: Result = (Src1 < Src2) ? 1 : 0;
            4'b1100: Result = Src1 << Src2[10 : 6];
            default: Result = 32'bz;
        endcase
    end
    
    assign ZF = (Src1 == Src2 ) ? 1 : 0;
    assign SF = Result[0];
    
endmodule
