`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/12 13:19:47
// Design Name: 
// Module Name: Andlogic
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


module Andlogic(
    input CLK,
    input Data1,
    input Data2,
    output reg Result
    );
    
    always@(posedge CLK) begin
        Result <= Data1 && Data2;
    end
    
endmodule
