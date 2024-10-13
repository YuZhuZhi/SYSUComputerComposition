`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/06 14:02:43
// Design Name: 
// Module Name: SignExtend
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


module SignExtend(
    input [15 : 0] InstructLow16bits,
    output reg [31 : 0] Data32bits
    );
    
    always@(*) begin
        Data32bits[15 : 0] <= InstructLow16bits;
        if (InstructLow16bits[15] == 0) Data32bits[31 : 16] <= 0;
        else Data32bits[31 : 16] <= 16'hFFFF;
    end
    
endmodule
