`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/06 15:17:32
// Design Name: 
// Module Name: JumpAddGenerator
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


module JumpAddGenerator(
    input [31 : 0] PC4High4bits,
    input [31 : 0] SL2Low28bits,
    output [31 : 0] Address_out
    );
    
    assign Address_out = {PC4High4bits[31 : 28], SL2Low28bits[27 : 0]};
    
endmodule
