`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/25 16:55:38
// Design Name: 
// Module Name: Mux
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


module Mux(
    input Condition,
    input [31 : 0] Data1,
    input [31 : 0] Data2,
    output [31 : 0] Result
    );
    
    assign Result = (Condition == 0) ? Data1 : Data2;
    
endmodule
