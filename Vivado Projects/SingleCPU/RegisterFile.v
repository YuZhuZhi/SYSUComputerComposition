`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/24 23:16:04
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
    input CLK_in,
    input [4 : 0] RegRead1,
    input [4 : 0] RegRead2,
    input [4 : 0] RegWrite,
    input RegWrite_en,
    input RegDst,
    input [31 : 0] RegWriteData,
    output [31 : 0] ReadData1,
    output [31 : 0] ReadData2
    );
    
    reg [31 : 0] Reg [1 : 31];
    integer i;
    
    initial begin
        for (i = 0; i <= 31; i = i + 1) Reg[i] <= 0;
    end
    
    assign ReadData1 = (RegRead1 == 0) ? 0 : Reg[RegRead1];
    assign ReadData2 = (RegDst == 1) ? 1'bz : ((RegRead2 == 0) ? 0 : Reg[RegRead2]);
    
    always@(negedge CLK_in) begin
        if (RegWrite_en == 1 && RegWrite != 0) Reg[RegWrite] = RegWriteData;
    end
    
endmodule
